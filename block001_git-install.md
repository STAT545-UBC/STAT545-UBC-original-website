---
title: Git Installation
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Git installation: Windows

I do not personally use Windows but some of my best friends do :)

Here are two approaches I can recommend.

[Software Carpentry](http://software-carpentry.org) is an organization that "teaches lab skills for scientific computing". They recommend:

  * [Git for Windows](http://msysgit.github.io), previously known as `mysysgit`, to get Git in addition to some other useful tools, such as the Bash shell.
  * This approach supports a transition to more expert use, because I think it leaves you with a more conventional Git installation and the Bash shell, which will be useful as you venture outside of R/RStudio.
  
The GitHub hosting site offers [GitHub for Windows](https://windows.github.com) that provides Git itself, a GUI front-end, and smooth integration with GitHub.

  * [Their Windows set-up instructions](https://help.github.com/articles/set-up-git#platform-windows) recommend this method of Git installation.
  * This is a better choice for novices in scientific computing, because it's more likely to "just work". You may eventually outgrow it, but you can cross that bridge when you come to it.

### Git installation: Mac

I am a Mac user, so have experience here.

As with Windows, I present several approaches, but the weight I put on them is different.

You can install Git from here: <http://git-scm.com/downloads>.

  * Should work for OS X 10.8 and higher.
  * For older versions of OS X (10.5-10.7) use the most recent available installer available [here](https://code.google.com/p/git-osx-installer/downloads/list). Use the Leopard installer for 10.5 and the Snow Leopard installer for 10.6-10.7.
  * This arguably sets you up the best for the future and should "just work" for most people. It will certainly get you the latest version of Git of all approaches described here. It is the most widely recommended installation method.
  * Let me know if you get errors about having "no developer tools" or Xcode and I can link to some solutions.
  
You can get Git from Apple's developer tools. *Exactly how to do this varies quite a bit across different OS X versions, plus it seems to be inferior to the other approaches I present. Will not flesh out for now.*

The GitHub hosting site offers [GitHub for Mac](https://windows.github.com) that provides the option to install Git itself.

  * This blog post [Installing Git from GitHub for Mac](https://github.com/blog/1510-installing-git-from-github-for-mac) explains how to trigger that option.
  * This is a good choice for novices in scientific computing, because it's more likely to "just work". You may eventually outgrow it, but you can cross that bridge when you come to it.

If you anticipate getting heavily into scientific computing, you're going to be installing lots of software. You should check out [homebrew](http://brew.sh), "the missing package manager for OS X". Among many other things, it can install Git for you. Our own TA [Shaun Jackman](https://github.com/sjackman) works on [homebrew-science](https://github.com/Homebrew/homebrew-science), so he's the local expert.

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
