---
title: Introduce yourself to Git
output: html_document
---

**You only have to set this up once per machine.**

### TL;DR

``` sh
git config --global user.name 'Jennifer Bryan'
git config --global user.email 'jenny@stat.ubc.ca'
git config --global --list
```

In words ...

From RStudio, go to *Tools > Shell* and tell `git` your name and **GitHub email** by typing (use your own name and email):

  * `git config --global user.name 'Jennifer Bryan'`
  
    - This does __NOT__ have to be your GitHub username, although it can be. Another good option is your actual first name and last name. Your commits will be labelled with this name, so this should be informative to potential collaborators.

  * `git config --global user.email 'jenny@stat.ubc.ca'`
  
    - This __must__ be the email that you used to sign up for GitHub.

These commands return nothing. You can check that `git` understood what you typed by looking at the output of `git config --global --list`.

Resources:

* [GitHub's advice](https://help.github.com/articles/set-up-git).
* [Quick primer on the shell](git09_shell.html)

Go back to the [index for the all the Git stuff](git00_index.html).
