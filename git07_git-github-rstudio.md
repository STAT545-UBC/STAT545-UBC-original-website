---
title: Test drive RStudio and GitHub
output:
  html_document:
    toc: true
    toc_depth: 4
---

**Do this once per new project.**

### Prerequisites

This is the big moment where we bring everything together. We assume the following: 

  * You've already [installed Git](git01_git-install.html) and (possibly) [a Git client](git02_git-clients.html).
  * You've already [registered a free GitHub account](cm001_course-intro-sw-install-account-signup.html#register-a-github-account).
  * You've already [introduced yourself to Git](git04_introduce-self-to-git.html)
  * You've confirmed that you can [push to / pull from GitHub from the command line](git05_github-connection.html)
  * You've already [installed R and RStudio](block000_r-rstudio-install.html).

### Step 1: Make a new repo on GitHub

Go to <https://github.com> and make sure you are logged in.

Click green "New repository" button. Or, if you are on your own profile page, click on "Repositories", then click the green "New" button.

Repository name: `myrepo` (or whatever you wish)  
Public  
YES Initialize this repository with a README

Click big green button "Create repository."

Copy the HTTPS clone URL. It's near the bottom of the right sidebar.

### Step 2: Clone the new GitHub repository to your computer via RStudio

In RStudio, start a new Project:

  * *File > New Project > Version Control > Git*. In the "repository URL" paste the URL of your new GitHub repository. It will be something like this `https://github.com/jennybc/myrepo.git`.
    - Do you NOT see an option to get the Project from Version Control? Go [here](git03_rstudio-meet-git.html) for tips on how to help RStudio find Git.

  * Take charge of -- or at least notice! -- the local directory for the Project. This will create a new sub-directory, which will be all of these things:
    - a directory on your computer
    - a Git repository, linked to a remote GitHub repository
    - an RStudio Project

This should download the `README.md` file that we created on GitHub in the previous step. Look in RStudio's file browser pane for the `README.md` file.

There's a big advantage to the "Github first, then RStudio" workflow: the remote GitHub repo is now the "upstream" remote for your local repo. This is a technical but important point about Git. The practical implication is that you are now set up to push and pull. No need to fanny around on the command line or in another Git client.

### Step 2 plan B: Connect a local RStudio project to a GitHub repo

This workflow is the reverse of the above and cannot be executed from within R/RStudio. But sometimes it's necessary.

  * Create a new RStudio project: *File > New Project > New Directory > Empty Project*.
  
  * Directory name: `myrepo` (or whatever you named the GitHub repo)
  
  * Take charge of -- or at least notice! -- the local directory where this Project will live.
  
  * YES click "Create a git repository".
  
    - Do you NOT have a checkbox to request a Git repository? Go [here](git03_rstudio-meet-git.html) for tips on how to help RStudio find Git.

  * Initiate the "upstream" or "tracking" relationship by adding a remote. Go to *Tools > Shell* and do this, substitute the HTTPS URL for **your GitHub repo**.

``` shell
git remote add origin https://github.com/jennybc/myrepo.git
```
  * Download all the files from the online GitHub repository (possibly just `README.md`, at this point).
  
``` shell
git pull origin master
```

  * Cement the tracking relationship between your GitHub repository and the local repo by pushing and setting the "upstream" remote:
  
``` shell
git push -u origin master
```

It is possible you will be challenged for username and password here, but that means you should read up on [caching your credentials](git06_credential-caching.html) so this stops happening.

### Step 3: Make local changes, save, commit

**Do this every time you finish a valuable chunk of work, probably many times a day.**

From RStudio, modify the `README.md` file, e.g., by adding the line "This is a line from RStudio". Save your changes.

Commit these changes to your local repo. How?

From RStudio:

  * Click the "Git" tab in upper right pane
  * Check "Staged" box for any files whose existence or modifications you want to commit.
    - To see more detail on what's changed in file since you last committed, click on "Diff" for a Git pop-up
  * If you're not already in the Git pop-up, click "Commit"
  * Type a message in "Commit message"
  * Click "Commit"

### Step 4: Push your local changes online to GitHub

**Do this a few times a day, but possibly less often than you commit.**

You have new work into your local Git repository, but the changes are not online yet.

This will seem counterintuitive, but first let's stop and pull from GitHub.

 Why? Establish this habit for the future! If you make changes to the repo in the browser or from another machine or (one day) a collaborator has pushed, you will be happier if you pull those changes in before you attempt to push.
  
Click the blue "Pull" button in the "Git" tab in RStudio. I doubt anything will happen, i.e. you'll get the message "Already up-to-date." This is just to establish a habit.

Click the green "Push" button to send you local changes to GitHub. You should see some message along these lines.

```sh
[master dc671f0] blah
 3 files changed, 22 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 myrepo.Rproj
```

### The end

Now just ... repeat. Do work somewhere. Commit it. Push it or pull it depending on where you did it, but get local and remote "synced up". Repeat.
