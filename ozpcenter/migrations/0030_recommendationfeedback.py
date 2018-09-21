# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ozpcenter', '0029_auto_20170921_1342'),
    ]

    operations = [
        migrations.CreateModel(
            name='RecommendationFeedback',
            fields=[
                ('id', models.AutoField(verbose_name='ID', auto_created=True, primary_key=True, serialize=False)),
                ('feedback', models.IntegerField(default=0)),
                ('target_listing', models.ForeignKey(to='ozpcenter.Listing', related_name='recommendation_feedback_listing')),
                ('target_profile', models.ForeignKey(to='ozpcenter.Profile', related_name='recommendation_feedback_profile')),
            ],
            options={
                'verbose_name_plural': 'recommendation feedback',
            },
        ),
    ]
