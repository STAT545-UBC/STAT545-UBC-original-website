---
title: "Notes to self"
author: "Jenny Bryan"
date: "1 September, 2014"
output: html_document
---

#### Initial web set up

__2014-09-01__: I want a better looking web page this year but don't want to get on the Jekyll crazy train, with all the Ruby headaches. The plan: exploit [RMarkdown v2](http://rmarkdown.rstudio.com) and GitHub Pages to the max and get a few nice things from learning a bit of CSS.

I read every word of the documentation on the [HTML Document format](http://rmarkdown.rstudio.com/html_document_format.html) and scrutinized how RStudio made that entire site with RMarkdown v2 + customization. Check out their [gh-pages branch](https://github.com/rstudio/rmarkdown/tree/gh-pages) to look around.

I got my navbar at the top by following the post [Simple Horizontal Navigation](http://css-snippets.com/simple-horizontal-navigation/) from Lisa Catalano.

I learned other useful stuff from the post [Get Started With GitHub Pages (Plus Bonus Jekyll)](http://24ways.org/2013/get-started-with-github-pages/). In particular, Anna Debenham explained how to make `gh-pages` the default branch for a repo and led me to the post [GitHub Pages Workflow and deleting git’s master branch](http://oli.jp/2011/github-pages-workflow/#deleting-master). Oli Studholme had a situation similar to mine: "I wanted to have everything in `gh-pages` and *no* `master` branch, as the project page basically is the project".

__2014-09-02__: Forget all that about deleting `master` branch, in favor of `gh-pages`. That will come in handy for User and Project pages but NOT for an Organization Page which, apparently, MUST be served out of the `master` branch. Now I know. So I undid all of that.

I'm generating a table of class meetings on the Syllabus page and my hacky solution for making the two tables the same width and less wide came from the post [Addendum to yesterday’s post on custom CSS and R Markdown](http://nsaunders.wordpress.com/2012/08/28/addendum-to-yesterdays-post-on-custom-css-and-r-markdown/). The solution was to just drop some CSS relevant to tables directly into the Markdown; I'm sure this is not a great idea but it worked.

#### Miscellany

Random note for STAT 547M and getting data from the web. The flight data used in Wickham's UseR! 2014 `dplyr` tutorial ... once you find the airports with the worst delays, it would be totally natural to look up the IATA airport codes on the web to see where they are. Would lead naturally to talking to an API from R (Googling suggest such exist for the IATA codes). Then you could even map them or something.

Link to <http://swirlstats.com> in the first block on learning R.

Links collected when writing Git installation instructions. Most of these may not be needed by STAT 545A and are interesting to me re: re-installing my OS.

  * <http://superuser.com/questions/666086/install-git-under-osx-mavericks> go here if Mac users install Git from git-scm.com and then have trouble with the Xcode git wrapper getting in the way
  * <http://blog.bobbyallen.me/2014/03/07/how-to-install-git-without-having-to-install-xcode-on-macosx/>
  * <http://coolestguidesontheplanet.com/install-update-latest-version-git-mac-osx-10-9-mavericks/>
  * <http://burnedpixel.com/blog/setting-up-git-and-github-on-your-mac/>
  * <http://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/>
  * <https://github.com/jennybc/stat540_2014/blob/master/seminars/seminar92_git.md>
  
<http://joshldavis.com/2014/06/30/github-university-follow-up/> Good write up of using GitHub in a course

