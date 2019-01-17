# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ozpcenter', '0039_listing_is_508_compliant'),
    ]

    operations = [
        migrations.CreateModel(
            name='CustomFieldType',
            options={
                'db_table': 'custom_field_type',
            },
            fields=[
                ('id', models.AutoField(verbose_name='ID',
                                        auto_created=True,
                                        primary_key=True,
                                        serialize=False)),

                ('name', models.CharField(max_length=50)),

                ('display_name', models.CharField(max_length=50)),

                ('media_type', models.CharField(max_length=255)),

                ('options', models.CharField(max_length=4000,
                                             null=True,
                                             blank=True)),
            ],
        ),

        migrations.CreateModel(
            name='CustomField',
            fields=[
                ('id', models.AutoField(auto_created=True,
                                        primary_key=True,
                                        serialize=False,
                                        verbose_name='ID')),

                ('section', models.CharField(max_length=50)),

                ('display_name', models.CharField(max_length=100)),

                ('label', models.CharField(max_length=50)),

                ('description', models.CharField(max_length=250)),

                ('tooltip', models.CharField(max_length=50)),

                ('is_required', models.BooleanField(default=False)),

                ('admin_only', models.BooleanField(default=False)),

                ('properties', models.CharField(max_length=4000,
                                                null=True,
                                                blank=True)),

                ('all_listing_types', models.BooleanField(default=False)),

                ('type', models.ForeignKey(on_delete=models.deletion.CASCADE,
                                           related_name='field_type',
                                           to='ozpcenter.CustomFieldType')),
            ],
            options={
                'db_table': 'custom_field',
            },
        ),

        migrations.AddField(
            model_name='ListingType',
            name='custom_fields',
            field=models.ManyToManyField(db_table='listing_type_custom_field',
                                         related_name='custom_listing_field',
                                         to='ozpcenter.CustomField',
                                         blank=True),
        ),

        migrations.CreateModel(
            name='CustomFieldValue',
            options={
                'db_table': 'custom_field_value',
            },
            fields=[
                ('id', models.AutoField(auto_created=True,
                                        primary_key=True,
                                        serialize=False,
                                        verbose_name='ID')),

                ('listing', models.ForeignKey(on_delete=models.deletion.CASCADE,
                                              to='ozpcenter.Listing',
                                              related_name="custom_fields")),

                ('custom_field', models.ForeignKey(on_delete=models.deletion.CASCADE,
                                                   to='ozpcenter.CustomField')),

                ('value', models.CharField(max_length=2000,
                                           null=True,
                                           blank=True)),
            ],
        ),

    ]
