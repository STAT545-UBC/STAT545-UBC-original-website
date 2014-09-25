---
title: Git Installation
output:
  html_document:
    toc: true
    toc_depth: 4
---

#### Overview

Learning how and why to use version control can be rough at first. I found the use of a GUI -- as opposed to the command line -- extremely helpful when I was getting started. I call this sort of helper application a __Git client__.

Git and your Git client are not the same thing, just like R and RStudio are not the same thing. A Git client and the RStudio IDE are not *necessary* to use to Git or R, respectively, but they make the experience more pleasant.

What's my point? Use of a Git client affects how you will install Git and how you will configure Git to interact with GitHub. Some Git clients will install Git for you; these are the Git clients aimed at novices, which prioritize ease of use over power. Other Git clients, aimed at intermediate/advanced users, will assume you can install Git yourself.

RStudio offers a very basic Git client. I use this often for simple operations, but you probably want another, more powerful one as well. So check out [Git clients we recommend](git_clients.html).

Fair warning: for some things, you will have to use the command line. But the more powerful your Git client is, the less often this happens.

### Git installation: Windows

**Option 1** (*recommended*): [Software Carpentry](http://software-carpentry.org) is an organization that "teaches lab skills for scientific computing". They recommend:

  * Install [Git for Windows](http://msysgit.github.io), previously known as `mysysgit`, to get Git in addition to some other useful tools, such as the Bash shell.
  * This approach leaves the Git executable in a conventional location, which will help you and other programs, e.g. RStudio, find it and use it. This also supports a transition to more expert use, because `mysysgit` installs the Bash shell, which will be useful as you venture outside of R/RStudio.
  * This also leaves you with a Git client, though not a very good one. So check out [Git clients we recommend](git_clients.html).
  
**Option 2** (*we do not recommend this as of 2014-09-14*): The GitHub hosting site offers [GitHub for Windows](https://windows.github.com) that provides Git itself, a client, and smooth integration with GitHub.

  * [Their Windows set-up instructions](https://help.github.com/articles/set-up-git#platform-windows) recommend this method of Git installation.
  * *Update from the future*: We had several instances of GitHub for Windows installing Git in suboptimal locations, such as `~/AppData/Local`, and in other places we could never find. If you were __only__ going to interact with GitHub via this app, maybe that's OK, but that's not the case for us. Therefore, we recommend option 1 instead.
  
After installation, you still need to configure Git and get it to remember your GitHub username and password. If your Git client guides you through this, seize that opportunity! Otherwise go [here](git_credentials.html) for some assistance.

### Git installation: Mac

**Option 1** (*recommended*): Install Git from here: <http://git-scm.com/downloads>.

  * Should work for OS X 10.8 and higher.
  * For older versions of OS X (10.5-10.7) use the most recent available installer available [here](https://code.google.com/p/git-osx-installer/downloads/list). Use the Leopard installer for 10.5 and the Snow Leopard installer for 10.6-10.7.
  * This arguably sets you up the best for the future and should "just work" for most people. It will certainly get you the latest version of Git of all approaches described here. It is the most widely recommended installation method.
  * Let me know if you get errors about having "no developer tools" or Xcode and I can link to some solutions.
  * This leaves you with NO Git client! So check out [Git clients we recommend](git_clients.html).


**Option 2**: You can also get Git from Apple's developer tools. *Exactly how to do this varies quite a bit across different OS X versions, plus it seems to be inferior to the other approaches I present. Will not flesh out for now.*

**Option 3**: The GitHub hosting site offers [GitHub for Mac](https://windows.github.com) that provides *the option* to install Git itself, a client, and smooth integration with GitHub..

  * This blog post [Installing Git from GitHub for Mac](https://github.com/blog/1510-installing-git-from-github-for-mac) explains how to trigger the option to install Git, which I recommend.
  * This is a good choice for novices in scientific computing, because it's more likely to "just work". You may eventually outgrow it, but you can cross that bridge when you come to it.

**Option 4**: If you anticipate getting heavily into scientific computing, you're going to be installing lots of software. You should check out [homebrew](http://brew.sh), "the missing package manager for OS X". Among many other things, it can install Git for you. Our own TA [Shaun Jackman](https://github.com/sjackman) works on [homebrew-science](https://github.com/Homebrew/homebrew-science), so he's the local expert.


### Git installation: Linux

If Git is not already available on your machine you can try to install it via your distro's package manager (e.g. apt-get or yum).

Ubuntu or Debian Linux

```sh
sudo apt-get install git
```

Fedora or RedHat Linux

```sh
sudo yum install git
```