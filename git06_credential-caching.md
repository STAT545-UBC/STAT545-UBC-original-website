---
title: Caching your GitHub credentials
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Why do we want to cache credentials?

You need to get Git to remember your GitHub username and password, so that every time you push, you do NOT have to authenticate yourself interactively.

**You only have to set this up once every couple of months or once per computer.**

You will know you have truly succeeded once you have at least one successful push to GitHub in which you are NOT challenged for your user name and password.

### Get a test repository

You need a functioning test Git repository. One that exists locally and remotely on GitHub, with the local repo tracking the remote.

If you have just [verified that you can interact with GitHub](git05_github-connection.html) from your local computer, that test repo will be perfect.

If you are [testing that you can work with GitHub from RStudio](git06_git-github-rstudio.html), that test repo will be perfect.

You may proceed when

  * You have a test repo.
  * You know where it lives on your local computer. Example:
    - `/home/jenny/tmp/myrepo`
  * You know where it lives on GitHub. Example:
    - `https://github.com/jennybc/myrepo`
  * You know local is tracking remote. In a [shell](git09_shell.html) with working directory set to the local Git repo, enter these commands:
  
``` shell
jenny@2015-mbp myrepo $ git remote -v
origin	https://github.com/jennybc/myrepo (fetch)
origin	https://github.com/jennybc/myrepo (push)

jenny@2015-mbp myrepo $ git branch -vv
* master b8e03e3 [origin/master] line added locally
```
  
We want to see that fetch and push are set to remote URLs that point to your GitHub repo. We also want to see that your local master branch has your GitHub master branch as upstream remote. Gibberish? Just check that your output looks similar to mine.

### Verify that your Git is new enough to have a credential helper

In a [shell](git09_shell.html), enter `git --version` and verify that you have 1.7.10 or newer. If you don't, [update Git](git01_git-install.html).
  
### Turn on the credential helper

#### Windows

In the shell, enter `git config --global credential.helper wincred`

#### Windows, plan B

If that doesn't seem to work, install an external credential helper.

  * Download the [git-credential-winstore.exe](http://gitcredentialstore.codeplex.com/) application.
  
  * Run it! It should work if Git is in your `PATH` environment variable. If not, go to the directory where you downloaded the application and run the following:
  `git-credential-winstore -i "C:\Program Files (x86)\Git\bin\git.exe"`

#### Mac

Find out if the credential helper is already installed. In the [shell](git09_shell.html), enter `git credential-osxkeychain`. You should see something like this: `Usage: git credential-osxkeychain <get|store|erase>`. If you do **not**, follow steps 2 and 3 on [the github help](https://help.github.com/articles/caching-your-github-password-in-git#platform-mac).

Once you've confirmed you have the credential helper, enter `git config --global credential.helper osxkeychain`.

#### Linux

In the [shell](git09_shell.html), enter `git config --global credential.helper 'cache --timeout=10000000'` to store your password for ten million seconds (that's 16 weeks, enough for a full term).
  

### Trigger a username / password challenge

Change a file in your local repo and commit it. Do that however you wish. Here are [shell](git09_shell.html) commands that will work:

``` shell
echo "adding a line" >> README.md
git add -A
git commit -m "A commit from my local computer"
```

Now push!

``` shell
git push -u origin master
```

One last time you will be asked for your username and password, which hopefully will be cached.

Now push AGAIN.

``` shell
git push
```
  
You should NOT be asked for your username and password, instead you should see `Everything up-to-date`.
  
Rejoice and close the [shell](git09_shell.html). From now on your "Push" button in RStudio will just work.

### More options

* Above we are connecting to GitHub via HTTPS. The alternative is [SSH](https://help.github.com/articles/generating-ssh-keys). We follow [GitHub's advice](https://help.github.com/articles/which-remote-url-should-i-use/), which is to prefer HTTPS over SSH, but both are perfectly valid.
