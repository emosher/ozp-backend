"""
Utility functions
"""
import datetime
import pytz
import re
import os
import time
from collections import OrderedDict


# Reference - Code not used
# from django.template import Context
# from django.template import Template


def millis():
    """
    Get millis seconds
    """
    return int(round(time.time() * 1000))


def str_to_bool(user_input):
    """
    Convert string to Boolean value
    """
    if isinstance(user_input, bool):
        return user_input
    else:
        if user_input.lower() in ['1', 'true']:
            return True
        else:
            return False


def interactive_migration():
    TEST_MODE = str_to_bool(os.getenv('TEST_MODE', False))

    if TEST_MODE is True:
        return

    print('Please Run - python manage.py runscript notification_mailbox')
    print('If it is the first time say N, run the script, and next time say Y')
    print('For Development Machines: Always say Y')

    response = input('Have you run command: Y/N    ').lower()

    if response == 'y':
        return
    else:
        raise Exception('You need to run command first')


def make_keysafe(key):
    """
    given an input string, make it lower case and remove all non alpha-numeric
    characters so that it will be safe to use as a cache keyname

    TODO: check for max length (250 chars by default for memcached)
    """
    return re.sub(r'[^a-zA-Z0-9_."`-]+', '', key).lower()


def find_between(s, start, end):
    """
    Return a string between two other strings
    """
    return (s.split(start))[1].split(end)[0]


def get_now_utc(days_delta=None):
    """
    Return current datetime in UTC

    Format: YYYY-MM-DD HH:MM[:ss[.uuuuuu]][TZ]
    """
    now_date = datetime.datetime.now(pytz.utc)

    if days_delta:
        day_delta = datetime.timedelta(days=days_delta)
        now_date = now_date + day_delta

    return now_date

# Reference - Code not used
# def render_template_string(template_string, context_dict):
#     """
#     Render Django Template
#
#     Args:
#         template_string(str): Template String
#         context_dict(dict): Context Variable Dictionary
#     """
#     template_context = Context(context_dict)
#     template = Template(template_string)
#     return template.render(template_context)


def shorthand_nested(input_object, key='', prefix_key=''):
    """
    {'title':'app1', 'category':[{'title':'weather'},{'title':'utils'}]}
    TO
    {'title':['app1'],
     'category[].title':

    """
    is_base_boolean = isinstance(input_object, (int, str, float))
    is_dict_boolean = isinstance(input_object, dict)
    is_list_boolean = isinstance(input_object, list)
    has_key = True if key else False


def shorthand_types(input_object):
    """
    {'title':'app1', 'category':[{'title':'weather'},{'title':'utils'}]}
        TO
    {
     'type':'dict',
     'props':{
        'title':{
            'type': 'string'
        },
        'category':{
            'type': 'list',
            'items':[
                {'type': 'dict',
                 'props':{
                    'title':{'type':'string'}
                 }
                }
            ]
        }
     }
    }
    """
    # is_base_boolean = isinstance(input_object, (int, str, float))
    is_dict_boolean = isinstance(input_object, dict)
    is_list_boolean = isinstance(input_object, list)

    if is_list_boolean:
        dict_set = set()
        interm = []
        for item in input_object:
            # item_value = shorthand_types(item)
            #
            # if str(item_value) not in dict_set:
            #     interm.append(item_value)
            # dict_set.add(str(item_value))

            interm.append(shorthand_types(item))

        output_dict = OrderedDict({'type': 'list', 'items': [], 'len': len(input_object)})

        for item in interm:
            output_dict['items'].append(item)

        return output_dict
    elif is_dict_boolean:
        sorted_keys = sorted(input_object.keys())
        output_dict = OrderedDict({'type': 'dict', 'props': OrderedDict({})})

        for key in sorted_keys:
            output_dict['props'][key] = shorthand_types(input_object[key])

        return output_dict
    else:
        return OrderedDict({'type': input_object.__class__.__name__})


def shorthand_dict(input_object, key=None, prefix_key=None, exclude_keys=None, include_keys=None, list_star=None):
    """
    Recursive function to create a shorthand representation of complex python objects into a string

    Example for dictionary:
        {'title':'app1', 'category':[{'title':'weather'},{'title':'utils'}]}
            TO
        (category:[(title:weather),(title:utils)],title:app1)

    Example for list of complex objects:
        [
            {'title':'app1', 'category':[{'title':'weather'},{'title':'utils'}]},
            {'title':'app1', 'category':[{'title':'weather'},{'title':'utils'}]}
        ]
        TO
        [
            '(category:[(title:weather),(title:utils)],title:app1)',
            '(category:[(title:weather),(title:utils)],title:app1)'
        ]

        TODO: Get {'data':[1,[2,[3]]]}) to work
    Usage:
        shorthand_dict({'key1':'app1', 'category':[{'key2':'weather'},{'key3':'utils'}]})
    """
    key = key or ''
    prefix_key = prefix_key or ''
    exclude_keys = exclude_keys or []
    include_keys = include_keys or []
    list_star = list_star or False

    # is_base_boolean = isinstance(input_object, (int, str, float))
    is_dict_boolean = isinstance(input_object, dict)
    is_list_boolean = isinstance(input_object, list)
    has_key = True if key else False

    # Expand exclude_keys
    #   ['hello.world.in.here', 'bye'] > ['hello', 'hello.world'. 'hello.world.in', 'hello.world.in.here']

    if is_list_boolean and not has_key and not prefix_key:
        return [shorthand_dict(ob, exclude_keys=exclude_keys, include_keys=include_keys, list_star=list_star) for ob in input_object]

    elif is_list_boolean and not has_key and prefix_key:
        output = []
        for index, ob in enumerate(input_object, start=0):
            current_prefix_key = '{}[{}]'.format(prefix_key, index) if prefix_key else '{}[{}]'.format(prefix_key, index)

            if include_keys:
                if current_prefix_key in include_keys:
                    output.append(shorthand_dict(ob, prefix_key=current_prefix_key, exclude_keys=exclude_keys, include_keys=include_keys, list_star=list_star))
            elif current_prefix_key not in exclude_keys:
                output.append(shorthand_dict(ob, prefix_key=current_prefix_key, exclude_keys=exclude_keys, include_keys=include_keys, list_star=list_star))
        return '[{}]'.format(','.join(output))

    elif is_list_boolean and has_key:
        output = []
        for index, ob in enumerate(input_object, start=0):

            if list_star:
                current_prefix_key = '{}[*]'.format(key) if prefix_key else '{}[*]'.format(key, index)
            else:
                current_prefix_key = '{}[{}]'.format(key, index) if prefix_key else '{}[{}]'.format(key, index)

            if include_keys:
                if current_prefix_key in include_keys:
                    output.append(shorthand_dict(ob, prefix_key=current_prefix_key, exclude_keys=exclude_keys, include_keys=include_keys, list_star=list_star))
            elif current_prefix_key not in exclude_keys:
                output.append(shorthand_dict(ob, prefix_key=current_prefix_key, exclude_keys=exclude_keys, include_keys=include_keys, list_star=list_star))
        return '[{}]'.format(','.join(output))

    elif is_dict_boolean:
        sorted_keys = sorted(input_object.keys())
        output = []
        for key in sorted_keys:
            current_prefix_key = '{}.{}'.format(prefix_key, key) if prefix_key else '{}'.format(key)

            if include_keys:
                if current_prefix_key in include_keys:
                    output.append('{}:{}'.format(key, shorthand_dict(input_object[key], key, prefix_key=current_prefix_key, exclude_keys=exclude_keys, include_keys=include_keys, list_star=list_star)))
            elif current_prefix_key not in exclude_keys:
                output.append('{}:{}'.format(key, shorthand_dict(input_object[key], key, prefix_key=current_prefix_key, exclude_keys=exclude_keys, include_keys=include_keys, list_star=list_star)))
        return '({})'.format(','.join(output))

    else:
        # print('{}={}'.format(prefix_key, input_object))  # Debug key location
        return '{}'.format(input_object)
