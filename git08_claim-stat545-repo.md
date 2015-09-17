---
title: "Claim your private STAT 545 repository"
output:
  html_document:
    toc: yes
    toc_depth: 4
---

### Prerequisites

We assume the following: 

  * You've already [installed Git](git01_git-install.html) and (possibly) [a Git client](git02_git-clients.html).
  * You've already [registered a free GitHub account](cm001_course-intro-sw-install-account-signup.html#register-a-github-account).
  * You've already [introduced yourself to Git](git04_introduce-self-to-git.html)
  * You've confirmed that you can [push to / pull from GitHub from the command line](git05_github-connection.html)
  * You've already [installed R and RStudio](block000_r-rstudio-install.html).
  * You've proven that you can [push to / pull from GitHub from RStudio](git07_git-github-rstudio.html).
  * You are no longer being challenged for your GitHub username and password because [your credentials have been cached](git06_credential-caching.html).

### Outline

This will be brief. You've done all of this before, in the set-up and test drives above.

Accept my invitation to join the STAT 545 Organization. Check your email.

Note that I have added you to a private repository that belongs only to you. Other students can *see* this repo, but they cannot edit it. The rest of the world cannot even see it. The TAs and I can see and can write to it, but we probably won't.

Go to that repository in the browser.

Copy the HTTPS URL. It will be something like this:

```
https://github.com/STAT545-UBC/zz_jennifer_bryan-coursework
```

In RStudio, start a new Project:

  * *File > New Project > Version Control > Git*. In the "repository URL" paste the URL of your new GitHub repository.
  * Take charge of -- or at least notice! -- the local directory for the Project. This will be the main folder for your coursework. This will create a new sub-directory, which will be all of these things:
    - a directory on your computer
    - a Git repository, linked to a remote GitHub repository
    - an RStudio Project
  * Create the Project ... you should get a pre-existing skeleton `README.md` that I created for you.

Make a local edit, e.g. edit files, add files.

Commit these changes to your local repo.

Pull from GitHub (I'm just trying to help you establish this habit).

Push to GitHub.

Repeat *ad nauseum* as you do your coursework.