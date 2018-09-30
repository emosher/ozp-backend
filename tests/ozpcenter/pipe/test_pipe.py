"""
Make sure that Pipe and Pipeline classes work

TODO: Make below code work
if not len_pipe.has_next():
    break
"""
from django.test import TestCase
from django.test import override_settings

from ozpcenter.pipe import pipes
from ozpcenter.recommend import recommend_utils


@override_settings(ES_ENABLED=False)
class PipeTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        pass

    def setUp(self):
        pass

    def _iterate_pipe(self, current_pipe):
        list_out = []

        try:
            while True:
                current_object = current_pipe.next()
                list_out.append(current_object)
        except recommend_utils.FastNoSuchElementException:
            # Ignore FastNoSuchElementException
            pass
        return list_out

    def test_pipe_process_next_start_exception(self):
        current_pipe = pipes.Pipe()
        self.assertRaises(NotImplementedError, current_pipe.process_next_start)

    def test_capitalize_pipe(self):
        current_pipe = pipes.CapitalizePipe()
        current_pipe.set_starts(recommend_utils.ListIterator(['this', 'is', 'the', 'test']))

        list_out = self._iterate_pipe(current_pipe)

        self.assertEqual(list_out, ['THIS', 'IS', 'THE', 'TEST'])
        self.assertEqual(str(current_pipe), 'CapitalizePipe()')

    def test_distinct_pipe(self):
        current_pipe = pipes.DistinctPipe()
        current_pipe.set_starts(recommend_utils.ListIterator(['is', 'this', 'is', 'the', 'test', 'this']))

        list_out = self._iterate_pipe(current_pipe)

        self.assertEqual(list_out, ['is', 'this', 'the', 'test'])
        self.assertEqual(str(current_pipe), 'DistinctPipe()')

    def test_side_effect_pipe(self):
        side_effect_objects = []

        def func1(current_object):
            side_effect_objects.append(len(current_object))

        current_pipe = pipes.SideEffectPipe(func1)
        current_pipe.set_starts(recommend_utils.ListIterator(['this', 'is', 'the', 'test']))

        list_out = self._iterate_pipe(current_pipe)

        self.assertEqual(list_out, ['this', 'is', 'the', 'test'])
        self.assertEqual(side_effect_objects, [4, 2, 3, 4])
        self.assertEqual(str(current_pipe), 'SideEffectPipe(function:<class \'function\'>)')

    def test_pipe_cap_len_chain(self):
        caps_pipe = pipes.CapitalizePipe()
        len_pipe = pipes.LenPipe()

        caps_pipe.set_starts(recommend_utils.ListIterator(['this', 'is', 'the', 'test']))
        len_pipe.set_starts(caps_pipe)

        list_out = self._iterate_pipe(len_pipe)

        self.assertEqual(list_out, [4, 2, 3, 4])

    def test_pipe_each_key(self):
        each_key_pipe = pipes.EachKeyPipe('testKey')

        data = [
            {
                "testKey": []
            },
            {
                "testKey": [4, 8, 5, 2]
            },
            {
                "testKey": [1, 6, 7]
            }
        ]
        each_key_pipe.set_starts(recommend_utils.ListIterator(data))

        list_out = self._iterate_pipe(each_key_pipe)
        self.assertEqual(list_out, [4, 8, 5, 2, 1, 6, 7])

    def test_pipe_each_key_mixed(self):
        each_key_pipe = pipes.EachKeyPipe('testKey')

        data = [
            {
                "key2": [5, 7]
            },
            {
                "key3": [4, 8, 5, 2]
            },
            {
                "testKey": [1, 6, 7]
            }
        ]
        each_key_pipe.set_starts(recommend_utils.ListIterator(data))

        list_out = self._iterate_pipe(each_key_pipe)
        self.assertEqual(list_out, [1, 6, 7])

    def test_pipe_each_key_mixed_none(self):
        each_key_pipe = pipes.EachKeyPipe('testKey')

        data = [
            {
                "key2": [5, 7]
            },
            {
                "testKey": [4, 8, 5, 2]
            },
            {
                "testKey": None
            }
        ]
        each_key_pipe.set_starts(recommend_utils.ListIterator(data))

        list_out = self._iterate_pipe(each_key_pipe)
        self.assertEqual(list_out, [4, 8, 5, 2])
