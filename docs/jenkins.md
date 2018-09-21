## Jenkins
Jenkins is a Continuous Integration Software tool

### Download and running Jenkins
```
wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
java -jar jenkins.war --httpPort=8082
```

* Browse to http://localhost:8080
* Follow instructions to install

## Master and Slave Jenkins
(Jenkins Distributed Builds)[https://wiki.jenkins.io/display/JENKINS/Distributed+builds]
(What-is-the-use-of-master-and-slave-in-Jenkins)[https://www.quora.com/What-is-the-use-of-master-and-slave-in-Jenkins]

```
+----------------+
| Github Push    |
+-------+--------+
        |
        v
   +---------+
   | Jenkins |     +--------------+
   | Master  |     | ci-release   |
   |         |     | Deployment   |
   +----+----+     |  Machine     |
        |          |              |
        |          +-+------------+
        v            ^
+----------+-------+ |
| Jenkins          | |   +--------------+
| Slave            | |   | ci-lastest   |
| Label:           | |   | Deployment   |
|  ci-jenkins.proj | |   |  Machine     |
|                  | |   |              |
+-------------+----+ |   +-----+--------+
           |         |       ^
           +---------+-------+
```
There are 4 boxes in the above CI Configuration.    
Note:  Jenkins slave is not necessary    

### Boxes

* Jenkins Master - Is the main Jenkins Instance
    * DNS: jenkins.domain.com
* Jenkins Slave - It is the machine used to run all the build to deploy it to deployment machines
    * It will build any jobs with the label `proj`
    * Will be responsible of creating release archive(tar) file then use ssh publisher to deployment machine
    * DNS: ci-jenkins.proj.domain.com
* ci-latest - deployment of master branch
    * Will be responsible of using release archive(tar) with ansible to install software locally (will have sub build per repo)
    * DNS: ci-latest.proj.domain.com
* ci-release - deployment of latest release tag
    * DNS: ci-release.proj.domain.com


## Jenkins Jobs
There will be 4 jobs per git repo (release and latest)

Git Repos and Jobs names

* ozp-center
    * center-latest-test
    * center-latest-build
    * center-release-test
    * center-release-build
* ozp-backend
    * backend-latest-test
    * backend-latest-build
    * backend-release-test
    * backend-release-build

etc....

### Setting up ozp folder on Jenkins CI

* Create a new folder called `ozp`

### Defaults for all jobs

* Under the General tab
    * Select `Discard Old Builds` with `Log Rotation` Strategy
        * Max # of builds to keep `2`
    * Select `Throttle Concurrent Builds`
        * Set `Maximum Total Concurrent Builds` to `1`
        * Set `Maximum Concurrent Builds Per Node` to `1`
        * Multi-Project Throttle Category [x] ozp-build , [ ] ozp-deploy
    * Select `Restrict where this project can be run`
        * Label Expression: `ci-jenkins.proj.domain.com`
    * Select `Github project`,
        * make `project_url` to `https://github.com/aml-development/{RepositoryName}/`
* Under `Source Code Management`, Select Git
    * Repository URL: `https://github.com/aml-development/{RepositoryName}.git`
    * Branches to build: `*/master` , for release `*/tags/release/*`
* Under `Build Triggers` (Only for test jobs)
    * Select `GitHub hook trigger for GITScm polling`
* Under `Build Environment`
    * Select `Delete workspace before build starts`
    * Select `Abort the build if it's stuck`, Time-out strategy: `Absolute`, Timeout minutes: `15`
* Under `Post-build Actions`
    * Archive the archive
        * File to archive: `???`
    * Send build artifacts over ssh
        * SSH Server Name: `ci-latest.proj.domain.com`
        * Exec command: `sudo /home/jenkins/ozp_deploy.sh ${JOB_NAME} ${BUILD_NUMBER}`
    * Delete workspace when build is done

### Setting up ozp-center on Jenkins CI
* Create a new `freestyle project` called `build-center-latest` and `build-center-release`
* Under `Build`
    * Execute Shell
```
#!/usr/bin/env bash
# use the develop branch of ozp-react-commons
# sed -i -e "s/ozp-react-commons#master/ozp-react-commons#develop/g" package.json
# sed -i -e "s/\/icons/\/icons#1fc7aee3a2812042c421baaab67abb2bd9606b0d/g" package.json
source /usr/local/node_versions/set_node_version.sh 5.3.0
echo "node version: "
node -v
npm install
npm run build
npm run test
npm run tarDistDate
```

* Under `Build`
    * Conditional Step (single), run `Text Finder`
        * Select `Also search the console output`, Regular expression: `Cannot resolve module`
        * Execute Shell

```
#!/usr/bin/env bash
echo "detected build error. Failing build"
exit 1
```

* Under `Post-build Actions`
    * `Archive the archive`,  File to archive: `center-*.tar.gz`

### Setting up ozp-hud on Jenkins CI
* Create a new `freestyle project` called `build-hud-latest` and `build-hud-release`
* Under `Build`
    * Execute Shell
```
#!/usr/bin/env bash
source /usr/local/node_versions/set_node_version.sh 5.3.0
npm install
npm run install
npm run build
npm run tarDistVersion
```

* Under `Build`
    * Conditional Step (single), run `Text Finder`
        * Select `Also search the console output`, Regular expression: `Cannot resolve module`
        * Execute Shell

```
#!/usr/bin/env bash
echo "detected build error. Failing build"
exit 1
```

* Under `Post-build Actions`
    * `Archive the archive`,  File to archive: `hud-*.tar.gz`


### Setting up ozp-webtop on Jenkins CI
* Create a new `freestyle project` called `build-webtop-latest` and `build-webtop-release`
* Under `Build`
    * Execute Shell
```
# sed -i -e "s/\/icons/\/icons#1fc7aee3a2812042c421baaab67abb2bd9606b0d/g" bower.json
source /usr/local/node_versions/set_node_version.sh 5.3.0
npm install
npm run bower
npm run build
npm run compile
npm run tarDevDate
npm run tarProdDate
```
* Under `Post-build Actions`
    * `Archive the archive`,  File to archive: `webtop-*.tar.gz`

### Setting up ozp-demo on Jenkins CI
* Create a new `freestyle project` called `build-demo-latest` and `build-demo-release`
* Under `Build`
    * Execute Shell
```
#!/usr/bin/env bash
source /usr/local/node_versions/set_node_version.sh 0.12.7
npm install
bower install
bower update
npm run tarDate
```
* Under `Post-build Actions`
    * `Archive the archive`,  File to archive: `demo-apps-*.tar.gz`


### Setting up ozp-iwc on Jenkins CI
* Create a new `freestyle project` called `iwc-latest-build` and `iwc-release-build`
* Under `Build`
    * Execute Shell
```
#!/usr/bin/env bash
source /usr/local/node_versions/set_node_version.sh 0.12.7
npm install
npm run bower
npm run build
npm run tarDate
```
* Under `Post-build Actions`
    * `Archive the archive`,  File to archive: `iwc-*.tar.gz`

### Setting up ozp-react-commons on Jenkins CI
* Create a new `freestyle project` called `detect-ozp-react-commons-latest` and `detect-ozp-react-commons-release`
* Under `Build`
    * Execute Shell
```
#!/usr/bin/env bash
source /usr/local/node_versions/set_node_version.sh 5.3.0
echo "node version: "
node -v
npm install
npm run test
```
* Under `Post-build Actions`
    * `Build other projects`
        * Projects to build: `build-center-release,build-hud-release`
        * Trigger only if build is stable

### Setting up ozp-security on Jenkins CI
* Create a new `freestyle project` called `OZP-Security-Plugin`
* Under `Build`
    * Maven Version `Maven 3.0.5`
    * Root Pom `Root Pom`
    * Goals and options `package`
* Post Steps: Run regardless of build results

* Under `Post-build Actions`
    * `Archive the archive`,  File to archive: `target\*.jar`

### Setting up ozp-backend on Jenkins CI
#### Build jobs
* Create a new `freestyle project` called `backend-latest-build` and `backend-release-build`
* Under `Build`
    * Execute Shell
```
sh jenkins/build.sh
```
* Under `Post-build Actions`
    * `Archive the archive`,  File to archive: `backend*.tar.gz`
    * Send build artifacts over ssh
        * SSH Server Name: `ci-latest.proj.domain.com`
        * Exec command: `sudo /home/jenkins/ozp_deploy.sh ${JOB_NAME} ${BUILD_NUMBER} --es_enabled=True`

#### Test jobs
* Create a new `freestyle project` called `backend-latest-test` and `backend-release-test`
* Under `Build`
    * Execute Shell
```
sh jenkins/test.sh
```

* Under `Post-build Actions`
    * `Archive the archive`,  File to archive: `ozp.log`
    * `Build Other Projects`=`build-backend-latest`, Trigger only if build is stable
    * `Publish HTML Report`
        * `HTML directory to archive`: cover

### Setting up `bundle-front-end-master` on jenkins ci
* Project Name `bundle-front-end-master`    
* Description
```
Creates a bundle with all the current Front End components:    
* HUD
* Center
* IWC
* WebTop
```
* Source Code Management: None
* Build Triggers
    * Build after other projects are built:
        * build-center-release,build-hud-release,build-iwc-release,build-webtop-release    
        * Trigger only if build is stable
* Build
    * Copy Artifacts from another projects
        * Project Name `build-webtop-release`
        * Which Build `Lastest Successful build (Stable build only)``
        * Artifacts to copy `webtop*prod*.tar.gz`
        * Target directory `$WORKSPACE/staging`
        * [x] Fingerprint Artifacts
    * Copy Artifacts from another projects
        * Project Name `build-center-release`
        * Which Build `Lastest Successful build (Stable build only)``
        * Artifacts to copy `center*prod*.tar.gz`
        * Target directory `$WORKSPACE/staging`
        * [x] Fingerprint Artifacts
    * Copy Artifacts from another projects
        * Project Name `build-hud-release`
        * Which Build `Lastest Successful build (Stable build only)``
        * Artifacts to copy `hud*prod*.tar.gz`
        * Target directory `$WORKSPACE/staging`
        * [x] Fingerprint Artifacts
    * Copy Artifacts from another projects
        * Project Name `build-iwc-release`
        * Which Build `Lastest Successful build (Stable build only)``
        * Artifacts to copy `iwc*prod*.tar.gz`
        * Target directory `$WORKSPACE/staging`
        * [x] Fingerprint Artifacts
    * Execute Shell
```
#!/bin/sh
mkdir -p $WORKSPACE/target
cd $WORKSPACE/staging && tar -zcf $WORKSPACE/target/front-end-bundle-current.tar.gz *.tar.gz
```

* Post-build Actions
    * Archive the Artifacts
        * Files to Archive `target/*.tar.gz`
