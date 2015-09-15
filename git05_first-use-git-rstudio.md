---
title: Test drive RStudio and GitHub
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

### Step 0: Git and R/RStudio installation and GitHub account registration

We assume the following

  * You've already [installed Git](git01_git-install.html) and (probably) [a Git client](git02_git-clients.html).
  * You've already [registered a free GitHub account](cm001_course-intro-sw-install-account-signup.html#register-a-github-account).
  * You've already [introduced yourself to Git](git04_introduce-self-to-git.html)
  * You've already [installed R and RStudio](block000_r-rstudio-install.html).

### Step 1: [Tell RStudio where to find Git](git03_rstudio-meet-git.html)

### Step 2: Create a new repository on GitHub

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

### Step 3: Clone the new GitHub repository to your computer via RStudio

**Do this once per new project.** 

  * Go back to RStudio, and start a new Project: *File > New Project > Version Control > Git*. In the "repository URL" paste the URL of your new GitHub repository, e.g., `https://github.com/BernhardKonrad/helloGithub`.

  * Choose the directory in which you want to put your repository and click "Create Project". This will create a new sub-directory, which will be all of these things: a directory on your computer, a GitHub repository, and an RStudio Project.

This should download the `README.md` file that we created on GitHub in the previous step. Look in RStudio's file browser pane for the `README.md` file.

Awesome, you can now automatically download content from your (or any other public) GitHub repository!

### Step 3, plan B

If Step 3 does not work, here is something to try:

  * Create a new Rstudio project: *File > New Project > New Directory > Empty Project*.
  
  * Choose the directory in which you want to put your repository, check *"Create a git repository"* and click *"Create Project"*.

  * Go to *Tools > Shell* and type `git remote add origin https://github.com/BernhardKonrad/helloGithub` (substitute the URL for __your__ test repository). This command has no output. It just associates the repository (and RStudio Project) on your machine with the companion repository on GitHub.

  * Also in the shell, enter `git pull origin master`. This should download all files from the online GitHub repository.
  
Now try this in the shell:

  * `git push -u origin master`. Our goal here is to trigger a challenge for your GitHub username and password. After you provide, you should see *"Everything up-to-date"*.

Sometimes this initial usage from the command line is necessary, in order to elicit and remember your GitHub username and password. Best case scenario: you will now be able to pull and push from RStudio.

### Step 4: Make local changes, save then, and commit them

**Do this every time you finish a valuable chunk of work, probably many times a day.**

  * From RStudio, modify the `README.md` file, e.g., by adding the line "This is a line from RStudio". Save your changes.

  * Commit your change to your local repository. __Yes this is different from saving the file.__ Go to the Git tab in the the top right pane of RStudio. Click `Commit`.

  * This opens a new window, RStudio's Git client. Click the checkbox of the `README.md` file, write a commit message, and click `Commit`.
  
### Step 5: Push your local changes online to GitHub

**Do this a few times a day, but possibly less often than you commit.**

You have new work into your local Git repository, but the changes are not online yet.

*Note from the future: although you are not collaborating with anyone yet, that day is coming. Here is where you should get into the habit of pulling changes from GitHub before you attempt to push. This will save you some grief. Hit the blue "Pull" button.*

To push changes online, hit the green `Push` button. The three most likely outcomes:

  1. Your push is accepted and the online GitHub repository is updated. This means that RStudio is successfully using your GitHub username and password. You are done.

  2. RStudio asks for your GitHub username and password, then your push is accepted and the online GitHub repository is updated. Learn [how to make git remember your username and password](git06_credential-caching.html) to avoid having to type those every time.

  3. RStudio does not ask for your username and password, but it is not sending them. The push fails and the online GitHub repository is not updated. This is a bug in RStudio and not your fault. Follow the work-around in step 5, plan B, and/or learn [how to make git remember your username and password](git06_credential-caching.html).

### Step 5, plan B

If the push in step 5 does not work, here is something to try:

  * Open the shell: *Tools > Shell*.

  * Enter `git push -u origin master`.

This will certainly ask for your username and password, and update the GitHub repository online. Then, learn [how to make git remember your username and password](git06_credential-caching.html) to save you from authenticating every time and so that you can push from RStudio directly.