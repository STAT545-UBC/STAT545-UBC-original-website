---
title: Introduce yourself to Git
output:
  html_document:
    toc: true
    toc_depth: 4
---

**You only have to set this up once per machine.**

From RStudio, go to *Tools > Shell* and tell `git` your name and **GitHub email** by typing (use your own name and email):

  * `git config --global user.name 'Bernhard Konrad'`
  
    - This does __NOT__ have to be your GitHub username, although it can be. Another good option is your actual first name and last name. Your commits will be labelled with this name, so this should be informative to potential collaborators.

  * `git config --global user.email 'bernhard.konrad@gmail.com'`
  
    - This __must__ be the email that you used to sign up for GitHub.

These commands return nothing. You can check that `git` understood what you typed by looking at the output of `git config --global --list`.


Resources:

* [GitHub's advice](https://help.github.com/articles/set-up-git).