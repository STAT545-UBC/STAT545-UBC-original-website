---
title: Test drive RStudio and Github
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

This describes a hands-on activity where the goal is make sure all the software installation and account configuration is done. We will do a bit of Git work, but the Big Picture, i.e. Why are we doing this?, is covered elsewhere. This is really just a test.

### Step 0: Git installation and GitHub account registration

We assume the following

  * You've already [installed Git and (probably) a Git client](block001_git-install.html).
  * You've already [registered a free GitHub account](cm001_course-intro-sw-install-account-signup.html#register-a-github-account).
  * You've already [installed R and RStudio](block000_r-rstudio-install.html).

### Step 1: Check that RStudio knows where to find the Git executable

**You only have to set this up once per machine.**

From RStudio, go to *Tools > Global Options > Git* and make sure that the box *Git executable* points to ... the Git executable. It should read something like:

  * `/usr/bin/git` (Mac, Linux)

  * `C:/Program Files (x86)/Git/bin/git.exe` (Windows)

    - __WARNING__: On Windows, do __NOT__ use `C:/Program Files (x86)/Git/cmd/git.exe`. The difference between the good and bad paths is `bin` vs. `cmd`.

If you are not sure where the Git exectuable lives, try this in a shell:

  * `which git` (Mac, Linux)
  
  * `where git` (?some? versions of Windows)
  
__Restart__ RStudio if you made any changes. THIS IS VERY IMPORTANT. DO IT.

### Step 2: Introduce yourself to `git`

**You only have to set this up once per machine.**

From RStudio, go to *Tools > Shell* and tell `git` your name and **GitHub email** by typing (use your own name and email):

  * `git config --global user.name 'Bernhard Konrad'`
  
    - This does __NOT__ have to be your GitHub username, although it can be. Another good option is your actual first name and last name. Your commits will be labelled with this name, so this should be informative to potential collaborators.

  * `git config --global user.email 'bernhard.konrad@gmail.com'`
  
    - This __must__ be the email that you used to sign up for GitHub.

These commands return nothing. You can check that `git` understood what you typed by looking at the output of `git config --global --list`.

### Step 3: Create a new repository on GitHub

**Do this once per new project.** Here we just create a disposable test repository, so don't worry too much about the name.

Log on to [GitHub](https://github.com), go to your personal page (click your name on the top right), choose "Repositories" and click the green "New" button. On this page

  * Choose a repository name, e.g., `helloGithub`.

  * Add a short description, e.g., "a test repository".

  * Choose *public* for this test.

  * __Check the box__ "Initialize this repository with a README".

  * Click the green "Create repository" button.

This brings you to your new repository. See the file `README.md` with the name and description of your repository.

If this does not work, please make sure you have registered a GitHub account and you are logged in.

Before you leave this page, copy the URL of your repo to the clipboard. In the right sidebar, below settings, you should see something like [this](https://github-images.s3.amazonaws.com/help/repository/https-url-clone.png), where you can click on the clipboard icon.

### Step 4: Clone the new GitHub repository to your computer via RStudio

**Do this once per new project.** 

  * Go back to RStudio, and start a new Project: File > New Project > Version Control > Git. In the "repository URL" paste the URL of your new Github repository, e.g., `https://github.com/BernhardKonrad/helloGithub`.

  * Choose the directory in which you want to put your repository and click "Create Project".

This will create a new directory and download the `README.md` file that we created on GitHub in the previous step. Look in RStudio's file browser pane for the `README.md` file.

Awesome, you can now automatically download content from your (or any other public) GitHub repository!

### Step 4, plan B

If this Step 4 does not work, here is something to try:

  * Create a new Rstudio project: File > New Project > New Directory > Empty Project.
  
  * Choose the directory in which you want to put your repository, check "Create a git repository," and click "Create Project".

  * Go to *Tools > Shell* and type `git remote add origin https://github.com/BernhardKonrad/helloGithub` (substitute the URL for __your__ test repository). This command has no output. It just associates the repository (and RStudio Project) on your machine with the companion repository on GitHub.

  * Also in the shell, enter `git pull origin master`. This should download all files from the online GitHub repository.
  
Now try this in the shell:

  * `git push -u origin master`. Our goal here is to trigger a challenge for your GitHub username and password. After you provide, you should see "Everything up-to-date".

Sometimes this initial usage from the command line is necessary, in order to elicit and remember your GitHub username and password. Best case scenario: you will now be able to pull and push from RStudio.

### Step 5: Make local changes, save then, and commit them

**Do this every time you finish a valuable chunk of work, probably many times a day.**

  * From RStudio, modify the `README.md` file, e.g., by adding the line "This is a line from RStudio". Save your changes.

  * Commit your change to your local repository. __Yes this is different from saving the file.__ Go to the Git tab in the the top right pane of RStudio. Click "Commit".

  * This opens a new window, RStudio's Git client. Click the checkbox of the "README.md" file, write a commit message, and click "commit".
  
### Step 6: Push your local changes online to GitHub

**Do this a few times a day, but possibly less often than you commit.**

You have new work into your local Git repository, but the changes are not online yet.

*Note from the future: although you are not collaborating with anyone yet, that day is coming. Here is where you should get into the habit of pulling changes from GitHub before you attempt to push. This will save you some grief.*

To push changes online, hit the green "Push"" button. The three most likely outcomes:

  1. Your push is accepted and the online GitHub repository is updated. This means that RStudio is successfully using your GitHub username and password. Skip to step 7.

  2. RStudio asks for your GitHub username and password, then your push is accepted and the online GitHub repository is updated. Skip to step 7 to avoid having to type username and password every time.

  3. RStudio does not ask for your username and password, but it is not sending them. The push fails and the online Github repository is not updated. This is a bug in RStudio and not your fault. Follow the work-around in step 6, plan B, and/or go to step 7 on how to avoid having to give RStudio your username and password manually.

### Step 6, plan B

If the push in step 6 does not work, here is something to try:

  * Open the shell: Tools > Shell.

  * Enter `git push -u origin master`.

This will certainly ask for your username and password, and update the GitHub repository online.

### Step 7: Automatic GitHub authentication

**You only have to set this up once every couple of months or once per computer.**

You will know you have truly succeeded once you have at least one successful push to GitHub in which you are NOT challenged for your user name and password. 

#### Linux

  * In the shell (Tools > Shell), enter `git --version` and verify that you have 1.7.10 or newer. If you don't, update Git.
  
  * In the shell, enter `git config --global credential.helper 'cache --timeout=10000000'` to store your password for ten million seconds (that's 16 weeks, enough for a full term).
  
  * In the shell, enter `git push -u origin master`. One last time you will be asked for your username and password.
  
  * Enter `git push -u origin master` again. You should not be asked for your username and password, instead you should see "Everything up-to-date".
  
  * Rejoice and close the shell. From now on your "Push" button will just work.

#### Mac

  * In the shell (Tools > Shell), enter `git --version` and verify that you have 1.7.10 or newer. If you don't, update Git.
  
  * In the shell, enter `git credential-osxkeychain`. If you do **not** get `Usage: git credential-osxkeychain <get|store|erase>`, follow steps 2 and 3 on [the github help](https://help.github.com/articles/caching-your-github-password-in-git#platform-mac).
  
  * In the shell, enter `git config --global credential.helper 'osxkeychain --timeout=10000000'` to store your password for ten million seconds (that's 16 weeks, enough for a full term).
  
  * In the shell, enter `git push -u origin master`. One last time you will be asked for your username and password.
  
  * Type `git push -u origin master` again. You should not be asked for your username and password, instead you should see "Everything up-to-date".
  
  * Rejoice and close the shell. From now on your "push" button will just work.

#### Windows

  * Install and setup a credential helper, following [these steps](http://stat545-ubc.github.io/block003_git-config-credential-cache.html#password-caching-on-windows).
  
  * In the shell (Tools > Shell), type `git push -u origin master`. One last time you will be asked for your username and password.
  
  * Enter `git push -u origin master` again. You should not be asked for your username and password, instead you should see "Everything up-to-date".
  
  * Rejoice and close the shell. From now on your "push" button will just work.
