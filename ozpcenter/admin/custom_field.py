from django.contrib import admin

from ozpcenter import models


class ListingTypesInline(admin.TabularInline):
    model = models.ListingType.custom_fields.through
    verbose_name = "Listing Type"
    verbose_name_plural = "Listing Types"


class ListingTypeListFilter(admin.SimpleListFilter):
    title = "Listing Type"
    parameter_name = 'listing_type'
    default_value = None

    def lookups(self, request, model_admin):
        listing_type_list = []
        queryset = models.ListingType.objects.all()
        for listing_type in queryset:
            listing_type_list.append(
                (str(listing_type.id), listing_type.title)
            )
        return sorted(listing_type_list)

    def queryset(self, request, queryset):
        if self.value():
            return queryset.filter(custom_listing_field__id=self.value())
        return queryset


@admin.register(models.CustomField)
class CustomFieldAdmin(admin.ModelAdmin):
    readonly_fields = ("import_metadata",)

    list_filter = ('display_name', 'type', ListingTypeListFilter)

    list_display = ('display_name', 'listing_types')

    search_fields = ('display_name',)

    inlines = (ListingTypesInline,)

    def listing_types(self, instance):
        listing_types = models.ListingType.objects.filter(custom_fields__id=instance.id)
        return ", ".join([
            listing_type.title for listing_type in listing_types
        ])

    listing_types.short_description = "Listing Types"
