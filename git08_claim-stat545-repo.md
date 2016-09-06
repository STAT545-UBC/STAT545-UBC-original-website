---
title: "Claim your private STAT 545 repository"
output:
  html_document:
    toc: yes
    toc_depth: 4
---

### Prerequisites

We assume the following: 

  * You've already installed Git and (possibly) a Git client.
  * You've already registered a free GitHub account.
  * You've already introduced yourself to Git.
  * You've confirmed that you can push to / pull from GitHub from the command line.
  * You've already installed R and RStudio.
  * You've proven that you can push to / pull from GitHub from RStudio.
  * You are no longer being challenged for your GitHub username and password because your credentials have been cached or you've set up SSH keys.
  
Instructions for all of this are here:

<http://happygitwithr.com>

### Outline

This will be brief. You've done all of this before, in the set-up and test drives above.

Accept my invitation to join the STAT 545 Organization. Check your email.

Note that I have added you to a private repository that belongs only to you. Other students can *see* this repo, but they cannot edit it. The rest of the world cannot even see it. The TAs and I can see and can write to it, but we probably won't.

Go to that repository in the browser.

Copy the HTTPS URL. It will be something like this:

``` shell
https://github.com/STAT545-UBC/jennifer_bryan
```

In RStudio, start a new Project:

  * *File > New Project > Version Control > Git*. In the "repository URL" paste the URL of your new GitHub repository.
  * Take charge of -- or at least notice! -- the local directory for the Project. This will be the main folder for your coursework. This will create a new sub-directory, which will be all of these things:
    - a directory on your computer
    - a Git repository, linked to a remote GitHub repository
    - an RStudio Project
  * Create the Project ... you should get a pre-existing skeleton `README.md` that I created for you.

Make some local changes, e.g. edit or add files.

Commit these changes to your local repo.

Pull from GitHub (I'm just trying to help you establish this habit).

Push to GitHub.

Repeat *ad nauseum* as you do your coursework.
