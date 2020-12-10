<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Project Management](#project-management)
  - [Code](#code)
    - [1) Infrastructure folder](#1-infrastructure-folder)
      - [1.1) Create a sub-folder for each technique:](#11-create-a-sub-folder-for-each-technique)
      - [1.2) Docker files](#12-docker-files)
      - [1.3) Jenkinsfiles](#13-jenkinsfiles)
      - [1.4) Utilities to manage the project](#14-utilities-to-manage-the-project)
      - [1.5) Infrastructure description](#15-infrastructure-description)
  - [Github](#github)
  - [Google Docs Projects folder](#google-docs-projects-folder)
  - [README.md in each repo](#readmemd-in-each-repo)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Project Management

- Version: `1.0`
- Usage  : see [Checklist](https://docs.google.com/spreadsheets/d/1txvRdrpv2bjt1HsDjCAh-7s3V2iT7QCqVxbxFr59JRA) on Google Docs

## Code

### 1) Infrastructure folder

All files should be lowercase and have a file-extension, for better IDE
integration and syntax highlighting.

#### 1.1) Create a sub-folder for each technique:
```sh
mkdir -p infrastructure/ansible
mkdir -p infrastructure/docker
mkdir -p infrastructure/jenkins
```
docker-compose.yml files
#### 1.2) Docker files
Create dockerfiles lowercase and prefix them with the technique or language you
want to use. For example, `java.dockerfile`, `proxy.dockerfile` or
`postgres.dockerfile`.

Put `docker-compose.<type>.yml` files into `infrastructure`, if they belong to
the NOI infrastructure, and keep the local development `docker-compose.yml` in
the root folder of the project, such that, we can immediately start developing
after the check-out of the project. `<type>` is the current stage that applies
to that docker-compose file, for instance, `docker-compose.build.yml`.

#### 1.3) Jenkinsfiles
- must have a `.groovy` extension. Name as follows:
- Continuous integration: `ci.groovy`
- Continuous deployment: `test.groovy` and `prod.groovy`

#### 1.4) Utilities to manage the project
```sh
mkdir -p infrastructure/utils
```
Put them into `utils`. In general try to create CLI tools for projects, that can
then also be used for deployment or testing. Keep it simple and minimal thou.
However, these utilities could also just be some SQL scripts, curl commands or a
collection of copy/paste lines in a README file. Whatever helps to manage the
project.

#### 1.5) Infrastructure description
Create a README.md inside `infrastructure`, that describes the setup at NOI.

## Github
  - Kanban
    - Name: Name of Developer(s)
    - Set developer permissions to "Write"
    - Make it private
    - Link repositories
    - Columns:
      - Backlog (automation: todo with "Move issues/pull requests" here when "Newly added" or "Reopened")
      - Estimate effort (automation: todo)
      - To do (automation: todo)
      - In progress (automation: in progress)
      - To review (automation: in progress)
      - Done (automation: done)
  - Repositories
    - Assigned repositories with right permissions for contributors
    - Check for templates while you create new repos (we call them boilerplate repositories)
    - Issues
      - Milestones for complex projects with deadlines
      - Put all issues and pull requests automatically into the Kanban's backlog
    - Create new repositories
      - If single-repo project call it like the endpoint in reverse (example, it.bz.opendatahub.api.mobility)
      - If multi-repo project
        - Create a main repository (example, it.bz.opendatahub.webcomponents)
          - In the example, this is the store API, crawler and other things, but
            also the main entrypoint to the whole project so we need a good
            README there with links to all sub-repos and to the google docs
            project folder
        - Create sub-repos (example, it.bz.opendatahub.webcomponents.webcomp.routeplanner)
          - README should point back to the main repo

## Google Docs Projects folder
  - descriptions for each meeting / general document for milestones (maybe a single document for all meetings)
  - Audience: TTDigital / External contributors eventually
  - Links from the Kanban to Google Docs and vice-versa
  - Name should be the same as the main repo (endpoint in reverse)

## README.md in each repo
(depends on the project type, see boilerplates)
  - All repos:
    - Title = Name of Repository
    - Abstract
    - link to main-repo or sub-repos
    - link to google docs
    - link to ttdigital manager / main developer
    - project documentation, that describes how to setup the project locally for development
    - link to the license
    - link to contributors
    - contact
  - Main repo:
    - entrypoint for developers (external contributors)
  - Sub repos:
    - ...
  - Each infrastructure folder/README.md
    - infrastructure documentation, that describes the setup at NOI