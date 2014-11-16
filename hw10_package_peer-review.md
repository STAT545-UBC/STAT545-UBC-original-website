---
title: "R package - Peer review instructions"
author: "Bernhard Konrad, Jennifer Bryan"
output:
  html_document:
  toc: true
---

When you install your peer's package for your review, it is possible that their implementation may overwrite your version. In fact, this is the default behavior if you both implemented your version of `gameday`. In this document we explain two possible solutions to this, so that you are able to recover your version of `gameday` when you're done with your review.

> To quickly check whose version is currently installed, use `maintainer("gameday")`.

# Option A. Overwrite and re-install

In this option we temporarily overwrite our version of `gameday` with the version of our peer. This means that during the peer review we will not be able to access any functions or documentation of our version of `gameday`, we always see those of our peer.

## Step 1. Backup

Luckily, installing another version of `gameday` will not overwrite your source files (the files that you wrote and compiled to create your version of `gameday`). As long as you keep the source uou will always be able to quickly recover your package `gameday`. To be extra save, let's add two layers of security, a local version on your computer, and a version on GitHub:

+ Know where your source files are stored on your computer. Open the *gameday.RProj* file in the corresponding folder. Run `remove.packages("gameday")`, then *Build & Reload* and make sure that your package still works (open the vignette, `?gday`, `?gameday`, `gday("canucks")`, etc.)
+ Upload your source files to GitHub. Commit every source file, even the ones that were created automatically. Then, run `remove.packages("gameday")` and recreate it with the following steps:
  - Clone your GitHub repository to a separate, temporary, folder: *File -> New Project -> Version Control -> Git*, paste the *url* of your GitHub repo, and choose a temporary folder.
  - recreate your package with `devtools::test()`, `devtools::document()`, `devtools:build_vignettes()` and finally *Build & reload*.
  - Check that your version of `gameday` is restored (open the vignette, `?gday`, `?gameday`, `gday("canucks")`, etc.). If everything works as expected you can delete this new folder -- your source files are save and complete on GitHub.


## Step 2. Install `gameday` from your peer

Now that you know that you can always recreate your version of `gameday`, it's time to let go of your version for the time being so that you can review your peer's version.

+ Use `devtools::install_github(...)` to install the `gameday` version that you are going to review. Then, run maintainer("gameday"). This should now be the name of your peer.
+ Review `gameday`.

## Step 3. Re-install your version

Once you are *completely* done with the peer review and submitted your marks and comments you want to re-compile your own version of `gameday`. To do this, simply run `devtools::install_github(...)` with the path to your version. Then check that your name appears when you run `maintainer("gameday")`.


# Option B. Install peer's work to different library

This more advanced option makes use of the fact that you can specify which library to install a new package to. Hence you can avoid overwriting your version of `gameday` by installing your peer's version to a different library

## Step 1. Set up a new library

todo: @jennybc


## Step 2. Install `gameday` from your peer

todo: @jennybc

## Step 3. Remove peer's work after peer-review

todo: @jennybc

