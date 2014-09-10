---
title: Git configuration and credential caching
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

Once you have [Git installed](block001_git-install.html), you still have some set-up to complete. If you installed Git by way of a Git client, such as [GitHub for the Mac](https://mac.github.com), you may have already been guided through some or all of this. Lucky you. We record some info here, for those less fortunate.

### WWGD: What would GitHub do?

Feel free to just read [GitHub's advice](https://help.github.com/articles/set-up-git)!

### `git config`

Git associates your name and e-mail address with each commit, which is helpful downstream if multiple people collaborate on a project. To configure your name and e-mail address in git, open the Terminal and run…

```sh
git config --global user.name 'Your Name'
git config --global user.email 'your@email.com'
```

### Getting `git` to remember your GitHub username and password

It will be maddening to enter you GitHub credentials every time you push or pull. That sort of friction will kill your momentum and enthusiasm. You must get that sorted out so it's automatic.

This can be set up one of two ways:

  * HTTPS
  * SSH
  
I advice you try to get HTTPS working.

[GitHub's instructions](https://help.github.com/articles/set-up-git#next-steps-authenticating-with-github-from-git) are great. Follow the ones relevant to your OS.

### Interpretation of common errors

If you see this error message when using RStudio as your Git client:

```
error: unable to read askpass response from 'rpostback-askpass'
fatal: could not read Username for 'https://github.com': Device not configured
```

it means your GitHub credentials have not been cached in a way that RStudio, when acting as you Git client, can use to exchange files with GitHub. We have seen instances of someone able to push / pull from the command line and NOT from RStudio. *I really need to record details next time this happens.*

### Tricks that have occasionally come in handy

#### Password Caching on Mac

Do this in a terminal to tell Git to cache your password for the next four months (about ten million seconds):

```sh
git config --global credential.helper 'cache --timeout=10000000'
```

You'll then have to force git to ask for your password once at the command line. You can do this by cloning your GitHub repository and then pushing it back to GitHub. In the following commands, substitute USERNAME for your GitHub user name, and REPOSITORY for the name of your repository.

```sh
git clone https://github.com/USERNAME/REPOSITORY
cd REPOSITORY
git push
```

#### Password Caching on Windows

Via [Andy Leung](http://learn.stat.ubc.ca/~andy.leung/): In recent workshops (written September 2014), some Windows users have had a good experience with the [Windows Credential Store for Git](http://gitcredentialstore.codeplex.com/). The following simply paraphrases their instructions.

  * Download the [git-credential-winstore.exe](http://gitcredentialstore.codeplex.com/releases/view/103679) application.

  * Run it! It should work if Git is in your `PATH` environment variable. If not, go to the directory where you downloaded the application and run the following:
  
    ```
    git-credential-winstore -i C:\Path\To\Git.exe
    ```
For example, the path might be: `C:\Program Files (x86)\Git\bin\git.exe`.

  * The first time you, e.g., pull from GitHub, you will be prompted to enter the username and password of your Github account. From then on, you should be good to go.

If you want to undo this, type the following in the shell:

```
git config --unset --global credential.helper
```

