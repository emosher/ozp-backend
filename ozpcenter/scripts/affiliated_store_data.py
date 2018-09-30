import os
import sys

import yaml

from ozpcenter.scripts.model_generator import ModelGenerator
from ozpcenter.scripts.model_schema import *

sys.path.insert(0, os.path.realpath(os.path.join(os.path.dirname(__file__), '../../')))
from django.conf import settings
from django.core.management import call_command

from ozpcenter import models
import ozpcenter.api.listing.model_access_es as model_access_es

TEST_BASE_PATH = os.path.realpath(os.path.join(os.path.dirname(__file__)))
TEST_IMG_PATH = os.path.join(TEST_BASE_PATH, 'test_images') + '/'
TEST_DATA_PATH = os.path.join(TEST_BASE_PATH, 'test_data')
DEMO_APP_ROOT = settings.OZP['DEMO_APP_ROOT']


def run():
    model_access_es.recreate_index_mapping()

    # Used to make postgresql work in unittest  TODO: Verify this is needed
    call_command('flush', '--noinput')

    models.Profile.create_groups()

    model = load_model_from_yaml("affiliated_store_model.yaml")

    generator = ModelGenerator(TEST_IMG_PATH)
    generator.create_model(model)


def load_model_from_yaml(filename: str) -> ModelData:
    with open(os.path.join(TEST_DATA_PATH, filename), 'r') as stream:
        data = yaml.load(stream)
        return parse_model(data)


if __name__ == "__main__":
    run()
