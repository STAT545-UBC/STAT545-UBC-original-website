---
title: "R package - Peer review instructions"
output:
  html_document:
    toc: true
---

**NOTE: From 2014!!! Original number was hw10.**

If you barrel ahead and install your peer's `gameday` package for review, it will likely overwrite the installation of your own `gameday` package. Note: only your *installed* package is at risk. The *source* of your `gameday` package lives on safely on your computer and on GitHub. And you could re-install from either source.

If you want to be more careful, here are two approaches to take more control of the situation.

## Option A. Install peer's work to different library

In this option we install the peer's version of `gameday` to a non-default library, leaving the installation of our own version intact.

First, restart your R session. Specifically, we don't want *your* `gameday` package to be loaded before we start this. To confirm this is true, enter `search()` and make sure you don't see `gameday` listed in the result.

### Step 1. Create a temporary library

This is nothing more than creating a new directory on your computer. It's where you'll install and load your peer's package from. Then we'll delete it. I'm putting in my all purpose temp directory, but you can pick another location.

        tmp_lib <- "~/tmp/tmp_lib"
        dir.create(tmp_lib)

Navigate to this directory in some file browser and confirm the directory exists.

### Step 2. Install `gameday` from your peer

Install your peer's `gameday` package from GitHub into your temporary library. Below, `devtools::with_lib()` prepends your usual list of libraries with `tmp_lib`. Load your peer's package from there and confirm you're using the right version via `maintainer()`.

        library(devtools)
        with_lib(tmp_lib, install_github("rebjoh/gameday"))
        library(gameday, lib.loc = tmp_lib)
        maintainer("gameday")

Use the peer's package and submit your review.

### Step 3. Remove peer's work after peer-review

Delete your temporary library any way you want. Restart your R session to clean out your loaded packages and rest assured that plain ol' `library(gameday)` will now load *your* version. Use `maintainer()` to check if you are worried. Here's an R command to get rid of the temporary library.

        unlink(tmp_lib, recursive = TRUE)

## Option B. Overwrite and re-install

In this option we temporarily overwrite our installed version of `gameday` with the version of our peer. This means that during the peer review we will not be able to load and run our version of `gameday`.

### Step 1. Backup

Let's make extra sure your `gameday` source package is safely stored locally and on GitHub.

  * Is your package in working order, with everything saved and committed and pushed to GitHub? Do it now!
  * Launch RStudio in the Project corresponding to your `gameday` package.
  * De-install `gameday` and confirm it's truly gone from your library:

        remove.packages("gameday")
        ## Restart R session
        library("gameday")
        ## Error in library("gameday") : there is no package called ‘gameday’
  * Re-install `gameday` and confirm it's back in your library. Use RStudio's "Build & Reload" then call `gday()`, get help `?gameday`, browse the vignette, etc.
  * De-install `gameday` again (see above).
  * Re-install `gameday` __from GitHub__ this time.

        library(devtools)
        install_github("YOURGITHUBUSERNAME/gameday")
        library("gameday")
    Revisit spot checks from above that `gameday` is back and in working order.

If everything works as expected, you can feel good that your package source is safely stored locally and on GitHub.

### Step 2. Install `gameday` from your peer

Now that you know that you can re-install your version of `gameday`, it's time to let your peer's version of `gameday` take over.

  * Install your peer's `gameday`, load it, check maintainer:

        devtools::install_github(YOURPEER/gameday)
        library(gameday)
        maintainer("gameday")
        ## USE IT

  * Review peer's version of `gameday`.

### Step 3. Re-install your version

Once you are done with the peer review, restore your own version of `gameday`.

  * To install from your local source, launch RStudio in your `gameday` Project and do "Build and Reload".
  * Or install from GitHub
  
        devtools::install_github("YOURGITHUBUSERNAME/gameday")
        
  * Either way, verify your version is now installed:
  
        maintainer("gameday")


