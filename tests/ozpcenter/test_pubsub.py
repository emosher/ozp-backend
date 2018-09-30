from django.test import TestCase
from django.test import override_settings

from ozpcenter import pubsub


class ObserverTestOne(pubsub.Observer):

    def __init__(self, callback=None):
        self.callback = callback

    def events_to_listen(self):
        return ['topic_1']

    def execute(self, event_type, **kwargs):
        self.callback(event_type, **kwargs)


class ObserverTestTwo(pubsub.Observer):

    def __init__(self, callback=None, callback_method=None):
        self.callback = callback
        self.callback_method = callback_method

    def events_to_listen(self):
        return ['topic_1', 'topic_2']

    def execute(self, event_type, **kwargs):
        self.callback(event_type, **kwargs)

    def topic_2(self, **kwargs):
        self.callback_method(**kwargs)


@override_settings(ES_ENABLED=False)
class PubSubTest(TestCase):

    def setUp(self):
        pass

    def test_observer_not_implemented_error(self):
        observer = pubsub.Observer()
        self.assertRaises(NotImplementedError, observer.events_to_listen)
        self.assertRaises(NotImplementedError, observer.execute, 'event_type')

    def test_dispatcher(self):
        observer_test_one_count = []
        observer_test_two_count = []
        observer_test_two_count_method = []

        def observer_test_one_callback(event_type, **kwargs):
            observer_test_one_count.append(kwargs)

        def observer_test_two_callback(event_type, **kwargs):
            observer_test_two_count.append(kwargs)

        def observer_test_two_callback_method(**kwargs):
            observer_test_two_count_method.append(kwargs)

        dispatcher = pubsub.Dispatcher()
        dispatcher.register(ObserverTestOne, callback=observer_test_one_callback)
        dispatcher.register(ObserverTestTwo,
                            callback=observer_test_two_callback,
                            callback_method=observer_test_two_callback_method)

        self.assertEquals(len(observer_test_one_count), 0)
        self.assertEquals(len(observer_test_two_count), 0)
        self.assertEquals(len(observer_test_two_count_method), 0)

        dispatcher.publish('topic_1', test_var=1, test_var_two=2)

        self.assertEquals(len(observer_test_one_count), 1)
        self.assertEquals(len(observer_test_two_count), 1)
        self.assertEquals(len(observer_test_two_count_method), 0)

        dispatcher.publish('topic_2', test_var=1, test_var_two=2)

        self.assertEquals(len(observer_test_one_count), 1)
        self.assertEquals(len(observer_test_two_count), 2)
        self.assertEquals(len(observer_test_two_count_method), 1)

        dispatcher.publish('topic_3', test_var=1, test_var_two=2)

        self.assertEquals(len(observer_test_one_count), 1)
        self.assertEquals(len(observer_test_two_count), 2)
        self.assertEquals(len(observer_test_two_count_method), 1)

        dispatcher.publish('topic_1', test_var=1, test_var_two=2)

        self.assertEquals(len(observer_test_one_count), 2)
        self.assertEquals(len(observer_test_two_count), 3)
        self.assertEquals(len(observer_test_two_count_method), 1)
