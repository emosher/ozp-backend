import io
import logging
import os
import uuid

import PIL
from PIL import Image as PilImage
from django.db import models
from django.db.models.signals import post_delete
from django.db.models.signals import post_save
from django.dispatch import receiver

from ozp.storage import media_storage
from ozpcenter import constants
from plugins.plugin_manager import system_has_access_control
from .external_model import ExternalModel
from .image_type import ImageType

logger = logging.getLogger('ozp-center.' + str(__name__))


class AccessControlImageManager(models.Manager):
    """
    Custom manager to control access to Images
    """

    def apply_select_related(self, queryset):
        queryset = queryset.select_related('image_type')
        return queryset

    def get_queryset(self):
        queryset = super(AccessControlImageManager, self).get_queryset()
        queryset = self.apply_select_related(queryset)
        return queryset

    def for_user(self, username):
        """
        This method causes:
        sqlite3.OperationalError: too many SQL variables
        To fix this error, post filtering in memory needs to happen

        Example Code:
            serializer = serializers.ImageSerializer(queryset, many=True, context={'request': request})
            serializer_iterator = recommend_utils.ListIterator(serializer.data)
            pipeline_list = [pipes.ListingDictPostSecurityMarkingCheckPipe(request.user.username)]

            recommended_listings = pipeline.Pipeline(serializer_iterator, pipeline_list).to_list()
        """
        objects = super(AccessControlImageManager, self).get_queryset()

        # filter out listings by user's access level
        images_to_exclude = []
        for i in objects:
            if not system_has_access_control(username, i.security_marking):
                images_to_exclude.append(i.id)
        objects = objects.exclude(id__in=images_to_exclude)

        return objects


class Image(ExternalModel):
    """
    Image
    Uploaded images are stored using media_storage (MediaFileStorage/MediaS3Storage)

    When creating a new image, use the Image.create_image method, do not
    use the Image.save() directly

    Note that these images are access controlled, and as such cannot simply
    be statically served
    """
    # this is set automatically by the create_image method
    # TODO: we don't use this, but removiing it causes problems (unit tests
    # segfault. keeping it around doesn't hurt anything, and it could be
    # useful later)
    uuid = models.CharField(max_length=36, unique=True)
    security_marking = models.CharField(max_length=1024)
    file_extension = models.CharField(max_length=16, default='png')
    image_type = models.ForeignKey(ImageType, related_name='images')

    objects = AccessControlImageManager()

    def __repr__(self):
        return 'Image({})'.format(self.id)

    def __str__(self):
        return 'Image({})'.format(self.id)

    @staticmethod
    def create_image(pil_img, **kwargs):
        """
        Given an image (PIL format) and some metadata, then
        - Create database entry
        - Write to media_storage

        TODO: raise exception and remove file and database entry
        TODO: check width and height

        Args:
            pil_img: PIL.Image (see https://pillow.readthedocs.org/en/latest/reference/Image.html)
        """
        TEST_MODE = bool(os.getenv('TEST_MODE', False))

        exception = None
        saved_to_db = False

        random_uuid = str(uuid.uuid4())
        security_marking = kwargs.get('security_marking', 'UNCLASSIFIED')
        file_extension = kwargs.get('file_extension', 'png')
        valid_image_types = constants.VALID_IMAGE_TYPES

        if file_extension not in valid_image_types:
            logger.error('Invalid image type: {0!s}'.format(file_extension))
            exception = Exception('Invalid Image Type, Valid Image type: {}'.format(valid_image_types))

        image_type_obj = kwargs.get('image_type_obj')

        if image_type_obj:
            image_type = image_type_obj
        else:
            image_type = kwargs.get('image_type')
            if not image_type:
                logger.error('No image_type provided')
                exception = Exception('Missing Image Type')
            image_type = ImageType.objects.get(name=image_type)

        # create database entry
        image_object = Image(uuid=random_uuid,
                             security_marking=security_marking,
                             file_extension=file_extension,
                             image_type=image_type)
        image_object.save()
        saved_to_db = True
        # write the image to the file system
        # prefix_file_name = pil_img.fp.name.split('/')[-1].split('.')[0].replace('16','').replace('32','').replace('Featured','')  # Used for export script
        prefix_file_name = str(image_object.id)
        file_name = prefix_file_name + '_' + image_type.name + '.' + file_extension
        ext = os.path.splitext(file_name)[1].lower()
        try:
            current_format = PIL.Image.EXTENSION[ext]
        except KeyError:
            exception = ValueError('unknown file extension: {}'.format(ext))

        if image_object.image_type.name == 'small_icon':
            pil_img = pil_img.resize((16, 16), PilImage.ANTIALIAS)
        elif image_object.image_type.name == 'large_icon':
            pil_img = pil_img.resize((32, 32), PilImage.ANTIALIAS)
        elif image_object.image_type.name == 'banner_icon':
            pil_img = pil_img.resize((220, 137), PilImage.ANTIALIAS)

        # TODO Figure out how to increase Performance on pil_img.save(***)
        # With io.BytesIO(): Sample Data Generator took: 16109.5576171875 ms
        # Commenting out io.BytesIO() - Sample Data Generator took: 34608.710693359375 ms

        if TEST_MODE:
            # Ignore saving file for Tests
            pass
        else:
            image_binary = io.BytesIO()
            pil_img.save(image_binary, format=current_format)

            # image_binary.seek(0)
            size_bytes = image_binary.tell()

            # TODO: PIL saved images can be larger than submitted images.
            # To avoid unexpected image save error, make the max_size_bytes
            # larger than we expect
            if size_bytes > (image_type.max_size_bytes * 2):
                logger.error('Image size is {0:d} bytes, which is larger than the max \
                    allowed {1:d} bytes'.format(size_bytes, 2 * image_type.max_size_bytes))
                exception = Exception('Image Size too big')

        if exception:
            if saved_to_db:
                image_object.delete()
            raise exception

        if TEST_MODE:
            # Ignore saving file for Tests
            pass
        else:
            media_storage.save(file_name, image_binary)
        return image_object


@receiver(post_save, sender=Image)
def post_save_image(sender, instance, created, **kwargs):
    pass


@receiver(post_delete, sender=Image)
def post_delete_image(sender, instance, **kwargs):
    pass
