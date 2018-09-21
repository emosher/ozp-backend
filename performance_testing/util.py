from collections import OrderedDict

import json


from ozpcenter.utils import shorthand_types
from ozpcenter.utils import shorthand_dict




obj = {'a':'string', 'b':[{'b':'string'},{'b':[{'c':'string'},{'d':4}]}]}
print(obj)
print('==')
print("""
a=string
b[0].b=string
b[0].c=string
b[1].d=4
""")
print('==')
print(shorthand_dict(obj))
print('==')
print(shorthand_types(obj))
print('==')
print(shorthand_dict(shorthand_types(obj)))

"""
(props:(a:(type:str),b:(items:[(props:(b:(type:str)),type:dict),(props:(b:(items:[(props:(c:(type:str)),type:dict),(props:(d:(type:int)),type:dict)],len:2,type:list)),type:dict)],len:2,type:list)),type:dict)

level0


props
  a:
   type:str
  b:
    items:
      props:
        b
          type:str))
      type:dict),(props:(b:(items:[(props:(c:(type:str)),type:dict),(props:(d:(type:int)),type:dict)],len:2,type:list)),type:dict)],len:2,type:list)),type:dict)



"""


# def format_shorthand(input_string, start=True, level=0):
#     is_str_boolean = isinstance(input_string, (str))
#     is_list_boolean = isinstance(input_string, (list))
#
#     level_up_func = lambda letter: 1 if '(' is letter else -1 if ')' is letter else 0
#
#
#     if start and not is_str_boolean:
#             raise Exception("When starting algorithm it need to be a string type")
#     elif start and is_str_boolean:
#         return format_shorthand(list(input_string), start=False)
#     elif not start and is_list_boolean:
#
#         for letter in input_string:
#
#             print('level_func: {}'.format(level_up_func(letter)))
#             print(letter)


# print(json.dumps(shorthand_types(obj),indent=2))

items = [
    {
      "type": "dict",
      "props": {
        "folder": {
          "type": "str"
        },
        "id": {
          "type": "int"
        },
        "listing": {
          "type": "dict",
          "props": {
            "banner_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "id": {
              "type": "int"
            },
            "large_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "launch_url": {
              "type": "str"
            },
            "small_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "title": {
              "type": "str"
            },
            "unique_name": {
              "type": "str"
            }
          }
        },
        "position": {
          "type": "int"
        }
      }
    },
    {
      "type": "dict",
      "props": {
        "folder": {
          "type": "str"
        },
        "id": {
          "type": "int"
        },
        "listing": {
          "type": "dict",
          "props": {
            "banner_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "id": {
              "type": "int"
            },
            "large_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "launch_url": {
              "type": "str"
            },
            "small_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "title": {
              "type": "str"
            },
            "unique_name": {
              "type": "str"
            }
          }
        },
        "position": {
          "type": "int"
        }
      }
    },
    {
      "type": "dict",
      "props": {
        "folder": {
          "type": "NoneType"
        },
        "id": {
          "type": "int"
        },
        "listing": {
          "type": "dict",
          "props": {
            "banner_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "id": {
              "type": "int"
            },
            "large_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "launch_url": {
              "type": "str"
            },
            "small_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "title": {
              "type": "str"
            },
            "unique_name": {
              "type": "str"
            }
          }
        },
        "position": {
          "type": "int"
        }
      }
    },
    {
      "type": "dict",
      "props": {
        "folder": {
          "type": "NoneType"
        },
        "id": {
          "type": "int"
        },
        "listing": {
          "type": "dict",
          "props": {
            "banner_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "id": {
              "type": "int"
            },
            "large_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "launch_url": {
              "type": "str"
            },
            "small_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "title": {
              "type": "str"
            },
            "unique_name": {
              "type": "str"
            }
          }
        },
        "position": {
          "type": "int"
        }
      }
    },
    {
      "type": "dict",
      "props": {
        "folder": {
          "type": "NoneType"
        },
        "id": {
          "type": "int"
        },
        "listing": {
          "type": "dict",
          "props": {
            "banner_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "id": {
              "type": "int"
            },
            "large_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "launch_url": {
              "type": "str"
            },
            "small_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "title": {
              "type": "str"
            },
            "unique_name": {
              "type": "str"
            }
          }
        },
        "position": {
          "type": "int"
        }
      }
    },
    {
      "type": "dict",
      "props": {
        "folder": {
          "type": "str"
        },
        "id": {
          "type": "int"
        },
        "listing": {
          "type": "dict",
          "props": {
            "banner_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "id": {
              "type": "int"
            },
            "large_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "launch_url": {
              "type": "str"
            },
            "small_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "title": {
              "type": "str"
            },
            "unique_name": {
              "type": "str"
            }
          }
        },
        "position": {
          "type": "int"
        }
      }
    },
    {
      "type": "dict",
      "props": {
        "folder": {
          "type": "str"
        },
        "id": {
          "type": "int"
        },
        "listing": {
          "type": "dict",
          "props": {
            "banner_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "id": {
              "type": "int"
            },
            "large_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "launch_url": {
              "type": "str"
            },
            "small_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "title": {
              "type": "str"
            },
            "unique_name": {
              "type": "str"
            }
          }
        },
        "position": {
          "type": "int"
        }
      }
    },
    {
      "type": "dict",
      "props": {
        "folder": {
          "type": "str"
        },
        "id": {
          "type": "int"
        },
        "listing": {
          "type": "dict",
          "props": {
            "banner_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "id": {
              "type": "int"
            },
            "large_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "launch_url": {
              "type": "str"
            },
            "small_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "title": {
              "type": "str"
            },
            "unique_name": {
              "type": "str"
            }
          }
        },
        "position": {
          "type": "int"
        }
      }
    },
    {
      "type": "dict",
      "props": {
        "folder": {
          "type": "str"
        },
        "id": {
          "type": "int"
        },
        "listing": {
          "type": "dict",
          "props": {
            "banner_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "id": {
              "type": "int"
            },
            "large_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "launch_url": {
              "type": "str"
            },
            "small_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "title": {
              "type": "str"
            },
            "unique_name": {
              "type": "str"
            }
          }
        },
        "position": {
          "type": "int"
        }
      }
    },
    {
      "type": "dict",
      "props": {
        "folder": {
          "type": "str"
        },
        "id": {
          "type": "int"
        },
        "listing": {
          "type": "dict",
          "props": {
            "banner_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "id": {
              "type": "int"
            },
            "large_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "launch_url": {
              "type": "str"
            },
            "small_icon": {
              "type": "dict",
              "props": {
                "id": {
                  "type": "int"
                },
                "security_marking": {
                  "type": "str"
                },
                "url": {
                  "type": "Hyperlink"
                }
              }
            },
            "title": {
              "type": "str"
            },
            "unique_name": {
              "type": "str"
            }
          }
        },
        "position": {
          "type": "int"
        }
      }
    }
  ]
