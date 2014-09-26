---
title: Automatic GitHub authentication
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

You need to get Git to remember your GitHub username and password, so that every time you, e.g., push, you do NOT have to authenticate yourself interactively.

**You only have to set this up once every couple of months or once per computer.**

You will know you have truly succeeded once you have at least one successful push to GitHub in which you are NOT challenged for your user name and password.

### Get yourself a test repository

Below you will need a functioning test Git repository. One that exists locally and remotely on GitHub, with the local repo tracking the remote.

If you have just completed a [test drive of RStudio and Github](http://stat545-ubc.github.io/git05_first-use-git-rstudio.html), the `helloGithub` repo will do just fine. If have not and you don't know how to create such a testbed for yourself, go [take the test drive](http://stat545-ubc.github.io/git05_first-use-git-rstudio.html) and come back.

You are ready to proceed when

  * You have a test repo.
  * You know where it lives on your local computer. Example:
    - `/home/jenny/tmp/helloGithub`
  * You know where it lives on GitHub. Example:
    - `https://github.com/jennybc/helloGithub`
  * You know local is tracking remote. In a shell with working directory set to the local Git repo, enter `git remote -v`. You want to see the URL for the GitHub repo (it will probably have `.git` added to the end).

### Verify that your Git is new enough to have a credential helper

In a shell, enter `git --version` and verify that you have 1.7.10 or newer. If you don't, [update Git](git01_git-install.html).
  
### Turn on the credential helper

#### Windows

In the shell, enter `git config --global credential.helper wincred`

#### Windows, plan B

If that doesn't seem to work, install an external credential helper.

  * Download the [git-credential-winstore.exe](http://gitcredentialstore.codeplex.com/) application.
  
  * Run it! It should work if Git is in your `PATH` environment variable. If not, go to the directory where you downloaded the application and run the following:
  `git-credential-winstore -i "C:\Program Files (x86)\Git\bin\git.exe"`

#### Mac

Find out if the credential helper is already installed. In the shell, enter `git credential-osxkeychain`. You should see something like this: `Usage: git credential-osxkeychain <get|store|erase>`. If you do **not**, follow steps 2 and 3 on [the github help](https://help.github.com/articles/caching-your-github-password-in-git#platform-mac).

Once you've confirmed you have the credential helper, enter `git config --global credential.helper osxkeychain`.

#### Linux

In the shell, enter `git config --global credential.helper 'cache --timeout=10000000'` to store your password for ten million seconds (that's 16 weeks, enough for a full term).
  

### Trigger a username / password challenge

In a shell with working directory set to the local test Git repo, enter `git push -u origin master`. One last time you will be asked for your username and password.
  
Enter `git push -u origin master` again. You should not be asked for your username and password, instead you should see "Everything up-to-date".
  
Rejoice and close the shell. From now on your "Push" button in RStudio will just work.

### More options

* Above we are connecting to GitHub via HTTPS. The (more complicated) alternative is [SSH](https://help.github.com/articles/generating-ssh-keys). Try to get HTTPS working, but you can resort to SSH if need be.
