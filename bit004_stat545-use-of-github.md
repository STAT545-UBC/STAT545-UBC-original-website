# Use of GitHub in STAT545

*Mostly just notes for myself! Unconference talk at [#rrhack](https://github.com/Reproducible-Science-Curriculum/Reproducible-Science-Hackathon-Dec-08-2014)*

Back story

  * 2013 no explicit usage of GitHub, yet vast majority of students elected to use for final project submission
    - What submission requirements induced this behavior?
    - no email attachments -- email me a link to location on the web
    - I will not click on each file to download -- must come in one bundle
    - course materials were on GitHub so they had been exposed
  * 2014 Jan - Apr used GitHub in another course (STAT 540 Stats for genomics)
    - students got educational GitHub accounts = 5 private repos
    - one public and one private repo per student
    - private repo used for homework submission and feedback
    - PAIN POINTS:
    - prof and TA made explicit collaborators on EACH private repo, by the student
    - students needed to submit link to their repo to prof
    - students cannot see each others work
    - internal matters handled in a private repo owned by me, with TAs added as collaborators
    - not easy to see all of these course-related repos as a collection

STAT 545 in 2014

  * [Explicit coverage of Git and GitHub](http://stat545-ubc.github.io/git00_index.html) in the course
  * [GitHub Organization](https://help.github.com/categories/organizations/) Gold Account provided *gratis* by GitHub via their [Education initiative](https://education.github.com)
  * ~50 private repos for free
    - one per student (team)
    - one for internal development by prof and TAs
  * main course website is an [Organization page](https://help.github.com/articles/user-organization-and-project-pages/)
    - https://github.com/STAT545-UBC/STAT545-UBC.github.io
    - http://stat545-ubc.github.io
    - inspired by back end of [rmarkdown.rstudio.com](http://rmarkdown.rstudio.com) -- see it in the [gh-pages branch of rmarkdown repo](https://github.com/rstudio/rmarkdown/tree/gh-pages) and [behold their Makefile](https://github.com/rstudio/rmarkdown/blob/gh-pages/Makefile)
  * [Discussion repository's issues](https://github.com/STAT545-UBC/Discussion/issues) used as a class forum
  * Organization Teams give control over who can read, write, administer what
    - [chart](https://help.github.com/articles/permission-levels-for-an-organization-repository/) of repository access by team role
    - prof + TAs on Owners team
    - each student must be a singleton team :( (invisible to outside world)
    - all students belong to Students team (invisible to outside world)
  * Teams and repos and permissions
    - Important: You cannot give an individual permission to do anything. Only a Team.
    - Each student is a team with one member. It is a "Write access" team on the student's repository
    - The Students team is a "Read access" team on all student repositories. 
    - The Owners team is omnipotent.
    - Tagging happy: `@STAT545-UBC/owners` works as a tag
    - Tagging sad: frustrated in our attempts to create a `@STAT545-UBC/markers` team -- you can only @mention the Owners team, individual GitHub users or a team you are a member of
  * Homework submission
    - student does work in her/his repo
    - opens an issue titled "Mark homework 11 of jenny_bryan"
    - puts SHA of relevant commit and tags `@STAT545-UBC/owners` in comment
    - marker puts comment in the issue, comments on commits, sends a pull request
    - marker closes issue when done
  * Peer review
    - each assignment reviewed by two peers
    - issue titled "Peer review of jenny_bryan's hwYY by karl_broman"
    - issue on jenny's repo, formally assigned to karl
    - karl puts comments in the issue
    - karl indicates he is done but sadly cannot close the issue :( jenny or Owners must do that
  * Programmatic interaction with GitHub is a MUST
    - started out using [`teachers_pet`](https://github.com/education/teachers_pet)
    - created student teams, added students to singleton teams and the Students team
    - results were mixed, e.g. inflexibility of naming scheme, docs were uneven
    - regret over repo names :( `zz_` prefix did not have desired effect, delimiter chaos
    - added me to each repo for no reason?
    - supports a *very specific* [workflow](https://education.github.com/guide), e.g. one repository per student per assignment, seeded with boilerplate content
    - switched quickly to [`github`](https://github.com/cscheid/rgithub), an R wrapper around [GitHub v3 API](http://developer.github.com/v3/)
    - once I figured out [non-interactive authentication](http://stat545-ubc.github.io/bit003_api-key-env-var.html), mostly success
    - excellent for creating ~100 issues each week
    - epic fail at adding new teams and repos mid-term; luckily volume small enough to do manually
    - fail not due to capability but lack of examples and, I think?, inconsistency about JSON-ification of inputs, i.e. whether user or wrapper function converts
    - documentation really doesn't exist, no vignette
  * Fake GitHub account and dummy repos and teams are a MUST
    - luckily I could create an account as my husband and hijack as needed
    - very hard to do "dry run" before you unleash your issue-creating script
    - Apparently someone's GitHub handle is [`NA`](https://github.com/na). Ask me how I know. Sorry about the issues, Nate Anderson!
  * Other
    - [Peer review Shiny app](http://shinyapps.stat.ubc.ca/STAT545/peer-review/)
    - any time spent configuring Git(Hub) and learning about usage patterns struck me as a valid pedagogical goal -- so did not worry about the time spent on this
    - like Mine, harvesting the GitHub usernames is semi-painful; repo names however were within my control and I created them from official class registration list
    
