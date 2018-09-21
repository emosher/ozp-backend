# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ozpcenter', '0028_profile_leaving_ozp_warning_flag'),
    ]

    operations = [
        migrations.AlterField(
            model_name='profile',
            name='leaving_ozp_warning_flag',
            field=models.BooleanField(default=True),
        ),
    ]
