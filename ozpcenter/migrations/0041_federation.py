# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.core.validators import RegexValidator
from django.db import models, migrations

from ozpcenter.utils import get_now_utc


class Migration(migrations.Migration):

    dependencies = [
        ('ozpcenter', '0040_custom_fields'),
    ]

    operations = [
        migrations.CreateModel(
            name='AffiliatedStore',
            fields=[
                ('id', models.AutoField(verbose_name='ID',
                                        auto_created=True,
                                        primary_key=True,
                                        serialize=False)),

                ('title', models.CharField(max_length=255)),

                ('server_url', models.CharField(max_length=2083,
                                                validators=[RegexValidator(regex='^(https|http)://.*$',
                                                                           code='invalid url',
                                                                           message='server_url must be a url')])),

                ('icon', models.ForeignKey(to='ozpcenter.Image',
                                           related_name='+',
                                           null=True,
                                           blank=True)),

                ('is_enabled', models.BooleanField(default=True))
            ],
            options={
                'db_table': 'affiliated_store'
            }
        ),

        migrations.CreateModel(
            name='ImportMetadata',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('external_id', models.IntegerField()),
                ('last_updated', models.DateTimeField()),
                ('affiliated_store', models.ForeignKey(on_delete=models.deletion.CASCADE, to='ozpcenter.AffiliatedStore', verbose_name='affiliated store')),
            ],
        ),

        migrations.AddField(
            model_name='agency',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AlterField(
            model_name='agency',
            name='title',
            field=models.CharField(max_length=255),
        ),

        migrations.AlterField(
            model_name='agency',
            name='short_name',
            field=models.CharField(max_length=32),
        ),

        migrations.AddField(
            model_name='category',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AlterField(
            model_name='category',
            name='title',
            field=models.CharField(max_length=50),
        ),

        migrations.AddField(
            model_name='changedetail',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AddField(
            model_name='contact',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AddField(
            model_name='contacttype',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AlterField(
            model_name='contacttype',
            name='name',
            field=models.CharField(max_length=50),
        ),

        migrations.AddField(
            model_name='customfield',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AddField(
            model_name='customfieldtype',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AddField(
            model_name='customfieldvalue',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AddField(
            model_name='docurl',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AddField(
            model_name='image',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AddField(
            model_name='imagetype',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AlterField(
            model_name='imagetype',
            name='name',
            field=models.CharField(choices=[('small_icon', 'small_icon'), ('large_icon', 'large_icon'), ('banner_icon', 'banner_icon'), ('large_banner_icon', 'large_banner_icon'), ('small_screenshot', 'small_screenshot'), ('large_screenshot', 'large_screenshot')], max_length=64),
        ),

        migrations.AddField(
            model_name='intent',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AddField(
            model_name='listing',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AlterField(
            model_name='listing',
            name='unique_name',
            field=models.CharField(blank=True, max_length=255, null=True),
        ),

        migrations.AddField(
            model_name='listingactivity',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AddField(
            model_name='listingtype',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AlterField(
            model_name='listingtype',
            name='title',
            field=models.CharField(max_length=50),
        ),

        migrations.AddField(
            model_name='profile',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AlterField(
            model_name='profile',
            name='dn',
            field=models.CharField(max_length=1000),
        ),

        migrations.AddField(
            model_name='review',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AddField(
            model_name='screenshot',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AddField(
            model_name='tag',
            name='import_metadata',
            field=models.OneToOneField(to='ozpcenter.ImportMetadata', null=True, blank=True, on_delete=models.deletion.SET_NULL),
        ),

        migrations.AddField(
            model_name='listing',
            name='is_exportable',
            field=models.BooleanField(default=False),
        ),

        migrations.AlterField(
            model_name='listingactivity',
            name='action',
            field=models.CharField(
                max_length=128,
                choices=[('CREATED', 'CREATED'),
                         ('MODIFIED', 'MODIFIED'),
                         ('SUBMITTED', 'SUBMITTED'),
                         ('APPROVED_ORG', 'APPROVED_ORG'),
                         ('APPROVED', 'APPROVED'),
                         ('REJECTED', 'REJECTED'),
                         ('ENABLED', 'ENABLED'),
                         ('DISABLED', 'DISABLED'),
                         ('DELETED', 'DELETED'),
                         ('REVIEWED', 'REVIEWED'),
                         ('REVIEW_EDITED', 'REVIEW_EDITED'),
                         ('REVIEW_DELETED', 'REVIEW_DELETED'),
                         ('PENDING_DELETION', 'PENDING_DELETION'),
                         ('ENABLED_OUTSIDE_VISIBILITY', 'ENABLED_OUTSIDE_VISIBILITY'),
                         ('DISABLED_OUTSIDE_VISIBILITY', 'DISABLED_OUTSIDE_VISIBILITY')]
            ),
        ),

        migrations.CreateModel(
            name='ImportTask',
            fields=[
                ('id', models.AutoField(verbose_name='ID',
                                        auto_created=True,
                                        primary_key=True,
                                        serialize=False)),

                ('name', models.CharField(max_length=50, unique=True)),

                ('update_type', models.CharField(max_length=7,
                                                 choices=[('Entire', 'Entire'), ('Partial', 'Partial')])),

                ('cron_exp', models.CharField(max_length=255, null=True, blank=True)),

                ('exec_interval', models.IntegerField(null=True)),

                ('url', models.CharField(max_length=2083, null=True, blank=True)),

                ('extra_url_params', models.CharField(max_length=512, null=True, blank=True)),

                ('enabled', models.BooleanField(default=True)),

                ('keystore_path', models.CharField(max_length=2048, null=True, blank=False)),
                ('keystore_pass', models.CharField(max_length=2048, null=True, blank=False)),
                ('truststore_path', models.CharField(max_length=2048, null=True, blank=False))

            ],
            options={
                'db_table': 'import_task'
            }
        ),

        migrations.CreateModel(
            name='ImportTaskResult',
            fields=[
                ('id', models.AutoField(verbose_name='ID',
                                        auto_created=True,
                                        primary_key=True,
                                        serialize=False)),

                ('import_task', models.ForeignKey(to='ozpcenter.ImportTask',
                                                  related_name="results",
                                                  on_delete=models.deletion.CASCADE)),

                ('run_date', models.DateTimeField(default=get_now_utc)),

                ('result', models.CharField(max_length=4,
                                            choices=[('Pass', 'Pass'), ('Fail', 'Fail')])),

                ('message', models.CharField(max_length=4000)),

            ],
            options={
                'db_table': 'import_task_result'
            }
        ),

        migrations.AddField(
            model_name='ImportTask',
            name='last_run_result',
            field=models.ForeignKey(null=True,
                                    to='ozpcenter.ImportTaskResult',
                                    related_name="+",
                                    on_delete=models.deletion.SET_NULL)
        ),

        migrations.AlterField(
            model_name='importtask',
            name='exec_interval',
            field=models.ForeignKey(null=True,
                                    on_delete=models.deletion.CASCADE,
                                    to='django_celery_beat.IntervalSchedule'
                                    ),
        ),

        migrations.AlterField(
            model_name='importtask',
            name='last_run_result',
            field=models.ForeignKey(blank=True,
                                    null=True,
                                    on_delete=models.deletion.SET_NULL,
                                    related_name='+',
                                    to='ozpcenter.ImportTaskResult'
                                    ),
        ),

        migrations.AddField(
            model_name='importtask',
            name='affiliated_store',
            field=models.ForeignKey(null=True, 
                                    on_delete=models.deletion.CASCADE, 
                                    to='ozpcenter.AffiliatedStore'),
        ),

        migrations.AlterField(
            model_name='importtask',
            name='url',
            field=models.CharField(max_length=2083,
                                   null=True, 
                                   validators=[RegexValidator(regex='^(https|http)://.*$',
                                                                           code='invalid url',
                                                                           message='Please enter a valid url')])
        ),

        migrations.AlterField(
            model_name='importtask',
            name='keystore_pass',
            field=models.CharField(blank=True, max_length=2048, null=True),
        ),
        migrations.AlterField(
            model_name='importtask',
            name='keystore_path',
            field=models.CharField(blank=True, max_length=2048, null=True),
        ),
        migrations.AlterField(
            model_name='importtask',
            name='truststore_path',
            field=models.CharField(blank=True, max_length=2048, null=True),
        ),
        migrations.AlterField(
            model_name='importtask',
            name='update_type',
            field=models.CharField(blank=True, choices=[('Entire', 'Entire'), ('Partial', 'Partial')], max_length=7, null=True),
        ),



    ]
