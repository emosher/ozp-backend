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

mkdir -p media
mkdir -p static
TEST_MODE=True python manage.py migrate --noinput
python manage.py collectstatic --noinput

pycodestyle ozp ozpcenter ozpiwc plugins tests --ignore=E501,E123,E128,E121,E124,E711,E402,E722 --show-source

echo "Number of cores `nproc`"
TEST_MODE=True pytest --junit-xml=junit-resutls.xml -n `nproc` --dist=loadscope
