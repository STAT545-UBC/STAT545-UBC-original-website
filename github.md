---
title: Working with RStudio, Git, GitHub
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Level 1: Installation

* [Install R and RStudio](block000_r-rstudio-install.html)
* [Install Git](block001_git-install.html)
* Optional: [Install a Git client](git_clients.html)


### Level 2: Setup

* [Tell RStudio where to find Git](git_whereToFind.html)
* [Introduce yourself to Git](git_introduceToGit/html)


### Level 3: Daily workflow

* [Setup RStudio to GitHub connection for the first time](block005_first-use-git-rstudio.html)
* [Set up credential caching](git_credentials.html)
* [STAT545 RStudio and GitHub workflow](block008_git-usage.md)


### Trouble shooting

#### Push/Pull buttons greyed out

check remote, push -u


#### Push rejected

pull first, resolve conflict, psuh


#### File disappears after adding

space in filename?


### Resources

Long-term, you should understand more about what you are doing. Rote clicking in RStudio is a short-term survival method but won't work for long.

[trygit](https://try.github.io/levels/1/challenges/1) is to (command line) Git as [swirl](http://swirlstats.com) is to R. Learn by doing, in small bites.

The book [Pro Git](http://git-scm.com/book) is fantastic and comprehensive.

[GitHub's own training materials](http://training.github.com/kit/) may be helpful.

  * They also point to [many other resources](https://help.github.com/articles/what-are-other-good-resources-for-learning-git-and-github)

Find a [powerful Git client](git_clients.html) if you'd like to minimize your usage of Git from the command line.