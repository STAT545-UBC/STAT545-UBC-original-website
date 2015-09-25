---
title: Git Clients
output:
  html_document:
    toc: true
    toc_depth: 4
---

### What and why

Learning how and why to use version control can be rough at first. I found the use of a GUI – as opposed to the command line – extremely helpful when I was getting started. I call this sort of helper application a Git client. Actually I call it a Git(Hub) client because they also help you interact with GitHub.

Git and your Git client are not the same thing, just like R and RStudio are not the same thing. A Git client and the RStudio IDE are not necessary to use to Git or R, respectively, but they make the experience more pleasant because they reduce the amount of [command line bullshittery](http://www.pgbovine.net/command-line-bullshittery.htm).

RStudio offers a very basic Git client. I use this often for simple operations, but you probably want another, more powerful one as well.

Fair warning: for some things, you will have to use the command line. But the more powerful your Git client is, the less often this happens.

Fantastic news: because all of the clients are just forming and executing Git commands on your behalf, you don't have to pick one. You can literally do one operation from the command line, do another from RStudio, and another from SourceTree, one after the other, and it just works. *Very rarely, both clients will scan the repo at the same time and you'll get an error message about `.git/index.lock`. Try the operation again at least once before doing any further troubleshooting.*

### Recommendations for Git clients

* [SourceTree](http://www.sourcetreeapp.com) is a free, powerful Git(Hub) client that I highly recommend. It was my first Git client and is still my favorite for nontrivial Git tasks. Available for Mac and Windows.

* [GitUp](http://gitup.co) is a free, open source client for Mac OS. I've heard really good things about it and like what I read on the website. Suspect it's as good or better than SourceTree for the Mac folks.

* GitHub also offers [a free Git(Hub) client](https://desktop.github.com/) for Windows and Mac. We [do not recommend it for Windows users](git01_git-install.html#git-installation-windows) for use in the class. We [recommend it for Mac users with serious reservations](git01_git-install.html#git-installation-mac). What do we object to? The degree of hand-holding offered by these two clients borders on hand-*cuffs*.

* A free multi-platform Git(Hub) client is [SmartGit](http://www.syntevo.com/smartgit/).

* Browse [even more Git(Hub) clients](http://git-scm.com/downloads/guis).

Go back to the [index for the all the Git stuff](git00_index.html).
