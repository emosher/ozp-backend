"""
Image Model Access
"""
import logging

from ozpcenter import models


logger = logging.getLogger('ozp-center.' + str(__name__))


def get_all_images():
    """
    Get all the images

    IMPORTANT: To filtering based on security_marking

    Returns
        image objects (metadata), not actual images
    """
    return models.Image.objects.all()


def get_all_image_types():
    """
    Get all the image types
    """
    return models.ImageType.objects.all()


def get_image_by_id(id):
    """
    Get an image by id

    Since this is effectively only metadata about the image and not the image
    itself, access control is not enforced here. That is done when the image
    itself is served
    """
    try:
        return models.Image.objects.get(id=id)
    except models.Image.DoesNotExist:
        return None
