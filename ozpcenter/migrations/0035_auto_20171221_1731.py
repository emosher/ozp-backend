# -*- coding: utf-8 -*-
# Generated by Django 1.11.5 on 2017-12-21 17:31
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ozpcenter', '0034_auto_20171113_1541'),
    ]

    operations = [
        migrations.AlterField(
            model_name='notification',
            name='notification_type',
            field=models.CharField(choices=[('system', 'system'), ('agency', 'agency'), ('agency_bookmark', 'agency_bookmark'), ('listing', 'listing'), ('peer', 'peer'), ('peer_bookmark', 'peer_bookmark'), ('restore_bookmark', 'restore_bookmark'), ('subscription', 'subscription')], default='system', max_length=24),
        ),
    ]
