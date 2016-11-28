---
title: "Help on the package homework"
output:
  html_document:
    toc: true 
    toc_depth: 2
---

Here is how to

  * Get started on the package homework
  * Install your peer's package for review

If you don't need help with either of these, then carry on.

## Get to the starting line

Here's how I would start the [homework on making an R package](hw09_package.html). Basically you want to get the fiddliest moving parts working early and then keep it that way. In this case, I assume that means obtaining the `foofactors` package I have left for you to extend and making sure you can develop your own copy and push it back up to GitHub.

Option #1: Obtain `foofactors`as a ZIP archive

  * In browser, create new repo on GitHub named `foofactors`. Public. NO THANKS re: README, .gitignore, license.
  * Copy the https URL to clipboard.
  * RStudio *File > New Project ... > Version Control > Git*. Paste the URL ... *Create Project*.
  * Stage and commit `.gitignore` and `foofactors.Rproj`. Push.
  * Refresh view of `foofactors` repo on GitHub. Do `.gitignore` and `foofactors.Rproj` appear? YES, basic local <--> remote repo stuff set up. Yay. 
  * Visit my version of `foofactors` on GitHub and get it.
    - <https://github.com/jennybc/foofactors>
    - Click on "Download ZIP" button. For me, this gets automatically un-gzipped and un-tarred when the download completes. YMMV.
    - `foofactors-master` directory now exists in `~/Downloads`.
  * Copy everything from `foofactors-master` (our stuff) into local `foofactors` (your stuff).
  * In RStudio, use the Git diff view to make sure things look reasonable. `.gitignore` and `foofactors.Rproj` are modified. Lots of other files are brand new. Stage it all and commit. Push.
  * Restart RStudio in your `foofactors` Project, so RStudio provides package building help, i.e. the Build tab with access to package-y stuff.
  * Test, document, and check the package. Everything OK? Read the errors and deal with them. Check again. OK? Yay. Stage any changes that were necessary, commit, push.
  * Build & Reload. Use `fbind()` in the Console. Yes, it works.

Option #2: Fork `foofactors` and get your copy the Git way

  * Visit my `foofactors` in the browser:
    - <https://github.com/jennybc/foofactors>
  * Click "Fork".
  * You should arrive in a new repo **under your own account** that is clearly indicated to be a fork of `jennybc/foofactors`.
  * Copy the https URL of your fork to clipboard.
  * RStudio *File > New Project ... > Version Control > Git*. Paste the URL ... *Create Project*.
  * Test, document, and check the package. Everything OK? Read the errors and deal with them. Check again. OK? Yay. Stage any changes that were necessary, commit, push.
  * Build & Reload. Use `fbind()` in the Console. Yes, it works.

Now you are ready to start modifying the package. Keep checking, committing, and pushing often.

## Install your peer's package

If you barrel ahead and install your peer's `foofactors` package for review, it will likely overwrite the installation of your own `foofactors` package. Note: only your *installed* package is at risk. The *source* of your `foofactors` package lives on safely on your computer and on GitHub. And you could re-install from either source.

If you want to be more careful, here are two approaches to take more control of the situation.

### Option A. Install peer's work to different library

In this option we install the peer's version of `foofactors` to a non-default library, leaving the installation of your own version intact.

First, restart your R session. Specifically, we don't want *your* `foofactors` package to be loaded before we start this. To confirm this is true, enter `search()` and make sure you don't see `foofactors` listed in the result.

### Step 1. Create a temporary library

This is nothing more than creating a new directory on your computer. It's where you'll install and load your peer's package from. Then we'll delete it. I'm putting in my all purpose temp directory, but you can pick another location.

        tmp_lib <- "~/tmp/tmp_lib"
        dir.create(tmp_lib)

Navigate to this directory in some file browser or shell and confirm the directory exists.

### Step 2. Install `foofactors` from your peer

Install your peer's `foofactors` package from GitHub into your temporary library. Below, `devtools::with_lib()` prepends your usual list of libraries with `tmp_lib`. Don't worry about the deprecation warning on `with_lib()`. I'm also opting to build your peer's vignettes, which may cause some suggested packages to be installed. Load your peer's package from `tmp_lib` and confirm you're using the right version via `maintainer()`.

        library(devtools)
        with_lib(tmp_lib,
                 install_github("rebjoh/foofactors",
                                build_vignettes = TRUE))
        library(foofactors, lib.loc = tmp_lib)
        maintainer("foofactors")

Use the peer's package and submit your review.

### Step 3. Remove peer's work after peer-review

Delete your temporary library any way you want. Restart your R session to clean out your loaded packages and rest assured that plain ol' `library(foofactors)` will now load *your* version. Use `maintainer()` to check if you are worried. Here's an R command to get rid of the temporary library.

        unlink(tmp_lib, recursive = TRUE)

### Option B. Overwrite and re-install

In this option you temporarily overwrite your installed version of `foofactors` with the version of your peer. This means that during the peer review you will not be able to load and run your version of `foofactors`.

#### Step 1. Backup

Let's make extra sure your `foofactors` source package is safely stored locally and on GitHub.

  * Is your package in working order, with everything saved and committed and pushed to GitHub? Do it now!
  * Launch RStudio in the Project corresponding to your `foofactors` package.
  * De-install `foofactors` and confirm it's truly gone from your library:

        remove.packages("foofactors")
        ## Restart R session
        library("foofactors")
        ## Error in library("foofactors") : there is no package called ‘foofactors’

  * Re-install `foofactors` and confirm it's back in your library. Use RStudio's "Build & Reload" then call `fbind()`, get help `?fbind`, browse the vignette, etc.
  * De-install `foofactors` again (see above).
  * Re-install `foofactors` __from GitHub__ this time.

        library(devtools)
        install_github("YOURGITHUBUSERNAME/foofactors",
                       build_vignettes = TRUE)
        library("foofactors")

    Revisit spot checks from above that `foofactors` is back and in working order.

If everything works as expected, you can feel good that your package source is safely stored locally and on GitHub.

#### Step 2. Install `foofactors` from your peer

Now that you know that you can re-install your version of `foofactors`, it's time to let your peer's version of `foofactors` take over.

  * Install your peer's `foofactors`, load it, check maintainer:

        library(devtools)
        install_github("YOURPEER/foofactors", build_vignettes = TRUE) 
        library(foofactors)
        maintainer("foofactors")
        ## USE IT

  * Review peer's version of `foofactors`.

### Step 3. Re-install your version

Once you are done with the peer review, restore your own version of `foofactors`.

  * To install from your local source, launch RStudio in your `foofactors` Project and do "Build and Reload".
  * Or install from GitHub

        devtools::install_github("YOURGITHUBUSERNAME/foofactors")

  * Either way, verify your version is now installed:

        maintainer("foofactors")
