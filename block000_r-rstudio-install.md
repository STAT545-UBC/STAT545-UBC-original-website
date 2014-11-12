---
title: Installing R and RStudio
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
    
If you have a pre-existing installation of R and/or RStudio, we __highly recommend__ that you reinstall both and upgrade to the most recent version. It is very easy and RStudio, specifically, is changing rapidly and positively (written 2014-11). You may even wish to use the preview version of RStudio (we do!) [available here](http://www.rstudio.com/products/rstudio/download/preview/).

  * If you upgrade R, you will need to update any packages you have installed. The command below should get you started, though you may need to specify more arguments if, e.g., you have been using a non-default library for your packages.

```r
    update.packages(ask = FALSE, checkBuilt = TRUE)
```

  Note: this will only look for updates on CRAN. So if you use a package that lives *only* on GitHub or if you want a develoment version from GitHub, you will need to  update manually, e.g. via `devtools::install_github()`.

### Testing testing

* Do whatever is appropriate for your OS to launch RStudio. You should get a window similar to the screenshot you see [here](http://www.rstudio.com/wp-content/uploads/2014/04/rstudio-workbench.png), but yours will be more boring because you haven't written any code or made any figures yet!

* Put your cursor in the pane labelled Console, which is where you interact with the live R process. Create a simple object with code like `x <- 2 * 4` (followed by enter or return). Then inspect the `x` object by typing `x` followed by enter or return. You should see the value 8 print to screen. If yes, you've succeeded in installing R and RStudio.

### Add-on packages

R is an extensible system and many people share useful code they have developed as a _package_ via CRAN and GitHub. To install a package from CRAN, for example the [`plyr`](http://plyr.had.co.nz)  package for data aggregation, here is one way to do it in the R console (there are others).

```r
install.packages("plyr", dependencies = TRUE)
```

By including `dependencies = TRUE`, we are being explicit and extra-careful to install any additional packages the target package, `plyr` in the example above, needs to have around.

You could use the above method to install the following packages, all of which we will use:

  * `dplyr`, [package webpage](http://plyr.had.co.nz)
  * `ggplot2` [package webpage](http://docs.ggplot2.org/)

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
