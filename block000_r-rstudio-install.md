---
title: R and RStudio Set Up
output:
  html_document:
    toc: true
    toc_depth: 4
---

### R and RStudio

* Install [R, a free software environment for statistical computing and graphics](http://www.r-project.org) from [CRAN](http://cran.rstudio.com), the Comprehensive R Archive Network. It is __highly recommended__ to install a precompiled binary distribution for your operating system -- use the links up at the top of the CRAN page linked above!

* Install RStudio's IDE (stands for _integrated development environment_), a powerful user interface for R. Get the Open Source Edition of RStudio Desktop: <http://www.rstudio.com/products/rstudio/>
    - RStudio comes with a __text editor__, so there is no immediate need to install a separate stand-alone editor.
    - RStudio can __interface with Git(Hub)__. However, you must do all the Git(Hub) set up described elsewhere before you can take advantage of this.

### Testing testing

* Do whatever is appropriate for your OS to launch RStudio. You should get a window similar to the screenshot you see [here](http://www.rstudio.com/wp-content/uploads/2014/04/rstudio-workbench.png), but yours will be more boring because you haven't written any code or made any figures yet!

* Put your cursor in the pane labelled Console, which is where you interact with the live R process. Create a simple object with code like `x <- 2 * 4` (followed by enter or return). Then inspect the `x` object by typing `x` followed by enter or return. You should see the value 8 print to screen. If yes, you've succeeded in installing R and RStudio.

### Add-on packages

R is an extensible system and many people share useful code they have developed as a _package_ via CRAN and GitHub. To install a package from CRAN, for example the [`plyr`](http://plyr.had.co.nz)  package for data aggregation, here is one way to do it in the R console (there are others).

```
  install.packages("plyr", dependencies = TRUE)
```

By including `dependencies = TRUE`, we are being explicit and extra-careful to install any additional packages the target package, `plyr` in the example above, needs to have around.

You could use the above method to install the following packages, all of which we will use:

  * `plyr`, [package webpage](http://plyr.had.co.nz)
  * `knitr` [package webpage](http://yihui.name/knitr/)
  * `ggplot2` [package webpage](http://docs.ggplot2.org/)

### Communication between RStudio and Git

Obviously, RStudio can only act as a GUI front-end for Git if Git has been successfully installed (described elsewhere) and RStudio can find it.

A basic test for successful installation of Git is to simply type `git` at the shell command line. If you get a complaint about Git not being found it means installation was unsuccessful or that it is not being found, i.e. it is not on your `PATH`.

If Git appears to be installed, launch RStudio. Quit and re-launch RStudio if there's any doubt in your mind about whether you opened RStudio before or after installing Git.

We will create a new dummy "Project" and direct RStudio to put it under version control

  - Do `File > New Project...`. You should see a pop up [like this](http://www.rstudio.com/images/screenshots/rstudio-projects_new.png).
  - Select "New Directory: Start a project in a brand new working directory".
  - Select "Empty Project: Create a new project in an empty directory".
  - Create a new directory for this project anywhere you wish, perhaps with a name like `test`. You can delete this very soon.
  - If you see a checkbox "Create a git repository", that is a very good sign! Check it.
  - After RStudio opens your test Project, the upper right pane should have a "Git" tab, typically along with "Environment", "History", etc. You can see an example [in this screenshot](http://www.rstudio.com/images/screenshots/rstudio-vcs.png).
  - If this has gone well, it looks like Git and RStudio are ready to work together! Feel free to quit RStudio and delete the `test` directory/Project.

If this has not gone well, here is another thing to try:

  - With your Project open, go to `Tools > Project Options...`. If available, click on "Git/SVN" and select "Git" in the Version control system dropdown menu. Answer "yes" to the "Confirm New Git Repository" pop up. Answer "yes" to the "Confirm Restart RStudio" pop up.

If you're still reading, it may be necessary to explicitly tell RStudio where to find the Git executable.

  * Do `RStudio > Preferences` or, alternatively, do `Tools > Global Options...`.
  * Click on "Git/SVN".
  * Fill in the Git executable field correctly. Here is a [screenshot](http://www.molecularecologist.com/wp-content/uploads/2013/11/Screenshot-2013-11-12-09.53.56-Copy1.png) of someone doing this on a Windows machine.
  * If you think Git has been installed but you're not sure where it is, entering `which git` at the shell command line should reveal the path to the Git executable.
  
If none of this works, get help from us.

### Further resources

The above will get your basic setup ready but here are some links if you are interested in reading a bit further.

  * How to Use RStudio
    - <https://support.rstudio.com/hc/en-us/categories/200035113-Documentation>
  * RStudio Troubleshooting and FAQ
    - <https://support.rstudio.com/hc/en-us/categories/200031758-Knowledge-Base>
  * RStudio's leads for learning R
    - <https://support.rstudio.com/hc/en-us/articles/201141096-Getting-Started-with-R>
  * R Installation and Administration
    - <http://cran.r-project.org/doc/manuals/R-admin.html>
  * R FAQ:
    - <http://cran.r-project.org/doc/FAQ/R-FAQ.html>
  * More about add-on packages in the R Installation and Administration Manual
     - <http://cran.r-project.org/doc/manuals/R-admin.html#Add_002don-packages>
