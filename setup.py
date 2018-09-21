import re
from setuptools import setup, find_packages
from ozp import version

PKG = "ozp_backend"
REQUIREMENT_FILE = "requirements.prod.txt"
# TODO: REQUIREMENT_FILE = requirements.prod.txt ?

install_requires = [requirement.strip() for requirement in open(REQUIREMENT_FILE, "rt").readlines()]

EXCLUDE_FROM_PACKAGES = ['*.tests', 'tests.*']

package_data = {'': ['README.md', 'static']}

packages = find_packages(exclude=EXCLUDE_FROM_PACKAGES)

setup(name=PKG,
      version=version,
      packages=packages,
      package_data=package_data,
      include_package_data=True,
      install_requires=install_requires
)
