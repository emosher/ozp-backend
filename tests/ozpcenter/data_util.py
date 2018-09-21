import os
import yaml

from ozpcenter.pipe import pipes
from ozpcenter.pipe.pipeline import Pipeline
from ozpcenter.recommend import recommend_utils

TEST_BASE_PATH = os.path.realpath(os.path.join(os.path.dirname(__file__), '..', '..', 'ozpcenter', 'scripts'))
TEST_DATA_PATH = os.path.join(TEST_BASE_PATH, 'test_data')


class FileQuery(object):
    """
    Query Object Compiler/ Pipeline
    """

    def __init__(self):
        self.pipeline = Pipeline()

    def load_yaml_file(self, listing_file_name=None):
        listing_file_path = os.path.join(TEST_DATA_PATH, listing_file_name or 'listings.yaml')
        listings_data = []
        with open(listing_file_path, 'r') as stream:
            try:
                listings_data = yaml.load(stream)
            except yaml.YAMLError as exc:
                print(exc)
                raise

        self.pipeline.add_pipe(recommend_utils.ListIterator(listings_data))
        return self

    def len(self):
        """
        len number Elements
        """
        current_pipe = pipes.LenPipe()
        self.pipeline.add_pipe(current_pipe)
        return self

    def key(self, key):
        """
        Enter into key
        """
        current_pipe = pipes.DictKeyPipe(key)
        self.pipeline.add_pipe(current_pipe)
        return self

    def each_key(self, key):
        """
        Enter into key, emit each item in list
        """
        current_pipe = pipes.EachKeyPipe(key)
        self.pipeline.add_pipe(current_pipe)
        return self

    def next(self):
        """
        Give next item in list
        """
        return self.pipeline.next()

    def to_list(self):
        """
        Give results in a list of objects
        """
        return self.pipeline.to_list()

    def count(self):
        """
        Give results in a list of objects
        """
        return self.pipeline.count()

    def __str__(self):
        return str(self.pipeline)


class ListingFileClass(object):
    """
    Listing File

    from tests.ozpcenter.data_util import ListingFile
    ListingFile.filter_listings(is_enabled=True,approval_status='S')
    """

    def __init__(self, listing_file_name=None):
        self.listing_file_path = os.path.join(TEST_DATA_PATH, listing_file_name or 'listings.yaml')

    def filter_listings(self, **kwargs):
        """
        filter_listings(hello='d',hel='da')
        kwargs = {'hello': 'd', 'hel': 'da'}

        kwargs order is not guaranteed

        Does not take in account Private apps
        """
        listings_data = self.listing_records()

        listing_entries = []
        for current_listing_data in listings_data:
            current_listing = current_listing_data['listing']
            listing_activity = current_listing_data['listing_activity']

            current_listing['approval_status'] = listing_activity[-1]['action']

            accept_listing = True

            for keyword_key, keyword_value in kwargs.items():
                postfix = None
                if '__' in keyword_key:
                    keyword_key_split = keyword_key.split('__')
                    keyword_key = keyword_key_split[0]
                    postfix = keyword_key_split[1]

                # Check to see if keyword exist in listing
                if keyword_key in current_listing:
                    if postfix == 'in':
                        current_listing_keyword_value = current_listing[keyword_key]

                        if type(current_listing_keyword_value) is list:
                            # Case 1: When current_listing_keyword_value is a list
                            current_listing_set = set(current_listing_keyword_value)
                        else:
                            # Case 1: When current_listing_keyword_value is a string/int, convert into list, then set
                            current_listing_set = set([current_listing_keyword_value])

                        keyword_key_set = set(keyword_value)

                        if len(current_listing_set.intersection(keyword_key_set)) == 0:
                            accept_listing = False
                    else:
                        if not current_listing[keyword_key] == keyword_value:
                            accept_listing = False

                else:
                    raise Exception('Keyword {} is not in the listing'.format(keyword_key))

            if accept_listing:
                listing_entries.append(current_listing)

        return listing_entries

    def listing_records(self):
        """
        Extract Listing Records from listings.yaml
        """
        listings_data = None
        with open(self.listing_file_path, 'r') as stream:
            try:
                listings_data = yaml.load(stream)
            except yaml.YAMLError as exc:
                print(exc)
                raise
        return listings_data

    def listings_titles(self):
        """
        Extract Listing's titles from listing.yaml file

        Return a sorted list of titles
        """
        listings_data = self.listing_records()
        return sorted([current_record['listing']['title'] for current_record in listings_data])

    def listings_tags(self):
        """
        Extract Listing's tags from listing.yaml file

        Return a sorted list of tags
        """
        listings_data = self.listing_records()

        listing_tags = set()
        for current_listing_data in listings_data:
            current_listing = current_listing_data['listing']

            for current_tag in current_listing['tags']:
                listing_tags.add(current_tag)
        return sorted(list(listing_tags))


ListingFile = ListingFileClass()
