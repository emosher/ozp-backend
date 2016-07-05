"""
Access control utilities

An access control is a marking that complies with the structure described here:
 http://www.ncsc.gov/training/WBT/docs/CM_AltText_021312.pdf
 http://www.ncsc.gov/training/resources/Public_CAPCO%20Manual_v2.1.pdf
 http://www.ncsc.gov/training/resources/Publically%20Releasable%20Register.pdf
 https://www.nsa.gov/public_info/_files/nsacss_policies/Policy_Manual_1-52.pdf
 http://www.dtic.mil/whs/directives/corres/pdf/520001_vol2.pdf
 https://www.cia.gov/library/publications/the-world-factbook/print/print_AppendixD.pdf

For example:
    UNCLASSIFIED//FOUO

Classification Validation:
    A string is made of tokens separated by a delimiter

"""
import logging

from . import tokens as all_tokens

logger = logging.getLogger('ozp-center.' + str(__name__))


tokens_list = [
    # Classification Tokens
    {'type': 'Classification',
     'data': {'short_name': 'U',
             'long_name': 'Unclassified',
             'level': 1}
    },
    {'type': 'Classification',
     'data': {'short_name': 'C',
             'long_name': 'Confidential',
             'level': 2}
    },
    {'type': 'Classification',
     'data': {'short_name': 'S',
             'long_name': 'Secret',
             'level': 3}
    },
    {'type': 'Classification',
     'data': {'short_name': 'TS',
             'long_name': 'Top Secret',
             'level': 4}
    },
    # Dissemination Control Tokens
    {'type': 'DisseminationControl',
     'data': {'short_name': 'FOUO',
             'long_name': 'FOR OFFICIAL USE ONLY'}
    }
]


class PluginMain(object):
    plugin_name = 'default_access_control'
    plugin_description = 'DefaultAccessControlPlugin'
    plugin_type = 'access_control'

    def __init__(self, settings=None, requests=None):
        '''
        Settings: Object reference to ozp settings
        '''
        self.settings = settings
        self.requests = requests

        self.tokens = [self._convert_dict_to_token(input) for input in tokens_list]

    def _convert_dict_to_token(self, input):
        """
        Converts Dictionary into Token
        """
        type = input.get('type')
        data = input.get('data')

        if type is None or data is None:
            return all_tokens.InvalidFormatToken()

        token_type_class = all_tokens.InvalidFormatToken

        if type == 'Classification':
            token_type_class = all_tokens.ClassificationToken
        elif type == 'DisseminationControl':
            token_type_class = all_tokens.DisseminationControlToken
        else:
            return token_type_class()

        return token_type_class(**data)

    def _split_tokens(self, input_marking, delimiter='//'):
        """
        This method is responsible for converting a String into Tokens
        """
        long_name_lookup = {}
        for token in self.tokens:
            long_name_lookup[token.long_name.upper()] = token

        short_name_lookup = {}
        for token in self.tokens:
            short_name_lookup[token.short_name.upper()] = token

        markings = input_marking.split(delimiter)

        output_tokens = []
        for marking in markings:
            current_token = None

            if marking.upper() in long_name_lookup:
                current_token = long_name_lookup[marking.upper()]
            else:
                if marking.upper() in short_name_lookup:
                    current_token = short_name_lookup[marking.upper()]
                else:
                    current_token = all_tokens.UnknownToken(long_name=marking)

            output_tokens.append(current_token)
        return output_tokens

    def has_access(self, user_accesses_json, marking):
        return True

    def validate_marking(self, marking):
        """
        This function is responsible for validating a marking string

        Assume the access control is of the format:
        <CLASSIFICATION>//<CONTROL>//<CONTROL>//...

        """
        if not marking:
            return False
        tokens = self._split_tokens(marking)

        if not isinstance(tokens[0], all_tokens.ClassificationToken):
            return False

        return True
