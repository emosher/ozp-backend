# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ozpcenter', '0030_recommendationfeedback'),
    ]

    operations = [
        migrations.AddField(
            model_name='notification',
            name='notification_subtype',
            field=models.CharField(default='system', null=True, max_length=36, choices=[('listing_new', 'listing_new'), ('listing_review', 'listing_review'), ('listing_private_status', 'listing_private_status'), ('pending_deletion_request', 'pending_deletion_request'), ('pending_deletion_cancellation', 'pending_deletion_cancellation'), ('subscription_category', 'subscription_category'), ('subscription_tag', 'subscription_tag')]),
        ),
    ]
