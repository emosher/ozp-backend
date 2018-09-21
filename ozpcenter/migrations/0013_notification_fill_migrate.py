# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import os
from django.db import migrations

from ozpcenter.utils import interactive_migration


def forwards(apps, schema_editor):
    if not schema_editor.connection.alias == 'default':
        return
    interactive_migration()
    # Migration code goes here
    # notification_fill.run()
    # Running the script automatically was making any change in the profile raise in exception


class Migration(migrations.Migration):

    dependencies = [
        ('ozpcenter', '0012_auto_20170322_1309'),
    ]

    operations = [
        migrations.RunPython(forwards, reverse_code=migrations.RunPython.noop),
    ]
