---
title: "Git(Hub) usage"
output:
  html_document:
    toc: yes
    toc_depth: 4
---

### Overview

This describes the process of working with a Git(Hub) repository. It is highly specific to STAT545 and to using Git(Hub) with R stuff, so don't expect a general tutorial.

### Step 0: Software installation and configuration

We assume the following

  * You've already [installed Git and (probably) a Git client](block001_git-install.html).
  * You've already [registered a free GitHub account](cm001_course-intro-sw-install-account-signup.html#register-a-github-account).
  * You've already [installed R and RStudio](block000_r-rstudio-install.html).
  * You've [tested your installation and configuration of Git, GitHub, and RStudio](block005_first-use-git-rstudio.html)
  * You've completed [Homework 01](hw01_edit-README.html) or an equivalent exercise __to truly test__ all of the above.
  
We do not cover software installation and set-up here! This is just about __usage__.

### Step 1: Identify the remote repository to work on

I assume we are talking about the private GitHub repository that STAT545 has granted you. If your name is "Jennifer Bryan", your repo should be named `zz_jennifer_bryan-coursework`. Assuming you are logged in to GitHub, you should be able view (and edit online) this repo at a URL like so (link won't work because it's a fake example!):

<https://github.com/STAT545-UBC/zz_jennifer_bryan-coursework>

### Step 2: Establish a connection between the remote repository and a local one

**You only do this once! If you've already set this up, read and confirm but don't redo this. See Plan B.**

Go through the process described in Step 4 of [Test drive RStudio and Github](http://stat545-ubc.github.io/block005_first-use-git-rstudio.html#step-4-clone-the-new-github-repository-to-your-computer-via-rstudio) to establish a new connection between an existing remote GitHub repository and a new local repository.

When you __first__ do this, you accomplish two things:

  * copy any files that exist on the remote, such as the `README.md` you created via the browser, to you local repo
  * set up a long-term relationship for future pushing and pulling

This is called "tracking a remote" in Git jargon. Learn more than you ever wanted to [here](http://git-scm.com/book/en/Git-Basics-Working-with-Remotes).

### Step 2, plan B

If you think you've already established this connection, here's how you can check.

Launch RStudio and open the Project that you believe to be the Git repo associated with your coursework and to be tracking the correct repo on GitHub.

Get into a shell (RStudio > Tools> Shell ...).

Enter `pwd` to see working directory and re-confirm that you are indeed in the correct directory.

Enter `git remote -v`.

Here's what I see (note I'm in the main repo for STAT 545 content):

```sh
origin  https://github.com/STAT545-UBC/STAT545-UBC.github.io.git (fetch)
origin	https://github.com/STAT545-UBC/STAT545-UBC.github.io.git (push)
```

You should see something like that, but __for your private STAT545 repository__.

### Step 3 Commit local changes

I assume you've got some local work completed or can do some now. I'll wait....

Commit these changes to your local repo.

From RStudio:

  * Click the "Git" tab in upper right pane
  * Check "Staged" box for any files whose existence or modifications you want to commit.
    - To see more detail on what's changed in file since you last committed, click on "Diff" for a Git pop-up
  * If you're not already in the Git pop-up, click "Commit"
  * Type a message in "Commit message"
  * Click "Commit"

### Step 4 Pull from GitHub

We will pull any changes that are on the GitHub repo but not yet on your local version. Why?

  * More confirmation that the connection is working.
  * Legitimate concern that there could be "upstream" changes you need. Maybe you've done some editing in the browser?
  * Establish this habit for the future.
  
If RStudio is behaving well as your Git client, you should be able to use the blue "pull" arrow button.

You can also do this from the command line with `git pull`. Here's what you'll see if there's nothing to pull, which is probably the case:

```sh
Jennifers-MacBook-Pro-3:STAT545-UBC.github.io jenny$ git pull
Already up-to-date.
```

### Step 5 Push to GitHub

If RStudio is behaving well as your Git client, you should be able to use the green "push" arrow button.

You can also do this from the command line with `git push`. After I made some edits to this document and in the topic index, here's what my push looked like:

```sh
Jennifers-MacBook-Pro-3:STAT545-UBC.github.io jenny$ git push
Counting objects: 13, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (10/10), done.
Writing objects: 100% (10/10), 5.97 KiB | 0 bytes/s, done.
Total 10 (delta 7), reused 0 (delta 0)
To https://github.com/STAT545-UBC/STAT545-UBC.github.io.git
   c82b90b..89b984e  master -> master
```

That's an example of a successful push.

### The end

Now just ... repeat. Do work somewhere. Commit it. Push it or pull it depending on where you did it, but get local and remote "synced up". Repeat.

### Resources

Long-term, you should understand more about what you are doing. Rote clicking in RStudio is a short-term survival method but won't work for long.

[trygit](https://try.github.io/levels/1/challenges/1) is to (command line) Git as [swirl](http://swirlstats.com) is to R. Learn by doing, in small bites.

The book [Pro Git](http://git-scm.com/book) is fantastic and comprehensive.

[GitHub's own training materials](http://training.github.com/kit/) may be helpful.

  * They also point to [many other resources](https://help.github.com/articles/what-are-other-good-resources-for-learning-git-and-github)

[SourceTree](https://help.github.com/articles/what-are-other-good-resources-for-learning-git-and-github) is a much more powerful Git client than RStudio provides. I highly recommend it if you'd like to minimize your usage of Git from the command line.