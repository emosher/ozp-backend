from django.contrib import admin

from ozpcenter import models


@admin.register(models.CustomFieldType)
class CustomFieldTypeAdmin(admin.ModelAdmin):
    ordering = ['display_name']
    search_fields = ['display_name', 'media_type', 'options']
    list_display = ['display_name', 'name', 'media_type']
