---
title: Automatic GitHub authentication
output:
  html_document:
    toc: true
    toc_depth: 4
---

#### Overview

You need to get Git to remember your GitHub username and password, so that every time you, e.g., push, you do NOT have to authenticate yourself interactively.

**You only have to set this up once every couple of months or once per computer.**

You will know you have truly succeeded once you have at least one successful push to GitHub in which you are NOT challenged for your user name and password. 

#### Windows

**Option 1** (*recommended*): Assumes the Git executable is available at the command line; see the [git install instructions](block001_git-install.html).

  * In the shell (RStudio Tools > Shell), enter `git --version` and verify that you have 1.7.10 or newer. If you don't, update Git.
  
  * In the shell, enter `git config --global credential.helper 'wincred --timeout=10000000'` to store your password for ten million seconds (that's 16 weeks, enough for a full term).
  
  * Make sure you are in a directory that is a Git repository of interest and that is already associated with a remote repository on GitHub. In the shell, enter `git push -u origin master`. One last time you will be asked for your username and password.
  
  * Enter `git push -u origin master` again. You should not be asked for your username and password, instead you should see "Everything up-to-date".
  
  * Rejoice and close the shell. From now on your "Push" button in RStudio will just work.

**Option 2** (*only if Option 1 does not work*): Requires an external credential helper.
  
  * Download the [git-credential-winstore.exe](http://gitcredentialstore.codeplex.com/) application.
  
  * Run it! It should work if Git is in your `PATH` environment variable. If not, go to the directory where you downloaded the application and run the following:
  `git-credential-winstore -i "C:\Program Files (x86)\Git\bin\git.exe"`
  
    * In the shell (RStudio Tools > Shell), type `git push -u origin master`. One last time you will be asked for your username and password.
  
  * Enter `git push -u origin master` again. You should not be asked for your username and password, instead you should see "Everything up-to-date".
  
  * Rejoice and close the shell. From now on your "Push" button in RStudio will just work.

#### Mac

  * In the shell (RStudio Tools > Shell), enter `git --version` and verify that you have 1.7.10 or newer. If you don't, update Git.
  
  * In the shell, enter `git credential-osxkeychain`. If you do **not** get `Usage: git credential-osxkeychain <get|store|erase>`, follow steps 2 and 3 on [the github help](https://help.github.com/articles/caching-your-github-password-in-git#platform-mac).
  
  * In the shell, enter `git config --global credential.helper 'osxkeychain --timeout=10000000'` to store your password for ten million seconds (that's 16 weeks, enough for a full term).
  
  * Make sure you are in a directory that is a Git repository of interest and that is already associated with a remote repository on GitHub. In the shell, enter `git push -u origin master`. One last time you will be asked for your username and password.
  
  * Type `git push -u origin master` again. You should not be asked for your username and password, instead you should see "Everything up-to-date".
  
  * Rejoice and close the shell. From now on your "Push" button in RStudio will just work.

#### Linux

  * In the shell (RStudio Tools > Shell), enter `git --version` and verify that you have 1.7.10 or newer. If you don't, update Git.
  
  * In the shell, enter `git config --global credential.helper 'cache --timeout=10000000'` to store your password for ten million seconds (that's 16 weeks, enough for a full term).
  
  * Make sure you are in a directory that is a Git repository of interest and that is already associated with a remote repository on GitHub. In the shell, enter `git push -u origin master`. One last time you will be asked for your username and password.
  
  * Enter `git push -u origin master` again. You should not be asked for your username and password, instead you should see "Everything up-to-date".
  
  * Rejoice and close the shell. From now on your "Push" button in RStudio will just work.

#### More options

* Above we are connecting to GitHub via HTTPS. The (more complicated) alternative is [SSH](https://help.github.com/articles/generating-ssh-keys). Try to get HTTPS working, but you can resort to SSH if need be.
