from django.core.exceptions import ValidationError
from django.core.validators import RegexValidator
from django.db import models

from ozpcenter import constants
from .contact_type import ContactType
from .external_model import ExternalModel


class ContactManager(models.Manager):
    """
    Contact Manager
    """

    def apply_select_related(self, queryset):
        queryset = queryset.select_related('contact_type')
        return queryset

    def get_queryset(self):
        queryset = super(ContactManager, self).get_queryset()
        queryset = self.apply_select_related(queryset)
        return queryset

    def get_base_queryset(self):
        return super().get_queryset()


class Contact(ExternalModel):
    """
    A contact for a Listing

    TODO: Auditing for create, update, delete
    """
    secure_phone = models.CharField(
        max_length=50,
        validators=[
            RegexValidator(
                regex=constants.PHONE_REGEX,
                message='secure_phone must be a valid phone number',
                code='invalid phone number')],
        null=True,
        blank=True
    )
    unsecure_phone = models.CharField(
        max_length=50,
        validators=[
            RegexValidator(
                regex=constants.PHONE_REGEX,
                message='unsecure_phone must be a valid phone number',
                code='invalid phone number')],
        null=True,
        blank=True
    )
    email = models.CharField(
        max_length=100,
        validators=[
            RegexValidator(
                regex=constants.EMAIL_REGEX,
                message='email must be a valid address',
                code='invalid email')]
    )
    name = models.CharField(max_length=100)
    organization = models.CharField(max_length=100, null=True)
    contact_type = models.ForeignKey(ContactType, related_name='contacts')
    objects = ContactManager()

    def clean(self):
        if not self.secure_phone and not self.unsecure_phone:
            raise ValidationError({'secure_phone': 'Both phone numbers cannot be blank'})

    def __repr__(self):
        val = '{0!s}, {1!s}'.format(self.name, self.email)
        val += 'organization {0!s}'.format((
            self.organization if self.organization else ''))
        val += 'secure_phone {0!s}'.format((
            self.secure_phone if self.secure_phone else ''))
        val += 'unsecure_phone {0!s}'.format((
            self.unsecure_phone if self.unsecure_phone else ''))

        return val

    def __str__(self):
        return '{0!s}: {1!s}'.format(self.name, self.email)
