---
title: Tell RStudio where to find the Git executable
output:
  html_document:
    toc: true
    toc_depth: 4
---

**You only have to set this up once per machine.**


### Find Git


Obviously, RStudio can only act as a GUI front-end for Git if Git has been successfully installed (described elsewhere) and RStudio can find it.

A basic test for successful installation of Git is to simply type `git` at the shell command line. If you get a complaint about Git not being found it means installation was unsuccessful or that it is not being found, i.e. it is not on your `PATH`.

If Git appears to be installed, launch RStudio. Quit and re-launch RStudio if there's any doubt in your mind about whether you opened RStudio before or after installing Git.

From RStudio, go to *Tools > Global Options > Git* and make sure that the box *Git executable* points to ... the Git executable. It should read something like:
  
* `/usr/bin/git` (Mac, Linux)

* `C:/Program Files (x86)/Git/bin/git.exe` (Windows)

Here is a [screenshot](http://www.molecularecologist.com/wp-content/uploads/2013/11/Screenshot-2013-11-12-09.53.56-Copy1.png) of someone doing this on a Windows machine.

- __WARNING__: On Windows, do __NOT__ use `C:/Program Files (x86)/Git/cmd/git.exe`. The difference between the good and bad paths is `bin` vs. `cmd`.

If you are not sure where the Git exectuable lives, try this in a shell:
  
* `which git` (Mac, Linux)

* `where git` (most versions of Windows)

* `whereis git.exe` (some other versions of Windows)

__Restart__ RStudio if you made any changes. THIS IS VERY IMPORTANT. DO IT.


### Test the communication between RStudio and Git

We will create a new dummy "Project" and direct RStudio to put it under version control

  - Do `File > New Project...`. You should see a pop up [like this](http://www.rstudio.com/images/screenshots/rstudio-projects_new.png).
  - Select "New Directory: Start a project in a brand new working directory".
  - Select "Empty Project: Create a new project in an empty directory".
  - Create a new directory for this project anywhere you wish, perhaps with a name like `test`. You can delete this very soon.
  - If you see a checkbox "Create a git repository", that is a very good sign! Check it. **If you do not see this checkbox, Git was not successfully installed or RStudio  still does not find Git. Restart RStudio, if that doesn't work, reinstall Git and repeat these steps.**
  - After RStudio opens your test Project, the upper right pane should have a "Git" tab, typically along with "Environment", "History", etc. You can see an example [in this screenshot](http://www.rstudio.com/images/screenshots/rstudio-vcs.png).
  - If this has gone well, it looks like Git and RStudio are ready to work together! Feel free to quit RStudio and delete the `test` directory/Project.

If this has not gone well, here is another thing to try:

  - With your Project open, go to `Tools > Project Options...`. If available, click on "Git/SVN" and select "Git" in the Version control system dropdown menu. Answer "yes" to the "Confirm New Git Repository" pop up. Answer "yes" to the "Confirm Restart RStudio" pop up.

If none of this works, get help from us.