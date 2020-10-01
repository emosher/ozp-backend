# -*- coding: utf-8 -*-
# Generated by Django 1.11.5 on 2017-10-27 19:48
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ozpcenter', '0032_listing_feedback_score'),
    ]

    operations = [
        migrations.AlterField(
            model_name='notification',
            name='notification_subtype',
            field=models.CharField(choices=[('listing_new', 'listing_new'), ('listing_review', 'listing_review'), ('listing_private_status', 'listing_private_status'), ('pending_deletion_request', 'pending_deletion_request'), ('pending_deletion_cancellation', 'pending_deletion_cancellation'), ('review_request', 'review_request'), ('subscription_category', 'subscription_category'), ('subscription_tag', 'subscription_tag')], default='system', max_length=36, null=True),
        ),
    ]