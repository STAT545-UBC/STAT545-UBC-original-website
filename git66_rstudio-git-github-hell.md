---
title: RStudio, Git, GitHub Hell
output:
  html_document:
    toc: true
    toc_depth: 4
---

#### I think I have installed Git but damn if I can find it

When you install Git, try to control or record where it is being installed! Make a mental or physical note of these things.

You may be able to find Git after the fact with these commands in the [shell](git09_shell.html):

* `which git` (Mac, Linux)

* `where git` (Windows)

It is not entirely crazy to just re-install Git, using a method that leaves it in a more conventional location, and to pay very close attention to where it's being installed. Live and learn.

#### Dysfunctional PATH

I'm pretty sure that most cases of RStudio *not* automatically detecting the Git executable stem from problems with `PATH`. This is the set of directories where your computer will look for executables, such as Git (today) or `make` (later in this course). Certain methods of Git installation, especially on Windows and/or older OSes, have a higher tendency to put Git in an unconventional location or to fail to add the relevant directory to `PATH`.

How to see your `PATH`?

In the [shell](git09_shell.html):

``` shell
echo $PATH
```

Take a good hard look at this. See the point above about finding your Git executable or re-installing it while you are **wide awake**. Is the host directory in your `PATH`? No? **Fix that.**

Go [here](http://www.troubleshooters.com/linux/prepostpath.htm) for instructions on what to put in your `.bash_profile` in order to add a directory to `PATH`.

#### Push/Pull buttons greyed out in RStudio

Are you sure your local repository is tracking a remote repository, e.g. a GitHub repo? In a [shell](git09_shell.html) with working directory set to the local Git repo, enter these commands:
  
``` shell
jenny@2015-mbp myrepo $ git remote -v
origin	https://github.com/jennybc/myrepo (fetch)
origin	https://github.com/jennybc/myrepo (push)

jenny@2015-mbp myrepo $ git branch -vv
* master b8e03e3 [origin/master] line added locally
```

We want to see that fetch and push are set to remote URLs that point to the remote repo. We also want to see that your local master branch has your GitHub master branch as upstream remote.

If you discover you still need to set a remote, go to the [shell](git09_shell.html) and get into the working directory of the RStudio Project and Git repo of interest.

  * Initiate the "upstream" or "tracking" relationship by adding a remote. Substitute the HTTPS URL for **your GitHub repo**.

    ``` shell
    git remote add origin https://github.com/jennybc/myrepo.git
    ```
  * Download all the files from the online GitHub repository and deal with any conflicts.
  
    ``` shell
    git pull origin master
    ```

  * Cement the tracking relationship between your GitHub repository and the local repo by pushing and setting the "upstream" remote:
  
    ``` shell
    git push -u origin master
    ```

#### I have no idea if my local repo and my remote repo are connected.

See the above section on "Push/Pull buttons greyed out in RStudio."

#### Push fail at the RStudio level

Do you get this error in RStudio?

```
error: unable to read askpass response from 'rpostback-askpass'
```

Open the [shell](git09_shell.html): *Tools > Shell*.

``` shell
git push -u origin master
```

#### Push rejected, i.e. fail at the Git/GitHub level

You might have changes on the remote AND on your local repo. Just because you don't remember making any edits in the browser doesn't mean you didn't. Humor me.

Pull first. Resolve any conflicts. Then try your push again.

#### RStudio is not making certain files available for staging/commiting

Do you have spaces in your directory or file names? I told you that was a terrible idea. Get rid of them. If that doesn't fix it, I also highly recommend you have a [more powerful Git(Hub) client](git02_git-clients.html) installed for these situations.

Go back to the [index for the all the Git stuff](git00_index.html).
