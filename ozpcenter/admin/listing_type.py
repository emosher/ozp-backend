from django.contrib import admin
from django.urls import reverse
from django.utils.html import format_html
from ozpcenter import models






class ListingsInline(admin.StackedInline):
    model           = models.Listing
    fields          = ('title',  'listing_type')
    readonly_fields = ['title', 'listing_type']
    list_per_page   = 1
    extra           = 5
    can_delete      = False


@admin.register(models.ListingType)
class ListingTypeAdmin(admin.ModelAdmin):

    # Can be added to list_display to have links to all associated listings
    def listings(self):
        listings = models.Listing.objects.filter(listing_type__id=self.id)
        html = ""
        if listings:
            for obj in listings:
                url = reverse("admin:ozpcenter_listing_change", args=[obj.id])
                html += '<p><a href="%s">%s</a></p>' % (url, obj.title)
        return html
    listings.allow_tags = True

    def associated_listings(self):
        return models.Listing.objects.filter(listing_type__id=self.id).exists()
    associated_listings.boolean = True

    fields        = ('title', 'description', 'custom_fields')
    search_fields = ('title', 'description')
    list_display  = ('title', 'description', listings)
    inlines       = (ListingsInline, )
