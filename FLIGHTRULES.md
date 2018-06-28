# Flight rules for ODH

#### What are "flight rules"?

A [guide for astronauts](https://www.jsc.nasa.gov/news/columbia/fr_generic.pdf) (now, programmers contributing to the Open Data Hub) about what to do when things go wrong. 

>  *Flight Rules* are the hard-earned body of knowledge recorded in manuals that list, step-by-step, what to do if X occurs, and why. Essentially, they are extremely detailed, scenario-specific standard operating procedures. [...]

> NASA has been capturing our missteps, disasters and solutions since the early 1960s, when Mercury-era ground teams first started gathering "lessons learned" into a compendium that now lists thousands of problematic situations, from engine failure to busted hatch handles to computer glitches, and their solutions.

&mdash; Chris Hadfield, *An Astronaut's Guide to Life*.

_ps. Idea taken from the [GIT flight rules](https://github.com/k88hudson/git-flight-rules) project._

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Table of Contents

- [Servers](#servers)
  - [I want to give server-access via SSH to an external contributor](#i-want-to-give-server-access-via-ssh-to-an-external-contributor)
- [Documentation](#documentation)
  - [I want to add a table of contents to a markdown file](#i-want-to-add-a-table-of-contents-to-a-markdown-file)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

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


## Documentation

### I want to add a table of contents to a markdown file

Open the markdown file, i.e., README.md, where you want to add a the table of contents and 
add the following lines after the main title and initial paragraphs:

    <!-- START doctoc -->
    <!-- END doctoc -->

Use the doctoc command to update the markdown file. First install that command with

    sudo npm install -g doctoc

...then execute it

    doctoc README.md --github --title '## Table of Contents'

Finally publish it with

    git add README.md
    git commit -m "Docs: Update table of content for README.md"
    git push

