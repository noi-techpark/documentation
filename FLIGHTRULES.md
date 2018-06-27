# Flight rules for ODH

#### What are "flight rules"?

A [guide for astronauts](https://www.jsc.nasa.gov/news/columbia/fr_generic.pdf) (now, programmers contributing to the Open Data Hub) about what to do when things go wrong. 

>  *Flight Rules* are the hard-earned body of knowledge recorded in manuals that list, step-by-step, what to do if X occurs, and why. Essentially, they are extremely detailed, scenario-specific standard operating procedures. [...]

> NASA has been capturing our missteps, disasters and solutions since the early 1960s, when Mercury-era ground teams first started gathering "lessons learned" into a compendium that now lists thousands of problematic situations, from engine failure to busted hatch handles to computer glitches, and their solutions.

&mdash; Chris Hadfield, *An Astronaut's Guide to Life*.

ps. _Idea taken from the [GIT flight rules](https://github.com/k88hudson/git-flight-rules) project._

## Servers

### I want to give server-access via SSH to an external contributor

On AWS open ssh ports in inbound for the IP's you want to grant access.

Access the server with ssh

    ssh -i key.pem admin@1.2.3.4 

Create a user for the external contributor

    sudo adduser chuck
    
Store Chuck's public ssh key in the authorized_keys file

    sudo -u chuck bash
    mkdir .ssh
    chmod 700 .ssh
    touch .ssh/authorized_keys
    chmod 600 .ssh/authorized_keys
    cat chuck_id.pub >> .ssh/authorized_keys
    
Tell Chuck, that all is setup and that he should change his password as soon as possible.
    
