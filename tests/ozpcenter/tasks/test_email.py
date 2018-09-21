"""
Tests Email Task
"""
from django.test import override_settings
from tests.ozp.cases import APITestCase

from tests.ozpcenter.helper import APITestHelper
from ozpcenter.utils import shorthand_dict
from tests.ozpcenter.helper import ExceptionUnitTestHelper
from ozpcenter.scripts import sample_data_generator as data_gen
from ozpcenter.tasks import create_email


@override_settings(ES_ENABLED=False)
class EmailTest(APITestCase):

    def setUp(self):
        """
        setUp is invoked before each test method
        """
        pass

    @classmethod
    def setUpTestData(cls):
        """
        Set up test data for the whole TestCase (only run once for the TestCase)
        """
        data_gen.run()

    def test_email_sync(self):
        email_results = create_email(3)

        actual_results = shorthand_dict(email_results, exclude_keys='time')
        expected_results = '(error:False,message:13 New Notifications for username: khaleesi)'
        self.assertEqual(actual_results, expected_results)

        email_results = create_email(3)

        actual_results = shorthand_dict(email_results, exclude_keys='time')
        expected_results = '(error:False,message:No New Notifications for username: khaleesi)'
        self.assertEqual(actual_results, expected_results)

    # TODO: Make below code work
    # Right now it depends on worker and message broker to run
    # def test_email_async(self):
    #     with self.tasks():
    #
    #         messages = []
    #
    #         def on_raw_message(body):
    #             print(body)
    #             messages.append(body)
    #
    #         profile_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    #
    #         create_email_task = create_email.chunks(profile_list, 3)
    #         group_results = create_email_task.apply_async()
    #
    #         print('Email Notification Group Results: {}'.format(group_results))
    #         group_results.get(on_message=on_raw_message)
    #
    #         print(messages)
    #
    #         self.assertEqual(True, False)

        # group_results.get(on_message=on_raw_message)
