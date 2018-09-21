## Background
Django-based backend API for the OZONE Platform (OZP).    
**ozp-backend** replaces [ozp-rest](https://github.com/ozone-development/ozp-rest)
as the backend for Center, HUD, Webtop, and IWC.     

Notable differences include:    

* Python vs. Java/Groovy
* Django, Django Rest Framework vs. Grails, JAX-RS
* Postgres vs. MySQL

## 3rd Party Services
Project relays on    
Travis-CI  [![Build Status](https://travis-ci.org/aml-development/ozp-backend.svg?branch=master)](https://travis-ci.org/aml-development/ozp-backend)

## Getting Started
### Development environment preparation
```
cd ~
mkdir git
cd git
git clone git@github.com:aml-development/ozp-backend.git
cd ozp-backend
virtualenv env
source env/bin/activate
pip install -r requirements.txt
```
If `virtualenv env` does not work it might be `python3 -m venv env` if the environment

### Building and running the OZP backend
```
cd ~/git/ozp-backend
source env/bin/activate
make dev
```

### MakeFile
There is a MakeFile in the project to run repetitive commands    

**Commands to setup server**    
`make pyenv` - Create Python environment and install requirements    
`make dev run` - Setup up the Development environment and run server on a SQLite Database without Elasticsearch    
`make dev` - Setup up the development environment running on a SQLite Database without Elasticsearch    
`make dev_psql` - Setup up the development environment running on a Postgres Database without Elasticsearch    
`make dev_es` - Setup up the development environment running on a SQLite Database with Elasticsearch     
`make reindex_es` - Reindex the data into Elasticsearch    

**Commands to run server**    
`make run` - Run the server    
`make run_es` - Run the server with Elasticsearch    
`make rung` - Run Server with gunicorn with a worker per core    
`make rung_es` - Run Server with gunicorn with a worker per core    
`make test` - Run all test    
`make ptest` - Run all test in parallel (increase speed of unit tests)

**Commands server**    
`make codecheck` - Run pycodestyle python linter on the code    
`make autopep` - Run tool to fix python code    
`make upgrade_requirements` - Update project python dependencies    

### Postgres Setup
Command to install postgresql (on Debian-based OS)
```
sudo apt-get install postgresql postgresql-contrib
```

Commands to setup postgresql for ozp-backend
```
sudo -i -u postgres
createuser ozp_user
psql -c 'ALTER USER ozp_user CREATEDB;'
psql -c "ALTER USER "ozp_user" WITH PASSWORD 'password';"
createdb ozp
psql -c 'GRANT ALL PRIVILEGES ON DATABASE ozp TO ozp_user;'
```

### Local development method (minimal)
To serve the application on your host machine with minimal external dependencies,
do the following:

1. Remove psycopg2 from requirements.txt (so that Postgres won't be required)
2. Enable HTTP Basic Auth and disable PKI authentication. In settings.py,
`REST_FRAMEWORK.DEFAULT_AUTHENTICATION_CLASSES` should be set to
`'rest_framework.authentication.BasicAuthentication'`
3. Disable the authorization service. In settings.py, set `OZP.USE_AUTH_SERVER`
to `False`
4. In settings.py, set `OZP.DEMO_APP_ROOT` to `localhost:8000` (or wherever
the django app will be served at)

Then, do the following:

1. Install Python 3.4.3. Python can be installed by downloading the appropriate
    files [here](https://www.python.org/downloads/release/python-343/). Note
    that Python 3.4 includes both `pip` and `venv`, a built-in replacement
    for the `virtualenv` package
2. Create a new python environment using python 3.4.x. First, create a new
    directory where this environment will live, for example, in
    `~/python_envs/ozp`. Now create a new environment there:
    `python3.4 -m venv ENV` (where `ENV` is the path you used above)
3. Active the new environment: `source ENV/bin/activate`
4. Install the necessary dependencies into this python environment:
    `pip install -r requirements.txt`
5. Run the server: `make dev`

Swagger documentation for the api is available at `http://localhost:8000/docs/`
Use username `wsmith` password `password` when prompted for authentication info

There's also the admin interface at `http://localhost:8000/admin`
(username: `wsmith`, password: `password`)

### ozp-ansible method
For those who just want to get OZP (Center, HUD, Webtop, IWC) up and running, see the
[quickstart](https://github.com/ozone-development/ozp-ansible#quickstart) of the [ozp-ansible](https://github.com/ozone-development/ozp-ansible) project.

The recommended approach is to use the vagrant box referenced at the beginning
of this README, which will create a production-esque deployment of OZP:

* Postgres (vs. SQLite)
* PKI (vs. HTTP Basic Auth)
* Use of external authorization service
* Enable HTTPS (via nginx reverse proxy)
* Served via Gunicorn (vs. Django development server)

### Runing Elasticsearch for Search
ozp/Settings.py file variable needs to be updated to `ES_ENABLED = True`    
After installing Elasticsearch run `make reindex_es` and run `make run_es` in the ozp-backend folder while inside of your $env     

### Installing and Running Elasticsearch    
ozp-backend requires Elasticsearch 2.4.1    
[Installation Guide for 2.4.1](https://www.elastic.co/guide/en/elasticsearch/reference/2.4/_installation.html)

The requirement for installing Elasticsearch is Java 7.    
Preferably, you should install the latest version of the official Java from www.java.com.    

You can get the Elasticsearch 2.4.1 from https://www.elastic.co/blog/elasticsearch-2-4-1-released.    
To install Elasticsearch, download and extract the archive file for your platform.    
Once you’ve extracted the archive file, Elasticsearch is ready to run.   

Below are the commands:
```
wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.4.1/elasticsearch-2.4.1.tar.gz
tar xvf elasticsearch-2.4.1.tar.gz
cd elasticsearch-2.4.1
./bin/elasticsearch
```

**Tip**    
When installing Elasticsearch in production, you can choose to use the Debian or RPM packages provided on the downloads page.    
You can also use the officially supported Puppet module, Chef cookbook, or Ansible.    

## Releasing
Run `python release.py` to generate a tarball with Wheels for the application
and all of its dependencies. See `release.py` for details

## Controlling Access
Anonymous users have no access - all must have a valid username/password (dev)
or valid certificate (production) to be granted any access

A few endpoints only provide READ access:

* storefront
* metadata

Several resources allow global READ access with WRITE access restricted to
Apps Mall Stewards:

* access_control
* agency
* category
* contact_type
* listing_type

**image**

* global READ of metadata, but access_control enforcement on the images
themselves
* WRITE access allowed for all users, but the associated access_control level
    cannot exceed that of the current user

**intent**

* global READ and WRITE allowed, but associated intent.icon.access_control
    cannot exceed that of the current user

**library**

* READ access for ORG stewards and above
* no WRITE access
* READ and WRITE access to /self/library for the current user

**notification**

* global READ access
* WRITE access restricted to Org Stewards and above, unless the notification
    is associated with a Listing owned by this user
* READ and WRITE access to /self/notification for the current user

**profile**

* READ access restrictpython manage.py runscript sample_dated to Org Stewards and above
* WRITE access restricted to the associated user (users cannot create, modify,
    or delete users other than themselves)
* READ and WRITE access to /self/profile for the current user

**listing**

* READ access restricted by agency (if listing is private) and by access_control
    level
* WRITE access:
    * global WRITE access to create/modify/delete a listing in the draft or
        pending state ONLY
    * Org Stewards and above can change the state to published/approved or
        rejected, and change state to enabled/disabled, but must respect
        Organization (an Org Steward cannot modify
        a listing for which they are not the owner and/or not a member of
        the listing's agency)
    * global WRITE access to create/modify/delete reviews (item_comment) for
        any listing (must respect organization (if private) and access_control)
* READ access to /self/listing to return listings that current user owns (?)

**Permission Types**

|Permission Types  | Description |
|:-----------|:------------|
|read | The Read permission refers to a user's capability to read the contents of the endpoint.|
|write | The Write permission refers to a user's capability to write contents to the endpoint.|
|access_control enforcement flag | access_control level cannot exceed that of the current user|

**Access Control Matrix**
<table>
    <tr>
        <th>ozp-center</th>
        <th colspan="5">Access Control</th>
    </tr>

    <tr>
        <th>Endpoint</th>
        <th>Anonymous Users</th>
        <th>Self</th>
        <th>Other</th>
        <th>Org Steward</th>
        <th>Apps Mall Steward </th>
        <th>Notes</th>
    </tr>

    <tr>
        <td>access_control (?)</td>
        <td>---</td>
        <td>r--</td>
        <td></td>
        <td>r--</td>
        <td>rw-</td>
        <td></td>
    </tr>

    <tr>
        <td>agency</td>
        <td>---</td>
        <td>r--</td>
        <td>r--</td>
        <td>r--</td>
        <td>rw-</td>
        <td></td>
    </tr>

    <tr>
        <td>category</td>
        <td>---</td>
        <td>r--</td>
        <td>r--</td>
        <td>r--</td>
        <td>rw-</td>
        <td></td>
    </tr>

    <tr>
        <td>contact_type</td>
        <td>---</td>
        <td>r--</td>
        <td>r--</td>
        <td>r--</td>
        <td>rw-</td>
        <td></td>
    </tr>

    <tr>
        <td>image (metadata)</td>
        <td>---</td>
        <td>rwa</td>
        <td>rwa</td>
        <td>rwa</td>
        <td>rwa</td>
        <td>Read: access_control enforcement on the images themselves, Write: associated access_control level cannot exceed that of the current user</td>
    </tr>

    <tr>
        <td>intent</td>
        <td>---</td>
        <td>rwa</td>
        <td>rwa</td>
        <td>rwa</td>
        <td>rwa</td>
        <td>associated intent.icon.access_control cannot exceed that of the current user</td>
    </tr>

    <tr>
        <td>library</td>
        <td>---</td>
        <td>r--</td>
        <td>r--</td>
        <td>r--</td>
        <td>r--</td>
        <td></td>
    </tr>

    <tr>
        <td>library (self)</td>
        <td>---</td>
        <td>rw-</td>
        <td>---</td>
        <td>---</td>
        <td>---</td>
        <td></td>
    </tr>

    <tr>
        <td>listing</td>
        <td>---</td>
        <td>r-a</td>
        <td>---</td>
        <td>rw-</td>
        <td>rw-</td>
        <td></td>
    </tr>

    <tr>
        <td>listing (self)</td>
        <td>---</td>
        <td>rw-</td>
        <td>---</td>
        <td>---</td>
        <td>---</td>
        <td></td>
    </tr>

    <tr>
        <td>listing_type (?)</td>
        <td>---</td>
        <td>r--</td>
        <td>---</td>
        <td>r--</td>
        <td>rw-</td>
        <td></td>
    </tr>

    <tr>
        <td>notification</td>
        <td>---</td>
        <td>rw-</td>
        <td>r--</td>
        <td>rw-</td>
        <td>rw-</td>
        <td></td>
    </tr>

    <tr>
        <td>profile</td>
        <td>---</td>
        <td>---</td>
        <td>---</td>
        <td>rw-</td>
        <td>rw-</td>
        <td>users cannot create, modify, or delete users other than themselves</td>
    </tr>

    <tr>
        <td>profile (self route)</td>
        <td>---</td>
        <td>rw-</td>
        <td>---</td>
        <td>---</td>
        <td>---</td>
        <td>Self</td>
    </tr>

    <tr>
        <td>storefront</td>
        <td>---</td>
        <td>R--</td>
        <td>---</td>
        <td>---</td>
        <td>---</td>
        <td>Get Storefront for current user</td>
    </tr>

    <tr>
        <td>metadata</td>
        <td>---</td>
        <td>R--</td>
        <td>---</td>
        <td>---</td>
        <td>---</td>
        <td>Get metadata for current user</td>
    </tr>

</table>

## Sample Users for BasicAuth
By default, HTTP Basic Authentication is used for login.    
This can be changed to PKI (client certificates) by changing `REST_FRAMEWORK.DEFAULT_AUTHENTICATION_CLASSES` in `settings.py`

Below are usernames that are part of our sample data (defined in
`ozp-backend/ozpcenter/scripts/sample_data_generator.py`) (password for all users is `password`):

**Admins:**    

* bigbrother (minipax)
* bigbrother2 (minitrue)
* khaleesi (miniplen)

**Org Stewards:**    

 * wsmith (minitrue, stewarded_orgs: minitrue)    
 * julia (minitrue, stewarded_orgs: minitrue, miniluv)    
 * obrien (minipax, stewarded_orgs: minipax, miniplenty)     

**Users:**    

 * aaronson (miniluv)
 * hodor (miniluv - PKI)
 * jones (minitrue)
 * tammy (minitrue - PKI)
 * rutherford (miniplenty)
 * noah (miniplenty - PKI)
 * syme (minipax)
 * abe (minipax - PKI)
 * tparsons (minipax, miniluv)
 * jsnow (minipax, miniluv - PKI)
 * charrington (minipax, miniluv, minitrue)
 * johnson (minipax, miniluv, minitrue - PKI)
