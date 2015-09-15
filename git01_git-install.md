---
title: Install Git
output:
  html_document:
    toc: true
    toc_depth: 4
---

### But first, why?

[Git](http://git-scm.com) is a __version control system__. It's original purpose was to help groups of developers work collaboratively on big software projects. Git manages the evolution of a set of files -- called a __repository__ -- in a sane, highly structured way. If you have no idea what I'm talking about, think of it as the "Track Changes" features from Microsoft Word but much, much better.

Git has been re-purposed by the data science community. In addition to using it for source code, we use it to manage the motley collection of files that make up typical data analytical projects, which often consist of data, reports, and, yes, source code.

When you want to make your work visible to other people, either in a read-only way or for genuine collaboration, you can make the associated Git repository available on the web. This can be totally public or private to your closest friends. Regardless, this reduces the extra work associated with sharing and collaboration almost to zero, which has huge benefits. [GitHub](https://github.com) is a very popular hosting site that provides this service (and more). If you have no idea what I'm talking about, think of it as DropBox but much better (at least for our purposes).

Full participation in the "data community" these days practically requires familiarity with Git and GitHub. These tools are also helpful to us for course logistics, such as sharing code between instructor and student. For both reasons, we will be using Git and GitHub. Below we explain how to install the Git software locally on your computer.

### Preliminary about Git clients

Learning how and why to use version control can be rough at first. I found the use of a GUI – as opposed to the command line – extremely helpful when I was getting started. I call this sort of helper application a Git client. We have some strong recommendations about Git clients, which you can [read here](git02_git-clients.html).

Why think about your Git client before you install Git itself? Because some Git clients will install Git for you. These are the Git clients aimed at novices, which prioritize ease of use over power. Other Git clients, aimed at intermediate/advanced users, assume you will install Git yourself. So it's best to have a coordinated plan with respect to installing Git and a Git client.

Our recommendations vary by operating system, so read the section that applies to you below.

### Git installation: Windows

**Option 1** (*recommended*): We concur with [Software Carpentry](http://software-carpentry.org), an organization that "teaches lab skills for scientific computing", and paraphrase their installation instructions:

  * Install [Git for Windows](https://git-for-windows.github.io/), previously known as `msysgit` or "Git Bash", to get Git in addition to some other useful tools, such as the Bash shell. Yes, all those names are totally confusing.
  * This approach leaves the Git executable in a conventional location, which will help you and other programs, e.g. RStudio, find it and use it. This also supports a transition to more expert use, because the Bash shell will be useful as you venture outside of R/RStudio.
  * This also leaves you with a Git client, though not a very good one. So check out [Git clients we recommend](git02_git-clients.html).
  
**Option 2** (*we did not like this in 2014; jury's still out for 2015*): The GitHub hosting site offers [GitHub Desktop for Windows](https://desktop.github.com/) that provides Git itself, a client, and smooth integration with GitHub.

  * [Their Windows set-up instructions](https://help.github.com/articles/set-up-git#platform-windows) recommend this method of Git installation.
  * Why we don't like it: We had several instances of GitHub Desktop for Windows installing Git in suboptimal locations, such as `~/AppData/Local`, and in other places we could never find. If you were __only__ going to interact with GitHub via this app, maybe that's OK, but that's not the case for us. Therefore, we recommend option 1 instead.
  
After installation, you still need to [introduce yourself to Git](git04_introduce-self-to-git.html) and [get it to remember your GitHub username and password](git06_credential-caching.html). If your Git client guides you through this, seize that opportunity! Otherwise follow the links for some assistance.

### Git installation: Mac

**Option 1** (*recommended*): Install Git from here: <http://git-scm.com/downloads>.

  * The GitHub home for this project is here: <https://github.com/timcharper/git_osx_installer>.
  * This arguably sets you up the best for the future and should "just work" for most people. It will certainly get you the latest version of Git of all approaches described here. It is the most widely recommended installation method.
  * Let us know if you get errors about having "no developer tools" or Xcode and we can link to some solutions.
  * This leaves you with NO Git client! So check out [Git clients we recommend](git02_git-clients.html).

**Option 2**: The GitHub hosting site offers [GitHub Desktop for Mac](https://desktop.github.com/) that provides *the option* to install Git itself, a client, and smooth integration with GitHub..

  * This is an OK choice for novices in scientific computing, because it's more likely to "just work". You may eventually outgrow it, but you can cross that bridge when you come to it.
  * We are more keen on GitHub Desktop for Mac than for Windows, which is not saying much.

**Option 3**: If you anticipate getting heavily into scientific computing, you're going to be installing and updating lots of software. You should check out [homebrew](http://brew.sh), "the missing package manager for OS X". Among many other things, it can install Git for you. Previous STAT 545 TA [Shaun Jackman](https://github.com/sjackman) works on [homebrew-science](https://github.com/Homebrew/homebrew-science), so bring up any problems over in [Discussion](https://github.com/STAT545-UBC/Discussion/issues) and he probably won't be able to resist answering.

**Option 4**: You can also get Git from Apple's developer tools. *Exactly how to do this varies quite a bit across different OS X versions, plus it seems to be inferior to the other approaches I present. Will not flesh out unless this changes.*

After installation, you still need to [introduce yourself to Git](git04_introduce-self-to-git.html) and [get it to remember your GitHub username and password](git06_credential-caching.html). If your Git client guides you through this, seize that opportunity! Otherwise follow the links for some assistance.

### Git installation: Linux

If Git is not already available on your machine you can try to install it via your distro's package manager (e.g. `apt-get` or `yum`).

Ubuntu or Debian Linux

```sh
sudo apt-get install git
```

Fedora or RedHat Linux

```sh
sudo yum install git
```

After installation, you still need to [introduce yourself to Git](git04_introduce-self-to-git.html) and [get it to remember your GitHub username and password](git06_credential-caching.html).