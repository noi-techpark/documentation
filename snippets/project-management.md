# Project Management

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