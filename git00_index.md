---
title: Working with RStudio, Git, GitHub
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Level 1: Installation

  * [Install R and RStudio](block000_r-rstudio-install.html)
  * [Install Git](git01_git-install.html)
  * Optional but recommended: [Install a Git client](git02_git-clients.html)

### Level 2: Setup

  * [Tell RStudio where to find Git](git03_rstudio-meet-git.html)
  * [Introduce yourself to Git](git04_introduce-self-to-git.html)

### Level 3: Burn in

  * [Test connection between RStudio and GitHub](git05_first-use-git-rstudio.html)
  * [GitHub credential caching](git06_credential-caching.html)

### Level 4: Daily workflow

  * [STAT545 RStudio and GitHub workflow](block008_git-usage.md)

### Troubleshooting

#### Push/Pull buttons greyed out

check remote, push -u

#### Push rejected

pull first, resolve conflict, psuh

#### File disappears after adding

space in filename?

### Resources

Long-term, you should understand more about what you are doing. Rote clicking in RStudio may be a short-term survival method but won't work for long.

[trygit](https://try.github.io/levels/1/challenges/1) is to (command line) Git as [swirl](http://swirlstats.com) is to R. Learn by doing, in small bites.

The book [Pro Git](http://git-scm.com/book) is fantastic and comprehensive.

[GitHub's own training materials](http://training.github.com/kit/) may be helpful.

  * They also point to [many other resources](https://help.github.com/articles/what-are-other-good-resources-for-learning-git-and-github)

Find a [powerful Git client](git02_git-clients.html) if you'd like to minimize your usage of Git from the command line.