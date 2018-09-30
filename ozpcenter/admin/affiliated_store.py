from django.contrib import admin
from django.utils.html import format_html
from ozpcenter import models





@admin.register(models.AffiliatedStore)
class AffiliatedStoreAdmin(admin.ModelAdmin):

    def show_server_url(self, obj):
        return format_html("<a href='{url}'>{url}</a>", url=obj.server_url)
    show_server_url.short_description = 'Server Url'
    show_server_url.allow_tags = True

    search_fields = ('title', 'server_url', 'is_enabled')
    list_display  = ('title', 'show_server_url', 'is_enabled')
