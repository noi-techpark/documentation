# Flight rules for ODH

#### What are "flight rules"?

A [guide for astronauts](https://www.jsc.nasa.gov/news/columbia/fr_generic.pdf) (now, programmers contributing to the Open Data Hub) about what to do when things go wrong, _or must be executed with no delay_.

> *Flight Rules* are the hard-earned body of knowledge recorded in manuals that list, step-by-step, what to do if X
> occurs, and why. Essentially, they are extremely detailed, scenario-specific standard operating procedures. [...]

> NASA has been capturing our missteps, disasters and solutions since the early 1960s, when Mercury-era ground teams
> first started gathering "lessons learned" into a compendium that now lists thousands of problematic situations, from
> engine failure to busted hatch handles to computer glitches, and their solutions.

&mdash; Chris Hadfield, *An Astronaut's Guide to Life*.

_ps. Idea taken from the [GIT flight rules](https://github.com/k88hudson/git-flight-rules) project._

#### Table of Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Servers](#servers)
  - [I want to give server-access via SSH to an external contributor](#i-want-to-give-server-access-via-ssh-to-an-external-contributor)
  - [I want to create a new Pimcore server instance on AWS](#i-want-to-create-a-new-pimcore-server-instance-on-aws)
- [Documentation](#documentation)
  - [I want to add a table of contents to a markdown file](#i-want-to-add-a-table-of-contents-to-a-markdown-file)
- [Database](#database)
  - [I want to change visibility of mobility data](#i-want-to-change-visibility-of-mobility-data)
    - [I want to declare some records as open data](#i-want-to-declare-some-records-as-open-data)
    - [I want to add a new user](#i-want-to-add-a-new-user)
    - [I want to disable an existing user](#i-want-to-disable-an-existing-user)
    - [I want to add a new role](#i-want-to-add-a-new-role)
    - [I want to combine a role with users](#i-want-to-combine-a-role-with-users)
    - [I want to define filter rules for a certain role](#i-want-to-define-filter-rules-for-a-certain-role)
    - [I want to debug my rules](#i-want-to-debug-my-rules)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

***

## Servers

### I want to give server-access via SSH to an external contributor

On AWS open ssh ports in inbound for the IP's you want to grant access.

Access the server with ssh

    ssh -i admin_key.pem admin@1.2.3.4

Create a user for the external contributor Chuck

    sudo adduser chuck

Store Chuck's public ssh key in the `authorized_keys` file

    sudo -u chuck bash
    mkdir .ssh
    chmod 700 .ssh
    touch .ssh/authorized_keys
    chmod 600 .ssh/authorized_keys
    cat chuck_id.pub >> .ssh/authorized_keys

Tell Chuck, that all is setup and that he should change his password as soon as possible.

In addition, if Chuck should be administrator on that server, add him to the sudoers group.

    sudo usermod -aG sudo chuck


### I want to create a new Pimcore server instance on AWS

Get our server-deployment repository

    git clone git@github.com:idm-suedtirol/server-deployment.git

Configure the `utils/aws-launch-debian-pimcore` script. All needed information can be found inside the script.

    vim utils/aws-launch-debian-pimcore

Run it

    ./utils/aws-launch-debian-pimcore

Go to the AWS console and name the new EC2 `Instance`, `Volume`, `Elastic IP`, and `Security Group`. Use a prefix for
all of them with a pattern like `<test|prod>-pimcore-detail`

    Instance = prod-pimcore-hackathon
    Volume = prod-pimcore-hackathon-volume
    Elastic IP = prod-pimcore-hackathon-eip
    Security Group = prod-pimcore-hackathon-sg

Get our pimcore-automation repository

    git clone git@github.com:idm-suedtirol/pimcore-automation.git

Copy `install-pimcore.sh` to your new server instance:

    scp -i ~/.ssh/your-key.pem install-pimcore.sh admin@3.4.5.6:

Access your server and execute the script

    ssh -i ~/.ssh/your-key.pem admin@3.4.5.6
    chmod +x install-pimcore.sh

Configure the `install-pimcore.sh` script. All needed information can be found inside the script.

    vim install-pimcore.sh

Run it

    sudo ./install-pimcore.sh

Test it with a browser and see if http://3.4.5.6 shows the [Pimcore](https://pimcore.com) welcome screen.


## Documentation

### I want to add a table of contents to a markdown file

Open the markdown file, i.e., README.md, where you want to add a the table of contents and
add the following lines after the main title and initial paragraphs:

    <!-- START doctoc -->
    <!-- END doctoc -->

Use the [doctoc](https://github.com/thlorenz/doctoc) command to update the markdown file. First install that command with

    sudo npm install -g doctoc

...then execute it

    doctoc README.md --github --title '#### Table of Contents'

Finally publish it with

    git add README.md
    git commit -m "Docs: Update table of content for README.md"
    git push

## Database

### I want to change visibility of mobility data

This chapter explains how to add users and roles, and to define which data can be seen as
open data, and what is closed.

_Please note: Only API methods regarding measurements are restricted. Methods regarding
stations and types are considered open-data due to their meta-data character, i.e.,
`get-station`, `get-station-details`, or `get-data-types` always expose all data._

#### I want to declare some records as open data

Ex.1: Declare all records related to station `station xyz` open data.

    INSERT INTO bdprules(role_id, station_id, type_id, period)
        SELECT r.id, s.id, null, null FROM bdprole r, station s
            WHERE r.name = 'GUEST' AND stationcode = 'station xyz';

Ex.2: Make atmospheric pressure measurements of all meteorological stations open-data.

    INSERT INTO bdprules(role_id, station_id, type_id, period)
        SELECT r.id, s.id, t.id, null FROM bdprole r, station s, type t
            WHERE r.name = 'GUEST' AND stationtype = 'Meteostation' AND cname = 'atmospheric-pressure';


> NB: `GUEST` contains all open-data sources, just add rules for that role and you
> will open it without the need of authentication through tokens, or username/password.

#### I want to add a new user

    INSERT INTO bdpuser(email, password) VALUES ('this_is_my@ema.il', 'top-S3CR3T');

#### I want to disable an existing user

    UPDATE bdpuser SET enabled = false WHERE email = 'this_is_my@ema.il';

#### I want to add a new role

    INSERT INTO bdprole(name) VALUES ('Role A');
    INSERT INTO bdprole(name, parent_id)
        VALUES ('Role B', (select id from bdprole where name = 'GUEST'));

> Make sure that you define at least parent as `GUEST` (which is always present
> and allows access to all open data sources); `ADMIN` is another default, but it
> sees all data.
>> `Role A` cannot see anything at the moment, whereas `Role B` inherits everything
>> from `GUEST`.

#### I want to combine a role with users

    INSERT INTO bdpusers_bdproles(user_id, role_id) VALUES (
        (SELECT id FROM bdpuser WHERE email = 'this_is_my@ema.il'),
        (SELECT id FROM bdprole WHERE name = 'Role A')
    );

...or, if you know primary keys...

    INSERT INTO bdpusers_bdproles(user_id, role_id) VALUES (2, 3);

#### I want to define filter rules for a certain role

    INSERT INTO bdprules(role_id, station_id, type_id, period)
        SELECT r.id, s.id, null, null FROM bdprole r, station s
            WHERE r.name = 'Role A' AND stationcode = 'station xyz';

> This means, `Role A` can see any `(type,period)` combination for `station xyz`.

Rule information:
- If you define new filter rules for parents, all children automatically inherit them.
- `(station, type, period)` is a hierarchical triple, that is, if you open `station`
to all (`= NULL`), `type` and `period` are no longer considered.

#### I want to debug my rules

    SELECT * FROM bdppermissions;

> This query, shows you the permissions view, which is a flattened representation of
> all rules.
