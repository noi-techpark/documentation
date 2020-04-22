# Flight rules for ODH

#### What are "flight rules"?

A [guide for astronauts](https://www.jsc.nasa.gov/news/columbia/fr_generic.pdf) (now, programmers contributing to the
Open Data Hub) about what to do when things go wrong, _or must be executed with no delay_.

> *Flight Rules* are the hard-earned body of knowledge recorded in manuals that list, step-by-step, what to do if X
> occurs, and why. Essentially, they are extremely detailed, scenario-specific standard operating procedures. [...]

> NASA has been capturing our missteps, disasters and solutions since the early 1960s, when Mercury-era ground teams
> first started gathering "lessons learned" into a compendium that now lists thousands of problematic situations, from
> engine failure to busted hatch handles to computer glitches, and their solutions.

&mdash; Chris Hadfield, *An Astronaut's Guide to Life*.

_ps. Idea taken from the [GIT flight rules](https://github.com/k88hudson/git-flight-rules) project._

----

#### Table of Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Licensing and REUSE compliance](#licensing-and-reuse-compliance)
- [OAuth](#oauth)
  - [I want to access the console of Keycloak as regular user](#i-want-to-access-the-console-of-keycloak-as-regular-user)
  - [I want to access the console of Keycloak as user "admin"](#i-want-to-access-the-console-of-keycloak-as-user-admin)
  - [I want to get an access token from our OAuth 2.0 Keycloak Server](#i-want-to-get-an-access-token-from-our-oauth-20-keycloak-server)
  - [I get an error called o.k.adapters.RequestAuthenticator: SSL is required to authenticate](#i-get-an-error-called-okadaptersrequestauthenticator-ssl-is-required-to-authenticate)
- [Work Flow and Release Management](#work-flow-and-release-management)
  - [I want to create a project for ODH](#i-want-to-create-a-project-for-odh)
  - [I want to know how the git flow works for a project of ODH](#i-want-to-know-how-the-git-flow-works-for-a-project-of-odh)
  - [I want to release a new version of an ODH-project](#i-want-to-release-a-new-version-of-an-odh-project)
  - [I found a small bug, and want to fix it immediately on a released version](#i-found-a-small-bug-and-want-to-fix-it-immediately-on-a-released-version)
- [GitHub](#github)
  - [I want to create a repository](#i-want-to-create-a-repository)
  - [I want to give access to a public repository](#i-want-to-give-access-to-a-public-repository)
  - [I want to give access to a private repository](#i-want-to-give-access-to-a-private-repository)
  - [I want to prepare the CI for pull requests](#i-want-to-prepare-the-ci-for-pull-requests)
- [Pimcore](#pimcore)
  - [I want to send emails from my Pimcore instance](#i-want-to-send-emails-from-my-pimcore-instance)
  - [I want to add new Pimcore web page to an existing Pimcore machine](#i-want-to-add-new-pimcore-web-page-to-an-existing-pimcore-machine)
  - [I want to add a test environment of a new Pimcore installation](#i-want-to-add-a-test-environment-of-a-new-pimcore-installation)
  - [I want to update Pimcore](#i-want-to-update-pimcore)
  - [I want to install a Pimcore, that needs a newer PHP version](#i-want-to-install-a-pimcore-that-needs-a-newer-php-version)
  - [I want to create Jenkinsfiles for an newly installed Pimcore webpage](#i-want-to-create-jenkinsfiles-for-an-newly-installed-pimcore-webpage)
  - [I want to upload files to Pimcore greater than 2MB](#i-want-to-upload-files-to-pimcore-greater-than-2mb)
- [Jenkins Pipelines](#jenkins-pipelines)
  - [I want to execute arbitrary commands on the remote server](#i-want-to-execute-arbitrary-commands-on-the-remote-server)
  - [I want to execute git commands on the remote server](#i-want-to-execute-git-commands-on-the-remote-server)
  - [I want to create a cron-job to clone AWS instances](#i-want-to-create-a-cron-job-to-clone-aws-instances)
- [Servers](#servers)
  - [I want to setup an SMTP server](#i-want-to-setup-an-smtp-server)
  - [I want to create a test clone of a server instance](#i-want-to-create-a-test-clone-of-a-server-instance)
  - [I want to give server-access via SSH to an external contributor](#i-want-to-give-server-access-via-ssh-to-an-external-contributor)
  - [I want to create a new Tomcat server instance on AWS for Testing](#i-want-to-create-a-new-tomcat-server-instance-on-aws-for-testing)
  - [I want to create a new Tomcat server instance on AWS Elasticbeanstalk for Production](#i-want-to-create-a-new-tomcat-server-instance-on-aws-elasticbeanstalk-for-production)
  - [I want to create a new Pimcore server instance on AWS](#i-want-to-create-a-new-pimcore-server-instance-on-aws)
  - [I want to use a swap file on my server](#i-want-to-use-a-swap-file-on-my-server)
  - [I want to make my web server HTTPS compliant](#i-want-to-make-my-web-server-https-compliant)
  - [I want to mount an aws s3 bucket on my server](#i-want-to-mount-an-aws-s3-bucket-on-my-server)
    - [Prerequisit](#prerequisit)
    - [Setup](#setup)
  - [I want to automate server updates](#i-want-to-automate-server-updates)
  - [I want to install the CloudWatch Agent on a Linux machine](#i-want-to-install-the-cloudwatch-agent-on-a-linux-machine)
  - [I want to install the CloudWatch Agent on a Windows machine](#i-want-to-install-the-cloudwatch-agent-on-a-windows-machine)
- [Documentation](#documentation)
  - [I want to add a table of contents to a markdown file](#i-want-to-add-a-table-of-contents-to-a-markdown-file)
- [Database](#database)
  - [I run out of disk space on an AWS/RDS Postgres instance](#i-run-out-of-disk-space-on-an-awsrds-postgres-instance)
  - [I want to enable logical replication on an AWS/RDS Postgres instance](#i-want-to-enable-logical-replication-on-an-awsrds-postgres-instance)
  - [I want to create a read-only user (aka role)](#i-want-to-create-a-read-only-user-aka-role)
  - [I want to diff two tables with the same schema](#i-want-to-diff-two-tables-with-the-same-schema)
  - [I want to backup and restore specific schemas](#i-want-to-backup-and-restore-specific-schemas)
- [Open Data Hub Mobility](#open-data-hub-mobility)
  - [I want to create links between stations](#i-want-to-create-links-between-stations)
  - [I want to delete an link/edge between stations](#i-want-to-delete-an-linkedge-between-stations)
  - [I want to change visibility of mobility data](#i-want-to-change-visibility-of-mobility-data)
    - [I want to declare some records as open data](#i-want-to-declare-some-records-as-open-data)
    - [I want to add or disable a new user to be used in V1](#i-want-to-add-or-disable-a-new-user-to-be-used-in-v1)
    - [I want to add a new user to be used in V2](#i-want-to-add-a-new-user-to-be-used-in-v2)
    - [I want to retrieve closed data in V2](#i-want-to-retrieve-closed-data-in-v2)
    - [I want to add a new role](#i-want-to-add-a-new-role)
    - [I want to combine a role with users](#i-want-to-combine-a-role-with-users)
    - [I want to define filter rules for a certain role](#i-want-to-define-filter-rules-for-a-certain-role)
    - [I want to debug my rules](#i-want-to-debug-my-rules)
- [Maven](#maven)
  - [I want to run maven without tests](#i-want-to-run-maven-without-tests)
  - [I want to run maven in a non-interactive mode without output colors](#i-want-to-run-maven-in-a-non-interactive-mode-without-output-colors)
  - [I want to force maven to always update dependencies](#i-want-to-force-maven-to-always-update-dependencies)
  - [I want to use maven to deploy on a tomcat server](#i-want-to-use-maven-to-deploy-on-a-tomcat-server)
  - [ODH Maven repository](#odh-maven-repository)
    - [I want to use an open source java library of the OpenDataHub](#i-want-to-use-an-open-source-java-library-of-the-opendatahub)
    - [I want to upload an artifact to the odh maven repository](#i-want-to-upload-an-artifact-to-the-odh-maven-repository)
- [App Development](#app-development)
  - [Android](#android)
    - [I want to add a new tester to an App on Google Play](#i-want-to-add-a-new-tester-to-an-app-on-google-play)
  - [iOS](#ios)
    - [I want to renew the development and distribution certificates](#i-want-to-renew-the-development-and-distribution-certificates)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

----

## Licensing and REUSE compliance

See REUSE-specific [flight rules](https://github.com/noi-techpark/reuse).

## OAuth

### I want to access the console of Keycloak as regular user

Go to https://auth.opendatahub.bz.it/auth/admin/noi/console and login with
"yourname/password..."

Test server is https://auth.opendatahub.testingmachine.eu/auth/admin/noi/console

### I want to access the console of Keycloak as user "admin"

Go to https://auth.opendatahub.bz.it and login with "admin/password..."

Test server is https://auth.opendatahub.testingmachine.eu

### I want to get an access token from our OAuth 2.0 Keycloak Server

There are two methods, first with `grant_type=password`:
```sh
curl -X POST -L -H 'Content-Type:application/x-www-form-urlencoded' \
    "https://auth.opendatahub.bz.it/auth/realms/noi/protocol/openid-connect/token" \
    -d 'grant_type=password&username=***&password=****&client_id=your-client-id'
```

...and second, with `grant_type=refresh_token`, which you should have got with
the call above.
```sh
curl -X POST -L -H 'Content-Type:application/x-www-form-urlencoded' \
    "https://auth.opendatahub.bz.it/auth/realms/noi/protocol/openid-connect/token" \
     -d 'grant_type=refresh_token&refresh_token=*****&client_id=your-client-id'
```

Example: `client_id=odh-mobility-v2` to access the mobility Ninja API. To find
your `client_id` go to [keycloak/noi/clients](https://auth.opendatahub.bz.it/auth/admin/noi/console/#/realms/noi/clients).

NB: Use `https://auth.opendatahub.testingmachine.eu`, if you want to get tokens from our
Keycloak test server.

Testing? You can see the contents of this token with https://jwt.io.

### I get an error called o.k.adapters.RequestAuthenticator: SSL is required to authenticate

Since we use the API behind our Lets Encrypt Proxy, the proxy itself handles SSL termination.
The connection between the proxy and the API is not secure by definition, hence we need to
deactivate it for Keycloak otherwise we get an error

```
o.k.adapters.RequestAuthenticator : SSL is required to authenticate. Remote address 34.255.139.75 is secure: false, SSL required for: EXTERNAL .'
```

Set `KEYCLOAK_SSL_REQUIRED=none`

Possible values: 'none', 'external', 'all'
Source:
https://www.keycloak.org/docs/latest/securing_apps/index.html#_java_adapter_config

## Work Flow and Release Management

### I want to create a project for ODH

Each project must be on our github `noi-techpark`. So, if you want to create a new repository, do:
```shell
cd your-project
git init
git add <some-files>
git commit -m "Initial import"
git remote add origin https://github.com/noi-techpark/<your-git-repository>.git
git push -u origin master
```
...or push an existing repository:
```shell
cd your-project
git remote add origin https://github.com/noi-techpark/<your-git-repository>.git
git push -u origin master
```
Then, create a development branch and protect the master branch (See Github>Settings>Branches>Protected branches).

Important notes:
  - We consider a `master` branch as production-ready at each new HEAD
  - We consider a `development` branch in an unstable-testing state
  - You can optionally also have additional branches for features or hotfixes

NB: We can make an exception of this repository structure, iff a project is all of the following...
  - on a private repository
  - has no external contributors
  - is a really simple project

...then you do not need to create a `development` branch and do not protect the `master` branch.

### I want to know how the git flow works for a project of ODH

This work is based on [Vincent Driessen's post](https://nvie.com/posts/a-successful-git-branching-model/), about a
successful Git branching model, and [Semantic Versioning](https://semver.org). We suggest, that you read these
articles to better understand what follows.

Please read [I want to create a project for ODH](#i-want-to-create-a-project-for-ODH) before you start.

We have two main branches:
  - `master` contains production-ready commits only
     - Each HEAD has a version bump commit, and a corresponding git tag
  - `development` contains the unstable work-in-progress commits
     - No version commits, except from historical ones

...and supporting branches:
  - `release-<version>` branches off from `development` during last steps before release
    - No new features are allowed here, just some minor bugfixes and adaptations
    - Bump versions during this stage
  - `hotfix-<version>` branches off from `master` and allow fast and uncomplicated bug fixes, without intermediate
    steps inside `development`
    - Must be merged to `master` and `development` at the end
    - no fast-forward (`--no-ff`)

### I want to release a new version of an ODH-project

We have a `master` branch with a release at `1.0.0` and want now to release a new `development` branch. The new version
should be `1.1.0`, since we add a new feature. (See https://semver.org to understand how to choose a new version)

First, we create a new `release-1.1.0` branch, and bump the version on that branch.
```shell
git checkout -b release-1.1.0 development
./my-personal-script-to-bump-version 1.1.0
git commit -am "Bump version to 1.1.0"
```
Assume, we find out, that there is a minor bug. This can be fixed immediately on this branch. This new branch may exist
there for a while, until the release may be rolled out definitely. During that time, bug fixes may be applied in this
branch. Adding large new features here is strictly prohibited. They must be merged into `development`, and therefore,
wait for the next big release. Finally, we merge this new release into `master`, and tag it with version `1.1.0`.
```shell
git checkout master
git merge --no-ff release-1.1.0
git tag -a 1.1.0 -m 1.1.0
git push origin 1.1.0
git push
```
We merge all changes also to `development`, and delete the release-branch, when done.
```shell
git checkout development
git merge --no-ff release-1.1.0
git branch -d release-1.1.0
```
### I found a small bug, and want to fix it immediately on a released version

We have a `master` branch with a release at `1.0.0` and want now to fix a bug. The new version should be `1.0.1`, since
this is just a bugfix and not changing functionality. (See https://semver.org to understand how to choose a new version)

Create a `hotfix-1.0.1` branch, and bump the version.
```shell
git checkout -b hotfix-1.0.1 master
./my-personal-script-to-bump-version 1.0.1
```
Do your work and commit the fix. Include an `issue-id` to the commit message, which you can get from the github
issue tracker. If the issue is not present now, create a new one and describe the issue briefly. Assume, we have an
issue on github with id `13`.
```shell
git commit -am "Fix severe production issue\nFixes #13."
```
Merge it back into `master` (with a tag) and `development` (without tag).
```shell
git checkout master
git merge --no-ff hotfix-1.0.1
git tag -a 1.0.1 -m 1.0.1
git push origin 1.0.1
git push
git checkout development
git merge --no-ff hotfix-1.0.1
```
We do not need the `hotfix` branch any longer.
```shell
git branch -d hotfix-1.0.1
```

## GitHub

### I want to create a repository

Create a new GitHub repository (private or public).

Create a `Jenkinsfile-CI` in the repository and specify the build steps.

Create a new Jenkins pipeline at [https://ci.opendatahub.bz.it](https://ci.opendatahub.bz.it)

- Type: **Multibranch Pipeline**
- Branch Sources: **GitHub**
    - Attention: For **Discover pull requests from forks** the trust part must be set to **From users with Admin or Write permission** to only allow users with Admin or Write permissions to modify the Jenkinsfile
- Build Configuration: Reference the Jenkinsfile with the continuous integration build steps
- Properties: Enable **Enable project-based security** and set the following permissions

### I want to give access to a public repository

Provide authenticated users access to the Continuous Integration Jenkins Server:

- Configure the Jenkins Pipeline for the repository at [https://ci.opendatahub.bz.it](https://ci.opendatahub.bz.it)
- Add **Read (Job)** permissions to authenticated users under Properties (project-based security)

### I want to give access to a private repository

Provide the contributor access to the GitHub repository:

- Add the contributor with **read** permissions to the GitHub private repository.

Provide the contributor access to the Continuous Integration Jenkins Server:

- Configure the Jenkins Pipeline for the repository at [https://ci.opendatahub.bz.it](https://ci.opendatahub.bz.it)
- Add the contributors GitHub username under Properties (project-based security) and give him **Read (Job)** permissions

### I want to prepare the CI for pull requests

Due to security constraints, during the build of a pull request the Jenkinsfile of the target branch will be executed (ex. master).

However, to still include CI steps for the pull request, the steps must be defined in the target branch (ex. master). To prevent that the CI is then failing for this target branch and succeeding for the pull request, an if statement can be added to only execute the tests when certain files exist.

```groovy
stage('Test') {
    steps {
        sh 'if [ -d "path/to/file/of/new/part" ]; then ./testing-command-of-new-part; else true; fi'
    }
}
```

## Pimcore

### I want to send emails from my Pimcore instance

We use `info@example.com` and an [AWS/SES SMTP
server](#i-want-to-setup-an-smtp-server) for that, and configure Pimcore as
follows (`Settings/System Settings/Email Settings/SMTP`):

```
Email Method: smtp
SMTP Host: email-smtp.eu-west-1.amazonaws.com
SMTP Transport Security: TLS
SMTP Port: 587
SMTP Name: info@example.com
SMTP Authentication Method: LOGIN
SMTP Username: (see your AWS/SES credentials)
SMTP Passord: (see your AWS/SES credentials)
```

Test the configuration under Pimcore with `Tools/Email/Send
Test-Email`.

Clear the cache with `Settings/Cache/Clear Cache/Symfony Environment: all`.

If it does not work, make sure you verified `info@example.com` in your AWS
console. See [AWS/SES SMTP server details](#i-want-to-setup-an-smtp-server) for
that. Pimcore logs can be found under `/var/logs/prod.log` and
`/var/logs/php.log`.


### I want to add new Pimcore web page to an existing Pimcore machine

We want to add a new Pimcore webpage, called `myproject.org`, to our
multi-Pimcore server. However, Pimcore needs not just a bundle, but also
database dumps and other binary data like images. We want to use PHP 7.2 and
Pimcore 5.4.0 for that.

`ssh` into your Pimcore server and
[install](#i-want-to-install-a-pimcore-that-needs-a-newer-php-version) `php 7.2`
and dependencies, if needed.
Download Pimcore management scripts from our [Pimcore Automation
Repo](https://github.com/noi-techpark/pimcore-automation).
You need at least 3GB for the next steps. Eventually, install a [swap
file](#i-want-to-use-a-swap-file-on-my-server).

Install and configure `myproject.org` with
```shell
sudo ./manage-project.sh add myproject.org 5.4.0 \
    your_mysql_password your_pimcore_user your_pimcore_password
```
... this may take several minutes.

Download the database dump onto your server (for instance, `myproject-dump.sql`)
and restore it to the already setup MySQL database. Your MySQL user and database
name is `myprojectorg`. It is the same as the folder in `/var/www`, a sanitized
version of your previously defined domain `myproject.org`.

```shell
mysql --user myprojectorg -p myprojectorg < myproject-dump.sql
```

Download (for example, `myprojectshttpdocs.tar.gz`) and install a first version
of the whole page directly into the web-root folder `/var/www/myprojectorg`.
Clean it first.

```shell
sudo rm -rf /var/www/myprojectorg/*
cd /var/www/myprojectorg
tar xvzf myprojectshttpdocs.tar.gz
sudo chown -R www-data:www-data .
```

Since we replaced our document root with new files given by external developers,
we need to make sure the right credentials are set for Pimcore.

```shell
sudo vim /var/www/myprojectorg/var/config/system.php
```

Check if folders, files and permissions set inside of vhosts are set correctly
inside `/etc/apache2/sites-enabled/myprojectorg.conf`. Create them in case they
are not present yet.

Clear Pimcore's chaches for `dev` and `prod` environments, and correct symbolic
links.
```shell
cd /var/www/myprojectorg
sudo -u www-data rm -fr var/cache/*
sudo -u www-data ./bin/console c:c -e dev
sudo -u www-data ./bin/console c:c -e prod
sudo -u www-data ./bin/console assets:install --symlink --relative
```

Normally this is enough! If some bundles need more, they should provide that
information beforehand.

### I want to add a test environment of a new Pimcore installation

We [added `davinci.bz.it` to a multi-Pimcore instance](#i-want-to-add-new-pimcore-web-page-to-an-existing-pimcore-machine) and want now a test environment
reachable with `https://test.davinci.bz.it`, which gets cloned during night and updated
each time a new commit gets pushed to the davinci repository.

First, go to AWS/Route53 and add `test.davinci.bz.it` to the `davinci.bz.it` domain
```
Name : test.davinci.bz.it
Type : CNAME
TTL  : 300
Value: proxy.opendatahub.bz.it
```

Second, login to the our letsencrypt proxy and make `test.davinci.bz.it` [https compliant](#i-want-to-make-my-web-server-https-compliant).

Third, go to our [server deployment repository](https://github.com/noi-techpark/server-deployment)
and add a new stage to `Jenkinsfile-Pimcore-Nightly-Clones` as follows:
```groovy
stage('davinci.bz.it') {
    steps {
        sh './utils/pimcore-update-domain $KEY $SERVER_IP test.davinci.bz.it davinci/html davinci.conf'
    }
}
```
...where `$KEY` is the ssh key, the `$SERVER_IP` is the pimcore test server (clone of the
multi-pimcore production machine), `test.davinci.bz.it` is the domain, `davinci/html` is the
document root folder inside `/var/www` and `davinci.conf` is the Apache2 configuration inside
`/etc/apache2/sites-enabled/`. See [server-deployment.git/utils/pimcore-update-domain](https://github.com/noi-techpark/server-deployment/blob/master/utils/pimcore-update-domain) for details.

Finally, create a [Jenkins deployment](#i-want-to-create-jenkinsfiles-for-an-newly-installed-pimcore-webpage) script inside the davinci repository.

### I want to update Pimcore

I want to update my Pimcore to version `5.4.0`.

Run `/var/www/html/bin/console --update=5.4.0`

It needs at least 3GB of RAM, consider to [enable a swap
file](#i-want-to-use-a-swap-file-on-my-server), if it fails due to low memory
error.

### I want to install a Pimcore, that needs a newer PHP version

I want to install `PHP 7.2` on an existing Pimcore machine.

`ssh` into your Pimcore server, and type `php -v`. See if the update is needed.

If you have an older version, install `php 7.2` and dependencies.

```shell
sudo apt-get install apt-transport-https lsb-release ca-certificates
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" \
    | sudo tee -a /etc/apt/sources.list.d/php.list > /dev/null
sudo apt-get update

sudo apt-get -y install apache2 ntp mysql-server php7.2-fpm php7.2-gd \
                php7.2-mysql php7.2-curl unzip php7.2-xml php7.2-intl php7.2 \
                php7.2-common php7.2-gd php7.2-mysql php7.2-imap php7.2-cli \
                mcrypt imagemagick php7.2-curl php7.2-intl php7.2-pspell \
                php7.2-recode php7.2-tidy php7.2-xmlrpc php7.2-xsl php-imagick \
                php-gettext php7.2-zip php7.2-mbstring php7.2-soap php7.2-bz2 \
                php7.2-apcu curl
```

Configure and reload Apache:
```shell
sudo a2enmod actions proxy_fcgi setenvif alias rewrite expires headers
sudo a2enconf php7.2-fpm
sudo service apache2 reload
```

### I want to create Jenkinsfiles for an newly installed Pimcore webpage

You have a [newly installed
project](#i-want-to-add-new-pimcore-web-page-to-an-existing-pimcore-machine)
called `myproject.org` and you want to create Jenkins pipelines now. We do that
with [remotely executed
commands](#i-want-to-execute-arbitrary-commands-on-the-remote-server) via ssh.

Copy the following snippet into two files located inside the root folder of your
Pimcore webpage repository: `Jenkinsfile-production-deploy` and
`Jenkinsfile-testserver-deploy`.

```groovy
pipeline {
    agent any

    environment {
        KEY = credentials('your-servers-key.pem')
    }

    stages {
        stage('Deploy') {
            steps {
                sh '''
                    ssh -i ${KEY} www-data@123.123.123.123 \
                        "set -xeo pipefail
                         cd myprojectorg
                         cp var/config/website-settings.php ../website-settings.php
                         git fetch --all --prune
                         git reset --hard origin/master
                         git pull
                         ### Change settings in system.php (mostly just for test environments), like:
                         ### sed -ie 's/\\(\\"domain\\" => \\)\\([^,]*\\)/\\1\\"test.davinci.bz.it\\"/' var/config/system.php
                         rm -rf var/cache/*
                         chmod +x ./bin/console
                         cp -f ../website-settings.php var/config/website-settings.php
                         ./bin/console c:c -e dev
                         ./bin/console c:c -e prod"
                   '''
            }
        }
    }
}
```

Finally, you just need to create Pipelines inside Jenkins' web-frontend.

### I want to upload files to Pimcore greater than 2MB

Login to the server with `ssh` and check which upload limits are set within the
different `php.ini` files:
```sh
grep -inr upload_max_filesize /etc/php/*/fpm/php.in
```
Assume we have PHP 7.0 and 7.2 installed. Add the new limit in MB and restart
all php services:
```sh
sudo vim /etc/php/7.0/fpm/php.ini
sudo vim /etc/php/7.2/fpm/php.ini

sudo service php7.0-fpm restart
sudo service php7.2-fpm restart
```

## Jenkins Pipelines

### I want to execute arbitrary commands on the remote server

You need to use `ssh` for that. Your pipeline script looks similar to this:
```groovy
pipeline {
    agent any
    environment {
        KEY = credentials('private-key-123')
    }
    stages {
        stage('Whatever') {
            steps {
               sh 'ssh -i ${KEY} user@1.2.3.4 "touch IT_WORKS"'
            }
        }
    }
}
```
Upload the private key as secret file to Jenkins and give it the ID `private-key-123`.

Jenkins needs to add this host to its `known_hosts` file. There are two possibilities
to do so:

1) Automated via the Jenkins Job `Server Deployment/Reset Known Hosts File`. Click
`Run with parameters` and enter your IP address `1.2.3.4`.

2) Manually via ssh within your Jenkins server.
```shell
ssh admin@your-jenkins-server
sudo -iu jenkins
ssh-keyscan -H 1.2.3.4
```
If that IP address has already been used, you can clear it with `ssh-keygen -R 1.2.3.4` first.

Test it inside the Jenkins web-console and see what `Console Output` shows up. If you do not get
any ssh output for some time, check your firewall rules of the remote server.

### I want to execute git commands on the remote server

Please follow all instructions of
[I want to execute arbitrary commands on the remote server](#i-want-to-execute-arbitrary-commands-on-the-remote-server)
first.

Change your pipeline script, that is, exchange `touch IT_WORKS` with some git commands.

Connect to the remote server, and add an ssh-key for your git account.
```shell
ssh user@1.2.3.4
ssh-keygen
cat ~/.ssh/id_rsa.pub
```
Copy `id_rsa.pub` contents into your allowed [SSH keys](https://github.com/settings/keys)
section of github. Alternatively, you can also copy an existing private key, that has already
been added to your github account to `user@1.2.3.4:/.ssh/`.

Test it with
```shell
git pull
```
Make sure that `git config -l` shows a ssh protocol for `remote.origin.url`, i.e.,
`git@github.com:your_username/your_project.git`. If not, change it inside `.git/config`.

### I want to create a cron-job to clone AWS instances

I want to create a clone of an instance each night at 3am, to have a test
environment with the actual production state.

First, create a pipeline script inside `server-deployment` repository:
```shell
git clone git@github.com:noi-techpark/server-deployment.git
cat > Jenkinsfile-MyClone-Nightly-Clones << EOF
    pipeline {
        agent any
        environment {
            AWS_ACCESS_KEY_ID = credentials('aws_ec2scripts_secret_key_id')
            AWS_SECRET_ACCESS_KEY = credentials('aws_ec2scripts_secret_access_key')
            AWS_DEFAULT_OUTPUT = 'json'
            AWS_DEFAULT_REGION = 'eu-west-1'
        }
        stages {
            stage('Clone') {
                steps {
                    sh '''
                        cd utils
                        SRC_INSTANCE_ID=i-0123456789abcde0 CLONE_INSTANCE_NAME=dolly ./aws-ec2-clone
                    '''
                }
            }
        }
    }
EOF
git commit -am "Add Jenkinsfile-MyClone-Nightly-Clones"
git push
```
Create a new pipeline inside `Server Deployment` from template `Pipeline`.
Activate `Build periodically` to a schedule `H 3 * * *` (`H` is a good idea to
distribute it evenly from 3am to 4am).

Use a `Pipeline script from SCM` definition, and set
`https://github.com/noi-techpark/server-deployment.git` as repository URL.

Set `Clean after/before checkout` and add your script path to
`Jenkinsfile-MyClone-Nightly-Clones`.


## Servers

### I want to setup an SMTP server

I want to send e-mails from our own SMTP server with an address called
`info@example.com`. We use AWS/SES ([Simple Email
Service](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/Welcome.html))
for that.

1) Get your SMTP credentials from
[AWS](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/smtp-credentials.html).

2) Enable `info@example.com` inside your AWS webconsole under `Simple Email
Service/Email Addresses`

3) Configure your client as follows:

```
Server name        : email-smtp.eu-west-1.amazonaws.com
Server port        : 587
User name          : (see SMTP credentials)
Password           : (see SMTP credentials)
SMTP name          : info@example.com
Auth method        : Normal password (unencrypted) / LOGIN
Connection security: STARTTLS (or sometimes just called TLS)
```


### I want to create a test clone of a server instance

I want to clone an AWS instance with ID `i-0123456789abcde0` to a new instance
with name `dolly`.

Use `utils/aws-ec2-clone` from `server-deployment.git` which needs `aws ec2`
command-line tools. See this script's comments for further details and
configuration options.
```shell
git clone git@github.com:noi-techpark/server-deployment.git
cd utils
SRC_INSTANCE_ID=i-0123456789abcde0 CLONE_INSTANCE_NAME=dolly ./aws-ec2-clone
```
### I want to give server-access via SSH to an external contributor

On AWS open ssh ports in inbound for the IP's you want to grant access.

Access the server with ssh
```shell
ssh -i admin_key.pem admin@1.2.3.4
```
Create a user for the external contributor Chuck
```shell
sudo adduser chuck
```
Store Chuck's public ssh key in the `authorized_keys` file
```shell
sudo -iu chuck bash
mkdir .ssh
chmod 700 .ssh
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
cat chuck_id.pub >> .ssh/authorized_keys
```
Tell Chuck, that all is setup and that he should change his password as soon as possible.

In addition, if Chuck should be administrator on that server, add him to the sudoers group.
```shell
sudo usermod -aG sudo chuck
```

If no `sudo` group exists, do the following:
```shell
sudo touch /etc/sudoers.d/externals
sudo chmod +w /etc/sudoers.d/externals
echo "chuck ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/externals
sudo chmod 440 /etc/sudoers.d/externals
```

### I want to create a new Tomcat server instance on AWS for Testing

Install all dependencies:

```bash
apt-get install tomcat8 tomcat8-admin
```

Adjust the `/etc/tomcat8/server.xml` configuration and add all hosts (`<Host>...</Host>`) served by this Tomcat instance:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Server port="8005" shutdown="SHUTDOWN">
<Listener className="org.apache.catalina.startup.VersionLoggerListener" />
<Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
<Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
<Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
<Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />

<GlobalNamingResources>
    <Resource name="UserDatabase" auth="Container"
            type="org.apache.catalina.UserDatabase"
            description="User database that can be updated and saved"
            factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
            pathname="conf/tomcat-users.xml" />
</GlobalNamingResources>

<Service name="Catalina">
    <Connector port="8080" protocol="HTTP/1.1"
            connectionTimeout="20000"
            redirectPort="8443" />

    <Engine name="Catalina" defaultHost="localhost">
    <Realm className="org.apache.catalina.realm.LockOutRealm">
        <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
            resourceName="UserDatabase"/>
    </Realm>

    <Host name="bigdata4tourism.tomcat02.testingmachine.eu"  appBase="webapps/bigdata4tourism.tomcat02.testingmachine.eu"
            unpackWARs="true" autoDeploy="true">

        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
            prefix="bigdata4tourism.tomcat02.testingmachine.eu_access_log" suffix=".txt"
            pattern="%h %l %u %t &quot;%r&quot; %s %b" />

    </Host>
    </Engine>
</Service>
</Server>
```

Add a user that can upload/deploy applications using the maven deploy feature in the `/etc/tomcat8/tomcat-users.xml` file:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users xmlns="http://tomcat.apache.org/xml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd" version="1.0">
    <role rolename="admin-gui"/>
    <role rolename="manager-gui"/>
    <user name="jenkins" password="..." roles="manager-script,manager-gui" />
</tomcat-users>
```

Enable the manager for the new host that is resposible for uploading/deploying applications:

```bash
cp -rfT /etc/tomcat8/Catalina/localhost /etc/tomcat8/Catalina/bigdata4tourism.tomcat02.testingmachine.eu
```

Create a folder in the webapps folder for every host:

```bash
mkdir -p /var/lib/tomcat8/webapps/localhost
chown -R tomcat8: /var/lib/tomcat8/webapps/localhost
chmod -R 775 /var/lib/tomcat8/webapps/localhost

mkdir -p /var/lib/tomcat8/webapps/bigdata4tourism.tomcat02.testingmachine.eu
chown -R tomcat8: /var/lib/tomcat8/webapps/bigdata4tourism.tomcat02.testingmachine.eu
chmod -R 775 /var/lib/tomcat8/webapps/bigdata4tourism.tomcat02.testingmachine.eu
```

Finally, restart Tomcat:

```bash
service tomcat8 restart
```

### I want to create a new Tomcat server instance on AWS Elasticbeanstalk for Production

Create an ebextension and add all hosts (`<Host>...</Host>`) served by this Tomcat instance:

```xml
files:
  "/etc/tomcat8/server.xml":
      owner: root
      group: tomcat
      mode: "000644"
      content : |
        <?xml version="1.0" encoding="UTF-8"?>
        <Server port="8005" shutdown="SHUTDOWN">
        <Listener className="org.apache.catalina.startup.VersionLoggerListener"
        logArgs="false" logEnv="false" logProps="false" />
        <Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
        <Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
        <Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
        <Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />

        <GlobalNamingResources>
            <Resource name="UserDatabase" auth="Container"
                    type="org.apache.catalina.UserDatabase"
                    description="User database that can be updated and saved"
                    factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
                    pathname="conf/tomcat-users.xml" />
        </GlobalNamingResources>

        <Service name="Catalina">
            <Connector port="8080" protocol="HTTP/1.1"
                    URIEncoding="UTF-8"
                    connectionTimeout="20000" />
            <Engine name="Catalina" defaultHost="localhost">
                <Realm className="org.apache.catalina.realm.LockOutRealm">
                    <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
                        resourceName="UserDatabase"/>
                </Realm>

                <Host name="localhost"  appBase="webapps/ROOT/localhost"
                        unpackWARs="true" autoDeploy="true">
                        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
                        prefix="localhost_access_log" suffix=".txt" rotatable="false"
                        pattern="%h %l %u %t &quot;%r&quot; %s %b" />
                        <Valve className="org.apache.catalina.valves.RemoteIpValve" protocolHeader="X-Forwarded-Proto" internalProxies="10\.\d+\.\d+\.\d+|192\.168\.\d+\.\d+|169\.254\.\d+\.\d+|127\.\d+\.\d+\.\d+|172\.(1[6-9]|2[0-9]|3[0-1])\.\d+\.\d+" />
                </Host>

                <Host name="bigdata4tourism.tomcat02.opendatahub.bz.it"  appBase="webapps/ROOT/bigdata4tourism.tomcat02.opendatahub.bz.it"
                        unpackWARs="true" autoDeploy="true">
                        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
                        prefix="bigdata4tourism.tomcat02.opendatahub.bz.it_access_log" suffix=".txt" rotatable="false"
                        pattern="%h %l %u %t &quot;%r&quot; %s %b" />
                        <Valve className="org.apache.catalina.valves.RemoteIpValve" protocolHeader="X-Forwarded-Proto" internalProxies="10\.\d+\.\d+\.\d+|192\.168\.\d+\.\d+|169\.254\.\d+\.\d+|127\.\d+\.\d+\.\d+|172\.(1[6-9]|2[0-9]|3[0-1])\.\d+\.\d+" />
                </Host>
            </Engine>
        </Service>
        </Server>

```

Place all war file in the specified subfolders of the hosts before running `eb deploy`:

```bash
mkdir -p localhost

mkdir -p bigdata4tourism.tomcat02.opendatahub.bz.it
cp ../../ROOT.war bigdata4tourism.tomcat02.opendatahub.bz.it/
```

### I want to create a new Pimcore server instance on AWS

Get our server-deployment repository
```shell
git clone git@github.com:noi-techpark/server-deployment.git
```
Configure the `utils/aws-launch-debian-pimcore` script. All needed information can be found inside the script.
```shell
vim utils/aws-launch-debian-pimcore
```
Run it
```shell
./utils/aws-launch-debian-pimcore
```
Go to the AWS console and name the new EC2 `Instance`, `Volume`, `Elastic IP`, and `Security Group`. Use a prefix for
all of them with a pattern like `<test|prod>-pimcore-detail`
```prop
Instance = prod-pimcore-hackathon
Volume = prod-pimcore-hackathon-volume
Elastic IP = prod-pimcore-hackathon-eip
Security Group = prod-pimcore-hackathon-sg
```
Get our pimcore-automation repository
```shell
git clone git@github.com:noi-techpark/pimcore-automation.git
```
Copy `install-pimcore.sh` to your new server instance:
```shell
scp -i ~/.ssh/your-key.pem install-pimcore.sh admin@3.4.5.6:
```
Access your server and make the script executable
```shell
ssh -i ~/.ssh/your-key.pem admin@3.4.5.6
chmod +x install-pimcore.sh
```
Configure the `install-pimcore.sh` script. All needed information can be found inside the script.
```shell
vim install-pimcore.sh
```
Run it
```shell
sudo ./install-pimcore.sh
```
Test it with a browser and see if `http://3.4.5.6` shows the [Pimcore](https://pimcore.com) welcome screen.

### I want to use a swap file on my server

I have a server, which does not have enough RAM, and I do not want to upgrade it now. However, some tools
run out of memory.

Check if you have a swap file installed:
```shell
sudo swapon --summary
```
Enable a 4GB swap file:
```shell
sudo fallocate -l 4G /mnt/4GB.swap
sudo dd if=/dev/zero of=/mnt/4GB.swap bs=1024 count=4194304
sudo mkswap /mnt/4GB.swap
sudo chmod 0600 /mnt/4GB.swap
sudo swapon /mnt/4GB.swap
```
A script can be found on our [server-deployment](https://github.com/noi-techpark/server-deployment/blob/master/utils/swap-file-create)
repository.

### I want to make my web server HTTPS compliant

I have a website reachable with http://davinci.bz.it on an IP `34.247.202.9:80`,
and want to make it HTTPS only. If that domain does not exist, tell your ICT
guys to point the DNS entries for `davinci.bz.it` to `proxy.opendatahub.bz.it`,
or add a subdomain as `CNAME` to your `AWS/Route53` configuration, if you own
the domain. Use a TTL of `300` and `proxy.opendatahub.bz.it` as `VALUE`.

We use a proxy with Apache and [Let's Encrypt](https://letsencrypt.org/) for
that. Let's assume the IP of that proxy is `1.2.3.4`.
```shell
ssh admin@1.2.3.4
```

Execute the script for a new apache/certbot configuration:
```shell
/home/admin/newsite.sh davinci.bz.it 34.247.202.9:80
```

This generates the most simple configuration with https redirects. If you need
something more specific (for example, a server alias `www.davinci.bz.it`),
here are the manual steps:

Configure Apache on `1.2.3.4` with
```shell
sudo vim /etc/apache2/sites-available/it.bz.davinci.conf
```
...with...
``` xml
<VirtualHost *:80>
	<Proxy *>
		Order Allow,Deny
		Allow from all
	</Proxy>
	ServerName davinci.bz.it
	ServerAlias www.davinci.bz.it
	ProxyPass / http://34.247.202.9:80/
	ProxyPassReverse / http://34.247.202.9:80/
	ProxyPreserveHost On
	ErrorLog /var/log/apache2/it.bz.davinci
</VirtualHost>
```
Enable the new configuration
```shell
cd /etc/apache2/sites-enabled/
sudo ln -s /etc/apache2/sites-available/it.bz.davinci.conf it.bz.davinci.conf
```
Finally, get your certificates and final configuration. Execute...
```shell
sudo /opt/certbot-auto --apache

...
2: davinci.bz.it
3: www.davinci.bz.it
...
```
Type, `2,3` to select both names for your new certificate, and choose
`2: Redirect - Make all requests redirect to secure HTTPS access`.

Define your firewall, such that only the proxy `1.2.3.4` can point to port `80` of
`34.247.202.9`. On AWS refine the corresponding Security Group's inbound rule:

    Type:         HTTP
    Protocol:     TCP
    Port:         80
    Source:       1.2.3.4/32
    Description:  LETS ENCRYPT PROXY


### I want to mount an aws s3 bucket on my server

#### Prerequisit
- an aws s3 bucket with no dots in it's name
- [s3fs](https://github.com/s3fs-fuse/s3fs-fuse)
- AWS IAM user with (at least) read access to the specific bucket

#### Setup

Once everything is ready you should already be able to mount the bucket. The s3fs tool right now is not working properly when the bucket has dots in it's name.
In your home directory create a file `.passwd-s3fs` and insert your aws user credentials in this form `ACCESS_KEY_ID:SECRET_ACCESS_KEY`.

`umask` and `allow_other` are options which allow you to define permissions for other users, but can not break permissions set on the AWS IAM user.

To mount the bucket do as follows:
```
s3fs bucketname:/ /mountFolder -o passwd_file=~/.passwd-s3fs -o umask=0222 -o allow_other
```
For more specific configurations and mount options refer to the manual page and the official documentation

### I want to automate server updates

I have a new Debian server `test-tomcat-whatever` with IP `11.22.33.44`, and want to update it with a Jenkins script. We access the server via SSH with a key called `key-test-tomcat-whatever`.

Go to [Jenkins Credential management > Server Credentials](https://jenkins.testingmachine.eu/credentials/store/system/domain/server-credentials/) and add the private key as secret file, with description and ID equal to `key-test-tomcat-whatever`.

Add `11.22.33.44` as a known host to Jenkins via [Reset Known Hosts File](https://jenkins.testingmachine.eu/job/server-deployment/job/Reset%20Known%20Hosts%20File/) (for details, see [I want to execute arbitrary commands on the remote server](#i-want-to-execute-arbitrary-commands-on-the-remote-server)).

Open the Jenkins pipeline [Jenkinsfile-ServerUpdates](https://github.com/noi-techpark/server-deployment/blob/master/Jenkinsfile-ServerUpdates) on our server-deployment repository.

Add a new line inside `environment`, like:
```shell
KEYTOMCATWHATEVER = credentials('key-test-tomcat-whatever')
```

Add a new stage called `test-tomcat-whatever` (it should always be the same as in AWS) as follows:

```shell
stage('test-tomcat-whatever') {
    steps {
        ssh -i "$KEYTOMCATWHATEVER" admin@11.22.33.44 "\
            set -xeuo pipefail
            uname -a
            sudo apt-get update
            sudo apt-get -y upgrade
            sudo apt-get autoremove
            sudo service apache2 status | grep running
        "
    }
}
```

Make sure, that the command bails out as soon as possible on failure (`set -xeuo pipefail`), update the machine and perform a final check (`sudo service apache2 status | grep running`).

Commit and push your changes.

Run the pipeline inside Jenkins.

### I want to install the CloudWatch Agent on a Linux machine

1. Attach the Role "Monitoring" to the EC2 Instance. The Role should include the following Permissions:
    - CloudWatchAgentServerPolicy
2. Check your Linux Distribution: `cat /etc/*-release`
3. Download and Install the CloudWatch Agent Package depending on your Linux Distribution: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-commandline-fleet.html
    - `wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/arm64/latest/amazon-cloudwatch-agent.rpm`
    -  `rpm -U ./amazon-cloudwatch-agent.rpm` or `dpkg -i -E ./amazon-cloudwatch-agent.deb`
4. Copy the Basic Linux Monitoring Configuration from the Amazon System Manager: `amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:AmazonCloudWatch-LinuxBasic -s`
5. Check if the CloudWatch Agent Service is running: `service amazon-cloudwatch-agent status`
6. Check the Logs if everything works as expected: `/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log`

### I want to install the CloudWatch Agent on a Windows machine

1. Attach the Role "Monitoring" to the EC2 Instance. The Role should include the following Permissions:
    - CloudWatchAgentServerPolicy
2. Download and Install the CloudWatch Agent Package: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-commandline-fleet.html
    - https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/amazon-cloudwatch-agent.msi
    - `msiexec /i amazon-cloudwatch-agent.msi`
3. Copy the Basic Windows Monitoring Configuration from the Amazon System Manager:
    - `cd 'C:\Program Files\Amazon\AmazonCloudWatchAgent'`
    - `./amazon-cloudwatch-agent-ctl.ps1 -a fetch-config -m ec2 -c ssm:AmazonCloudWatch-WindowsBasic -s`
4. Check if the CloudWatch Agent Service is running in the Windows Services: AmazonCloudWatchAgent

## Documentation

### I want to add a table of contents to a markdown file

Open the markdown file, i.e., README.md, where you want to add a the table of contents and
add the following lines after the main title and initial paragraphs:

    <!-- START doctoc -->
    <!-- END doctoc -->

Use the [doctoc](https://github.com/thlorenz/doctoc) command to update the markdown file. First install that command with
```shell
sudo npm install -g doctoc
```
...then execute it
```shell
doctoc README.md --github --title '#### Table of Contents'
```
Finally publish it with
```shell
git add README.md
git commit -m "Docs: Update table of content for README.md"
git push
```
## Database

If not otherwise stated, all these chapters are about PostgreSQL.

### I run out of disk space on an AWS/RDS Postgres instance

See https://aws.amazon.com/premiumsupport/knowledge-center/diskfull-error-rds-postgresql/.

If you see a continues increase in storage, it is possible that PITR prevents
the cleaning of WAL logs. See [AWS RDS
Docs](https://aws.amazon.com/premiumsupport/knowledge-center/diskfull-error-rds-postgresql/).

To check whether PITR is activated or not, do
```sql
show archive_timeout;
```

If it is not equal `0`, you have PITR activated, and that means that Postgres
generates also WAL logs without writes. Normally, they would be cleaned after a
few MB, but with PITR they are kept forever. This is a problem, if you have
slots that are never consumed (`active=false`).

Find your slots and subscription with
```sql
SELECT * FROM pg_catalog.pg_subscription;
```

To free storage, you can also drop the underlying slot:
```sql
SELECT pg_drop_replication_slot('Your_slotname_name');
```

### I want to enable logical replication on an AWS/RDS Postgres instance

See
https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraPostgreSQL.Replication.Logical.html
and the [I run out of disk space on an AWS/RDS Postgres
instance](#i-run-out-of-disk-space-on-an-awsrds-postgres-instance) chapter.

An example application is our [Virtual Knowledge
Graph](https://github.com/noi-techpark/odh-vkg).

### I want to create a read-only user (aka role)
```sql
CREATE ROLE read_only_user WITH LOGIN PASSWORD 'your_strong_password';
GRANT CONNECT ON DATABASE your_database TO read_only_user;
GRANT USAGE ON SCHEMA your_schema TO read_only_user;
GRANT SELECT ON ALL TABLES IN SCHEMA your_schema TO read_only_user;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA your_schema TO read_only_user;
COMMENT ON ROLE read_only_user IS 'Read-only account for your_reason';
```
### I want to diff two tables with the same schema

The following SQL query gives the diff of two tables called `your-first-table` and `your-second-table`,
or an empty result if both are equal.
```sql
WITH
    table1 AS (table your-first-table),
    table2 AS (table your-second-table)
SELECT * FROM (
    (TABLE table1 EXCEPT ALL TABLE table2)
    UNION
    (TABLE table2 EXCEPT ALL TABLE table1)
) temp;
```

### I want to backup and restore specific schemas
First of all you need to be sure to have access to the database and you have postgres installed so you can use "pg_dump,pg_restore".
Try to do this on a server and not on your local machine. Use a screen session to avoid a crash/timeout after you disconnect.
`screen`

Once your in the screen session, start your backup like this:
```
pg_dump -O -Fc -n <schema name> -n <another schema name> -f <filename of dump> -h <databasehost> -U <your username> <database name>

- O ... do not save ownership of data *
- Fc ... compress data *

* check man pg_restore / man pg_dump for better doc
```
It might take just seconds or even days, depending on the amount of data. So detach from your screen session doing `CTRL+A, CTRL-D`.
Once the backup is done you can start with the restore. Connect to the server and resume your screen session:`screen -r`.
Start your restore by doing:

```
pg_restore -O --role=<role name to associate data with> -h <hostname> -Upbertolla -d <database name> <filename of dump>
- O ... do not take ownership of data if there is association
- role ... use this option to set owner of this data in the target db

```
Disconnect from screen session again and wait till restore is finished


## Open Data Hub Mobility

### I want to create links between stations

The edge is represented by the `edge` table and the start and end stations and
the edge description by three entries within the `station` table.

I have an already existing station `siemens` and a station `proma` of type
`BluetoothStation`, and want to create a link between them. The link will be
named `Siemens->Ponte Roma` and the unique identifier is called
`siemens->proma`. The type of the edge is `BluetoothStationLink`.

Execute the following code with `psql` or any other PostgreSQL aware tool:

```sql
with
a as (
	select * from station
    where stationcode = 'siemens' and stationtype = 'BluetoothStation'
)
, b as (
	select * from station
    where stationcode = 'proma' and stationtype = 'BluetoothStation'
)
, ins1 as (
	insert into station (active, available, name, stationcode, stationtype)
	select true, true, a.name || '->' || b.name, a.stationcode || '->' || b.stationcode, 'BluetoothStationLink'
    from a, b
	returning id as link_station_id
)
, ins2 as (
	insert into edge (directed, origin_id, destination_id, edge_data_id)
	select true, a.id, b.id, link_station_id from a, b, ins1
	returning id as edge_id
)
select * from ins2;
```

### I want to delete an link/edge between stations

I want to delete an edge between the two stations `siemens` and `proma`, with
name `siemens->proma` and type `BluetoothStationLink`.

```sql
delete from edge
where edge_data_id = (
    select id from station
    where stationcode = 'siemens->proma' and stationtype = 'BluetoothStationLink'
);

delete from station
where stationcode = 'siemens->proma' and stationtype = 'BluetoothStationLink';
```

NB: If you do not know the stationcode, search for it with:

```sql
select * from edge
join station org on ed.origin_id = org.id
join station dst on ed.destination_id = dst.id
join station lnk on ed.edge_data_id = lnk.id
where lnk.stationtype = 'BluetoothStationLink'
and org.stationcode = 'siemens'
and dst.stationcode = 'proma'
```

### I want to change visibility of mobility data

This chapter explains how to add users and roles, and to define which data can be seen as
open data, and what is closed.

_Please note: Only API methods regarding measurements are restricted. Methods regarding
stations and types are considered open-data due to their meta-data character, i.e.,
`get-station`, `get-station-details`, or `get-data-types` always expose all data._

#### I want to declare some records as open data

Ex.1: Declare all records related to station `station xyz` open data.
```sql
INSERT INTO bdprules(role_id, station_id, type_id, period)
SELECT r.id, s.id, null, null
FROM bdprole r, station s
WHERE r.name = 'GUEST' AND stationcode = 'station xyz';
```
Ex.2: Make atmospheric pressure measurements of all meteorological stations open-data.
```sql
INSERT INTO bdprules(role_id, station_id, type_id, period)
SELECT r.id, s.id, t.id, null
FROM bdprole r, station s, type t
WHERE r.name = 'GUEST' AND stationtype = 'Meteostation' AND cname = 'atmospheric-pressure';
```
> NB: `GUEST` contains all open-data sources, just add rules for that role and you
> will open it without the need of authentication through tokens, or username/password.

Finally, refresh the materialized view to reflect the new changes:
```sql
REFRESH MATERIALIZED VIEW bdppermissions;
```
#### I want to add or disable a new user to be used in V1

```sql
INSERT INTO bdpuser(email, password)
VALUES ('this_is_my@ema.il', crypt('top-S3CR3T', gen_salt('bf')));
```

To disable the user, do
```sql
UPDATE bdpuser SET enabled = false WHERE email = 'this_is_my@ema.il';
```

#### I want to add a new user to be used in V2

Add a new user to the OAuth server. Go to
[Keycloak/noi/users](https://auth.opendatahub.bz.it/auth/admin/noi/console/#/realms/noi/users)
and add a new user. Then, under `Role Mappings` click on `Client Roles` and
choose `odh-mobility-v2`. Select available roles and assign them.

#### I want to retrieve closed data in V2

See [I want to get an access token from our OAuth 2.0 Keycloak
Server](#i-want-to-get-an-access-token-from-our-oauth-20-keycloak-server) and
use `client_id=odh-mobility-v2` to get an access token.

Use that access token then with the API:

```sh
curl -X GET 'https://mobility.api.opendatahub.bz.it/v2/api/flat/VMS/*?select=sname,mvalue' \
    -H 'content-type: application/json' \
    -H 'Authorization: bearer your-access-token'
```

#### I want to add a new role
```sql
INSERT INTO bdprole(name) VALUES ('Role A');
INSERT INTO bdprole(name, parent_id)
VALUES ('Role B', (select id from bdprole where name = 'GUEST'));
```
> Make sure that you define at least parent as `GUEST` (which is always present
> and allows access to all open data sources); `ADMIN` is another default, but it
> sees all data.
>> `Role A` cannot see anything at the moment, whereas `Role B` inherits everything
>> from `GUEST`.

Finally, refresh the materialized view to reflect the new changes:
```sql
REFRESH MATERIALIZED VIEW bdppermissions;
```

In V2 you need also to add the same role prefixed with `BDP_` to Keycloak roles.
Go to
[keycloak/noi/clients](https://auth.opendatahub.bz.it/auth/admin/noi/console/#/realms/noi/clients)
and then to "Roles > Add Role". If the role is called `MUNICIPALITY` inside the
table `bdprole`, then it must be called `BDP_MUNICIPALITY` inside Keycloak.

#### I want to combine a role with users

In V1 you must do this through SQL, as follows:
```sql
INSERT INTO bdpusers_bdproles(user_id, role_id) VALUES (
    (SELECT id FROM bdpuser WHERE email = 'this_is_my@ema.il'),
    (SELECT id FROM bdprole WHERE name = 'Role A')
);
```
...or, if you know primary keys...
```sql
INSERT INTO bdpusers_bdproles(user_id, role_id) VALUES (2, 3);
```

In V2 the SQL step is not necessary, because the mapping gets done in Keycloak. Go to
[Keycloak/noi/users](https://auth.opendatahub.bz.it/auth/admin/noi/console/#/realms/noi/users)
and choose an existing user. Then, under `Role Mappings` click on `Client Roles`
and choose `odh-mobility-v2`. Select available roles and assign them.

#### I want to define filter rules for a certain role
```sql
INSERT INTO bdprules(role_id, station_id, type_id, period)
SELECT r.id, s.id, null, null
FROM bdprole r, station s
WHERE r.name = 'Role A' AND stationcode = 'station xyz';
```
> This means, `Role A` can see any `(type,period)` combination for `station xyz`.

Finally, refresh the materialized view to reflect the new changes:
```psql
REFRESH MATERIALIZED VIEW bdppermissions;
```
Rule information:
- If you define new filter rules for parents, all children automatically inherit them.
- `(station, type, period)` is a hierarchical triple, that is, if you open `station`
to all (`= NULL`), `type` and `period` are no longer considered.

#### I want to debug my rules
```sql
SELECT * FROM bdppermissions;
```
> This query, shows you the permissions view, which is a flattened representation of
> all rules.

*How to interpret the output?*
This table consists of five columns `(uuid, role_id, station_id, type_id, period)`. It is a minimal set of rules,
this means, that there are no overlapping rules. The `uuid` column is a primary key, not important for debugging. The
rest defines the rule itself, for example, `(1,null,null,null)` means that a role with id `1` can see everything. A cell
set to `null` stands for *no restriction*. Another example could be `(2,5,null,null)`, which means that role with id `2`
sees all types and periods of station `5`. However, since `(station, type, period)` is a hierarchical triple (read from
left-to-right), something like `(3,null,null,1)` is considered a erroneous permission rule.

## Maven

### I want to run maven without tests
If you run your tests already in a former stage, you can skip tests as follows:
```sh
mvn -Dmaven.test.skip=true ...
```

### I want to run maven in a non-interactive mode without output colors
This is useful for scripting.
```sh
mvn -B ...
```

### I want to force maven to always update dependencies
This is useful for scripting.
```sh
mvn -U ...
```

### I want to use maven to deploy on a tomcat server
We have a tomcat server with a running tomcat manager and credentials in our environment:
```sh
TESTSERVER_TOMCAT_ENDPOINT = "http://pagebuilder.tomcat02.testingmachine.eu:8080/manager/text"
TESTSERVER_TOMCAT_CREDENTIALS = "testserver-tomcat8-credentials-s3cr3t"
```

Configure access credentials for your tomcat server inside the `~/.m2/settings.xml`.
For instance, as follows:
```sh
sed -i -e "s/<\\/settings>$//g\" ~/.m2/settings.xml
echo "    <servers>" >> ~/.m2/settings.xml
echo "        ${TESTSERVER_TOMCAT_CREDENTIALS}" >> ~/.m2/settings.xml
echo "    </servers>" >> ~/.m2/settings.xml
echo "</settings>" >> ~/.m2/settings.xml
```

Then run:
```sh
mvn -B -U tomcat:redeploy -Dmaven.tomcat.url=${TESTSERVER_TOMCAT_ENDPOINT} -Dmaven.tomcat.server=testServer -Dmaven.tomcat.path=/
```

### ODH Maven repository
#### I want to use an open source java library of the OpenDataHub
Add the opendatahub repository to your pom.xml file
```xml
<repositories>
	<repository>
		<id>maven-repo.opendatahub.bz.it</id>
		<url>http://it.bz.opendatahub.s3-website-eu-west-1.amazonaws.com/release</url>
	</repository>
</repositories>
```
and add the library you need as dependency eg.:
``` xml
<dependency>
	<groupId>it.bz.idm.bdp</groupId>
	<artifactId>dto</artifactId>
	<version>1.3.0</version>
</dependency>
```

#### I want to upload an artifact to the odh maven repository

Add distribution management to your pom.xml:
```xml
<distributionManagement>
  <snapshotRepository>
     <id>maven-repo.opendatahub.bz.it</id>
     <url>s3://it.bz.opendatahub/snapshot</url>
  </snapshotRepository>
  <repository>
     <id>maven-repo.opendatahub.bz.it</id>
     <url>s3://it.bz.opendatahub/release</url>
  </repository>
</distributionManagement>
```
Add a wagon which handles the transfer and deployment to the s3 bucket
``` xml
<extensions>
  <extension>
      <groupId>org.springframework.build</groupId>
      <artifactId>aws-maven</artifactId>
      <version>5.0.0.RELEASE</version>
  </extension>
</extensions>
```
Configure your maven repository to handle authentication towards s3 bucket. Go to settings.xml and configure a server like this:
``` xml
<server>
 <id>maven-repo.opendatahub.bz.it</id>
 <username>${aws_access_key_id}</username>
 <password>${aws_secret_access_key}</password>
</server>
```
Deploy your library through maven: `mvn deploy`


## App Development

### Android

#### I want to add a new tester to an App on Google Play

I want to add `pinky@example.com` to our new `Beacon App` alpha tester crowd.
We assume, that the alpha release has already been made.

- Login to `https://play.google.com/apps/publish`
- Choose `Beacon App`
- Go to Release Management > App releases
- Click on *MANAGE* within the "Closed Tracks Alpha" block
- Add `pinky@example.com` to an existing list or create a new list
- Activate that list and save it
- Send an email to your testers (if not already done automatically) with the opt-in URL

### iOS

#### I want to renew the development and distribution certificates

1. Go to the repository where the certificates are stored
2. Delete certificates (ex. the development profile)
    - `rm certs/development/*.cer`
    - `rm certs/development/*.p12`
    - `rm profiles/development/*.mobileprovision`
3. Optionally open Apple Developer and delete the certificates and profiles
    - https://developer.apple.com/account/resources/profiles/list
    - https://developer.apple.com/account/resources/certificates/list
4. Go to the repository of the iOS app
5. Create a new certificate
    - `fastlane match development --username p.bertolla@noi.bz.it`
    - `fastlane match appstore --username p.bertolla@noi.bz.it`
6. Adjust the fastlane settings of the project
    - Configure the new profile name `profile_name` in the `Fastfile`
7. Deploy new version
    - If the build fails, go to the node and run `security set-key-partition-list -S apple-tool:,apple: -s ~/Library/Keychains/login.keychain-db`

If you have any issues, check these links out:
    - https://samwize.com/2019/05/02/how-to-renew-cert-for-fastlane-match/
    - https://github.com/fastlane/fastlane/issues/10589

The step 7 is currently a workaround. It could be that this step can be avoided in the future with a new version of fastlane.
