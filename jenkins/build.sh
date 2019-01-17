#! /bin/bash
# create clean python env
rm -rf ~/python_envs/ci-env/
mkdir ~/python_envs/ci-env/
pyvenv-3.6 ~/python_envs/ci-env/
source ~/python_envs/ci-env/bin/activate
# install prereqs (clean)
pip install --upgrade pip
# this is super sketchy, but without it, psycopg2 will fail to install (won't be
# able to find lib2to3 stuff)
# /opt/lib2to3 was copied from a clean Python-3.4.3 build (Lib directory)
cp -r /opt/lib2to3 ~/python_envs/ci-env/lib/python3.4/site-packages/
export PATH=/usr/local/pgsql/bin:$PATH
pip install -r requirements.txt --no-cache-dir -I

# Install Wheel in the env
pip install wheel

# make the release
python release.py --no-version
