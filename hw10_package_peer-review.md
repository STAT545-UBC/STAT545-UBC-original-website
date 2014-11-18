---
title: "R package - Peer review instructions"
author: "Bernhard Konrad, Jennifer Bryan"
output:
  html_document:
  toc: true
---

When you install your peer's `gameday` package for review, it is possible that it will overwrite the installation of your own `gameday` package. In fact, this is the default. Note: only your *installed* package is at risk. The source of your `gameday` package lives on safely on your computer and on GitHub.

In this document we explain two possible solutions, so that your own version of `gameday` is available when you complete peer review.

> To quickly check whose version is currently installed, use `maintainer("gameday")`.

## Option A. Overwrite and re-install

In this option we temporarily overwrite our installed version of `gameday` with the version of our peer. This means that during the peer review we will not be able to load and run our version of `gameday`.

### Step 1. Backup

Let's make extra sure your `gameday` source package is safely stored locally and on GitHub.

+ Confirm where your source files are stored on your computer. Open the `gameday.RProj` file in the corresponding folder. Run `remove.packages("gameday")` to un-install your `gameday`, then *Build & Reload* to re-install. Make sure that your package still works (open the vignette, `?gday`, `?gameday`, `gday("canucks")`, etc.)
+ Upload your source files to GitHub. Commit every source file, even the ones that were created automatically. Push to GitHub. Then, run `remove.packages("gameday")` and recreate it with the following steps:
  - Clone your GitHub repository to a separate, temporary, folder: *File > New Project > Version Control > Git*, paste the *url* of your GitHub repo, and choose a temporary folder.
  - recreate your package with `devtools::test()`, `devtools::document()`, `devtools:build_vignettes()` and finally *Build & reload*.
  - Check that your version of `gameday` is restored (open the vignette, `?gday`, `?gameday`, `gday("canucks")`, etc.). If everything works as expected you can delete this new folder -- your source files are safe and complete on GitHub.

### Step 2. Install `gameday` from your peer

Now that you know that you can re-install your version of `gameday`, it's time to let your peer's version of `gameday` take over.

+ Use `devtools::install_github(...)` to install your peer's `gameday`. Then, run `library(gameday)` and `maintainer("gameday")` to load it and confirm it belongs to your peer.
+ Review `gameday`.

### Step 3. Re-install your version

Once you are done with the peer review, re-install your own version of `gameday`. To install from your local source, while working in your `gameday` Project, do "Build and Reload". Or install from GitHub via `devtools::install_github(...)`. Then check that your name appears when you run `maintainer("gameday")`.

## Option B. Install peer's work to different library

This more advanced option makes use of the fact that you can specify which library to install a new package to. Hence you can avoid overwriting your version of `gameday` by installing your peer's version to a different library.

### Step 1. Set up a new library

todo: @jennybc


### Step 2. Install `gameday` from your peer

todo: @jennybc

### Step 3. Remove peer's work after peer-review

todo: @jennybc

