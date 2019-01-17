"""
Models for use with the Admin interface

Available at /admin

run python manage.py createsuperuser to create an admin user/password
"""
from django.contrib import admin
from ozpcenter import models

# Register models for admin interface
# Uncommented admin registers moved to separate file
# admin.site.register(models.AffiliatedStore, AffiliatedStoreAdmin)
admin.site.register(models.Agency)
admin.site.register(models.ApplicationLibraryEntry)
admin.site.register(models.Category)
admin.site.register(models.ChangeDetail)
admin.site.register(models.Contact)
admin.site.register(models.ContactType)
# admin.site.register(models.CustomField)
# admin.site.register(models.CustomFieldType)
admin.site.register(models.CustomFieldValue)
admin.site.register(models.DocUrl)
admin.site.register(models.Image)
admin.site.register(models.ImageType)
# admin.site.register(models.ImportTask)
# admin.site.register(models.ImportTaskResult)
admin.site.register(models.Intent)
# admin.site.register(models.Listing)
admin.site.register(models.ListingActivity)
# admin.site.register(models.ListingType)
admin.site.register(models.Notification)
admin.site.register(models.NotificationMailBox)
admin.site.register(models.Profile)
admin.site.register(models.RecommendationsEntry)
admin.site.register(models.Review)
admin.site.register(models.Screenshot)
admin.site.register(models.Subscription)
admin.site.register(models.Tag)
