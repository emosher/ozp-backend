from django.contrib import admin
from ozpcenter import models





@admin.register(models.Listing)
class ListingAdmin(admin.ModelAdmin):
    
    search_fields = ('title', 'id', 'description',
        'description_short')

    list_display = ('title', 'listing_type', 'approval_status', 'is_enabled',
        'is_featured', 'is_exportable', 'is_deleted',
        'edited_date', 'last_activity')

    list_filter = ('approval_status', 'is_enabled', 'is_featured', 'is_exportable')

    readonly_fields = ['total_rate5', 'total_rate4', 'total_rate3',
        'total_rate2', 'total_rate1', 'avg_rate', 'total_votes',
        'total_reviews', 'total_review_responses', 'approved_date',
        'featured_date', 'last_activity', 'edited_date'
    ]

    list_per_page = 20
