---
title: Working with RStudio, Git, GitHub
output:
  html_document:
    toc: true
    toc_depth: 4
---

This set of instructions was used successfully September 2014, with a group of 40+ students. We knew the OS for 35 of them, split evenly between Windows and \*nix. Specifically, Mac (n = 16; 45%), Windows 8 (n = 12; 34%), Windows 7 (n = 6; 17%), Linux (n =1; 3%).

### Level 1: Installation

  * [Register a free GitHub account](https://github.com). If you are eligible, you may want to take advantage of the offers available at [GitHub Education](https://education.github.com).
  * [Install R and RStudio](block000_r-rstudio-install.html)
  * [Install Git](git01_git-install.html)
  * [Install a Git client](git02_git-clients.html) *optional but recommended*

### Level 2: Setup

  * [Tell RStudio where to find Git](git03_rstudio-meet-git.html)
  * [Introduce yourself to Git](git04_introduce-self-to-git.html)

### Level 3: Burn in

  * [Test connection between RStudio and GitHub](git05_first-use-git-rstudio.html)
  * [GitHub credential caching](git06_credential-caching.html)

### Level 4: Daily workflow

  * [STAT545 RStudio and GitHub workflow](git07_git-usage.html)

### Troubleshooting

#### Push/Pull buttons greyed out in RStudio

Are you sure your local repository is tracking a remote repository, e.g. a GitHub repo? Go [here](git07_git-usage.html#step-2-plan-b) for instructions on how to check. There is more discussion of this on an [RStudio Support thread](https://support.rstudio.com/hc/communities/public/questions/200640128-It-seems-that-if-git-remote-was-specified-at-the-command-line-that-it-s-not-reflected-in-the-RStudio-UI).

#### Push fail

Do you get this error in RStudio?

```
error: unable to read askpass response from 'rpostback-askpass'
```

Get a successful push from the command line *first*, before pushing through RStudio. Step-by-step instructions are in [GitHub credential caching](git06_credential-caching.html).

#### Push rejected

You might have changes on the remote AND on your local repo. Just because you don't remember making any edits in the browser doesn't mean you didn't. Humor me.

Pull first. Resolve any conflicts. Then try your push again.

#### RStudio is not making certain files available for staging/commiting

Do you have spaces in your directory or file names? I told you that was a terrible idea. Get rid of them. If that doesn't fix it, I also highly recommend you have a [more powerful Git(Hub) client](git02_git-clients.html) installed for these situations.

### Resources

We are practicing what we preach! This entire website is created with the tools and workflows described above. Go ahead and [watch us work](https://github.com/STAT545-UBC/STAT545-UBC.github.io).

Long-term, you should understand more about what you are doing. Rote clicking in RStudio may be a short-term survival method but won't work for long.

  * [trygit](https://try.github.io/levels/1/challenges/1) is to (command line) Git as [swirl](http://swirlstats.com) is to R. Learn by doing, in small bites.

  * The book [Pro Git](http://git-scm.com/book) is fantastic and comprehensive.

  * [GitHub's own training materials](http://training.github.com/kit/) may be helpful.

    - They also point to [many other resources](https://help.github.com/articles/what-are-other-good-resources-for-learning-git-and-github)

  * Find a [powerful Git client](git02_git-clients.html) if you'd like to minimize your usage of Git from the command line.
  
  * The [Curated Git Links of 2014](http://thelinell.com/2014/12/23/curated-git-links-of-2014/) collected by Linell Bonnette range "from easy fixes to (mindblown)". They might help you get out of some common pickles as your usage becomes more advanced.
  