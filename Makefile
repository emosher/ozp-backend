# This is a make file to help with the commands
root:
	# '==Commands=='
	# 'dev - make new development environment'

clean:
	rm -f db.sqlite3
	rm -rf static/
	rm -rf media/
	rm -f ozp.log

create_static:
	mkdir -p static
	python manage.py collectstatic --noinput
	mkdir -p media

pre:
	export DJANGO_SETTINGS_MODULE=ozp.settings

test: clean pre create_static
	python -q -X faulthandler manage.py test

softtest: pre
	python -q -X faulthandler manage.py test

install_git_hooks:
	cp .hooks/pre-commit .git/hooks/

run:
	export MAIN_DATABASE=sqlite
	python manage.py runserver localhost:8001

run_es:
	ES_ENABLED=True python manage.py runserver localhost:8001

run_psql:
	export MAIN_DATABASE=psql
	python manage.py runserver localhost:8001

run_psql_es:
	export MAIN_DATABASE=psql
	ES_ENABLED=True python manage.py runserver localhost:8001

runp:
	gunicorn --workers=`nproc` ozp.wsgi -b localhost:8000 --access-logfile logs.txt --error-logfile logs.txt -p gunicorn.pid

codecheck:
	flake8 ozp ozpcenter ozpiwc plugins plugins_util --ignore=E501,E123,E128,E121,E124,E711,E402 --show-source

autopep:
	autopep8 ozp ozpcenter ozpiwc plugins plugins_util --ignore=E501,E123,E128,E121,E124,E711,E402 --recursive --in-place

autopepdiff:
	autopep8 ozp ozpcenter ozpiwc plugins plugins_util --ignore=E501,E123,E128,E121,E124,E711,E402 --recursive --diff

reindex_es:
	ES_ENABLED=TRUE python manage.py runscript reindex_es

recommend:
	python manage.py runscript recommend

recommend_es_user:
	ES_ENABLED=TRUE RECOMMENDATION_ENGINE='elasticsearch_user_base' python manage.py runscript recommend

recommend_es_content:
	ES_ENABLED=TRUE RECOMMENDATION_ENGINE='elasticsearch_content_base' python manage.py runscript recommend

dev: clean pre create_static
	export MAIN_DATABASE=sqlite
	python manage.py makemigrations ozpcenter
	python manage.py makemigrations ozpiwc
	python manage.py migrate

	echo 'Loading sample data...'
	python manage.py runscript sample_data_generator

	python manage.py runserver localhost:8001

# sudo apt-get install postgresql postgresql-contrib
# sudo -i -u postgres
# createuser ozp_user
# psql -c "ALTER USER "ozp_user" WITH PASSWORD 'password';"
# createdb ozp
# psql -c 'GRANT ALL PRIVILEGES ON DATABASE ozp TO ozp_user;'
dev_psql: clean pre create_static
	export MAIN_DATABASE=psql
	python manage.py makemigrations ozpcenter
	python manage.py makemigrations ozpiwc
	python manage.py migrate

	python manage.py flush --noinput # For Postgres

	echo 'Loading sample data...'
	python manage.py runscript sample_data_generator

	python manage.py runserver localhost:8001
