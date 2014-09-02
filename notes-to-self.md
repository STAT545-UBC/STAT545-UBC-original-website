---
title: "Notes to self"
author: "Jenny Bryan"
date: "1 September, 2014"
output: html_document
---

#### Initial web set up

2014-09-01: I want a better looking web page this year but don't want to get on the Jekyll crazy train, with all the Ruby headaches. The plan: exploit [RMarkdown v2](http://rmarkdown.rstudio.com) and GitHub Pages to the max and get a few nice things from learning a bit of CSS.

I read every word of the documentation on the [HTML Document format](http://rmarkdown.rstudio.com/html_document_format.html) and scrutinized how RStudio made that entire site with RMarkdown v2 + customization. Check out their [gh-pages branch](https://github.com/rstudio/rmarkdown/tree/gh-pages) to look around.

I got my navbar at the top by following the post [Simple Horizontal Navigation](http://css-snippets.com/simple-horizontal-navigation/) from Lisa Catalano.

I learned other useful stuff from the post [Get Started With GitHub Pages (Plus Bonus Jekyll)](http://24ways.org/2013/get-started-with-github-pages/). In particular, Anna Debenham explained how to make `gh-pages` the default branch for a repo and led me to the post [GitHub Pages Workflow and deleting git’s master branch](http://oli.jp/2011/github-pages-workflow/#deleting-master). Oli Studholme had a situation similar to mine: "I wanted to have everything in `gh-pages` and *no* `master` branch, as the project page basically is the project".
