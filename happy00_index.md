---
title: Happy Git and GitHub for the useR
output:
  html_document:
    toc: true
    toc_depth: 4
---

*Temporary home for materials for my useR! 2016 tutorial [Using Git and GitHub with R, Rstudio, and R Markdown](https://github.com/jennybc/happy-git-with-r), while we decide how to deploy the standalone site.*

## Prep work you should have done in advance

It is vital that you attempt to get your system set up in advance. These are battle-tested instructions, so most will succeed. We believe in you! If you have trouble, you can open an issue [here](https://github.com/jennybc/happy-git-with-r/issues) and we *might* be able to help in the days leading up to useR! (no promises). We will have TAs at the workshop starting at 8:15am.

### Level 1: Installation

  * [Register a free GitHub account](https://github.com). If eligible, check the offers at [GitHub Education](https://education.github.com).
  * [Install or upgrade R and RStudio](block000_r-rstudio-install.html). Get current, people.
  * [Install Git](git01_git-install.html)
  * [Install a Git client](git02_git-clients.html). Optional but recommended.

### Level 2: Git and GitHub configuration

  * [Introduce yourself to Git](git04_introduce-self-to-git.html)
  * [Test connection to GitHub](git05_github-connection.html)

### Level 3: RStudio and Git and GitHub Extravaganza

  * [Test connection between RStudio and GitHub](git07_git-github-rstudio.html)
  * [Tell RStudio where to find Git](git03_rstudio-meet-git.html)
  * [GitHub credential caching](git06_credential-caching.html)
  
### Level 666: Troubleshooting

  * [RStudio, Git, GitHub Hell](git66_rstudio-git-github-hell.html)

## Reward for those who pre-installed

We will spend a little time at the start testing the above setup. If you are totally set up and ready to go, here's some reading and activities to keep you productively occupied.

*Is this a good idea? Necessary? Think on it.*

## New project

Revisit and expand "GitHub first, then RStudio" example presented here: [Test connection between RStudio and GitHub](git07_git-github-rstudio.html).

## R Markdown + GitHub workflow

[Test drive R Markdown](block007_first-use-rmarkdown.html) but embrace the Git/GitHub aspects.

Push HTML and show how unsatisfactory that is. Push markdown and show how nice that is.

Beef up with a good R script example and properly commented YAML.

## Existing project

~~Create an RStudio project, then make it a Git repo, then make a GitHub repo, then connect them.~~ *oh, let's not*

Easier though less elegant: create repo on GitHub, clone via RStudio, then copy your stuff in.

What if it's an existing project that is also a Git repo with a history you care about? Then you have to do it properly. Using the "RStudio first, then GitHub" template from here: [Test connection between RStudio and GitHub](git07_git-github-rstudio.html).

## Clone a project

For when you just want a copy of something. But also want to track its evolution, which would not be true if you just, say, downloaded the ZIP archive.

I could create a repo (or use one created above). They can clone. I can make a new commit. They can pull to get it.

More practice: Do this once with ... your favorite R package? The polygraphing film data (or something else that is not an R package)?

*need to explain when to do this versus fork*

## The repeated amend

local only, i.e. never amend a commit that's already pushed

affecting a remote, explain why so dangerous and when it *might* be ok

## Disaster recovery

Practice burn it all down.

Editing most recent commit or just its message.

Rebase avoidance techniques.

Headless state. Rebase hell.

<http://stackoverflow.com/questions?sort=votes>

## Engage with R source on GitHub

Browsing

Searching

  * My gist, re: the cran user: <https://gist.github.com/jennybc/4a1bf4e9e1bb3a0a9b56>
  * Recent search for roxygen template usage in the wild: <https://github.com/search?utf8=✓&q=man-roxygen+in:path&type=Code&ref=searchresults>

Being a useful useR

  * stay informed re: development
  * use issues for bug reports, feature requests
  * make pull requests
  
## Workflow and psychology

Stress of working in the open

Workflows for group of 1, 2, 5, 10.

### Resources

We practice what we preach! This entire website is created with the tools and workflows described above. Go ahead and [watch us work](https://github.com/STAT545-UBC/STAT545-UBC.github.io).

Long-term, you should understand more about what you are doing. Rote clicking in RStudio may be a short-term survival method but won't work for long.

  * [trygit](https://try.github.io/levels/1/challenges/1) is to (command line) Git as [swirl](http://swirlstats.com) is to R. Learn by doing, in small bites.

  * The book [Pro Git](http://git-scm.com/book) is fantastic and comprehensive.

  * [GitHub's own training materials](http://training.github.com/kit/) may be helpful. They also point to [many other resources](https://help.github.com/articles/what-are-other-good-resources-for-learning-git-and-github)

  * Find a [powerful Git client](git02_git-clients.html) if you'd like to minimize your usage of Git from the command line.
  
  * Hadley Wickham's book [R Packages](http://r-pkgs.had.co.nz) has an excellent [chapter on the use of Git, GitHub, and RStudio](http://r-pkgs.had.co.nz/git.html) in R package development. He covers more advanced usage, such as commit best practices, issues, branching, and pull requests.
  
  * It's not you, it's Git! If you're not crying already, these fictional-but-realistic Git man pages should do the trick: [git-man-page-generator](http://git-man-page-generator.lokaltog.net).
