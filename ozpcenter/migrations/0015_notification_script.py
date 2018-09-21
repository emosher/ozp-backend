# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations
# from ozpcenter.scripts import notification_mailbox

from ozpcenter.utils import interactive_migration


def forwards(apps, schema_editor):
    if not schema_editor.connection.alias == 'default':
        return
    interactive_migration()
    # notification_mailbox.run()
    # Running the script automatically was making any change in the profile raise in exception


class Migration(migrations.Migration):

    dependencies = [
        ('ozpcenter', '0014_notificationmailbox'),
    ]

    operations = [
        migrations.RunPython(forwards, reverse_code=migrations.RunPython.noop),
    ]
