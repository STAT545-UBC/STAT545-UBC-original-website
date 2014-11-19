---
title: "R package - Peer review instructions"
author: "Bernhard Konrad, Jennifer Bryan"
output:
  html_document:
  toc: true
---

When you install your peer's `gameday` package for review, it is possible that it will overwrite the installation of your own `gameday` package. In fact, this is the default. Note: only your *installed* package is at risk. The *source* of your `gameday` package lives on safely on your computer and on GitHub.

In this document we explain two possible solutions, so that your own version of `gameday` is available when you complete peer review.

*To quickly check whose version is currently installed, do this:*

```r
maintainer("gameday")
```

## Option A. Overwrite and re-install

In this option we temporarily overwrite our installed version of `gameday` with the version of our peer. This means that during the peer review we will not be able to load and run our version of `gameday`.

### Step 1. Backup

Let's make extra sure your `gameday` source package is safely stored locally and on GitHub.

  * Is everything saved and commited and pushed to GitHub? Do it now!
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

+ Use `devtools::install_github(YOURPEER/gameday)` to install your peer's `gameday`. Then, run `library(gameday)` and `maintainer("gameday")` to load it and confirm it belongs to your peer.
+ Review peer's version of `gameday`.

### Step 3. Re-install your version

Once you are done with the peer review, re-install your own version of `gameday`. To install from your local source, while working in your `gameday` Project, do "Build and Reload". Or install from GitHub via `devtools::install_github("YOURGITHUBUSERNAME/gameday")`. Then check that your name appears when you run `maintainer("gameday")`.

## Option B. Install peer's work to different library

This more advanced option makes use of the fact that you can specify which library to install a new package to. Hence you can avoid overwriting your version of `gameday` by installing your peer's version to a different library.

### Step 1. Set up a new library

todo: @jennybc


### Step 2. Install `gameday` from your peer

todo: @jennybc

### Step 3. Remove peer's work after peer-review

todo: @jennybc

