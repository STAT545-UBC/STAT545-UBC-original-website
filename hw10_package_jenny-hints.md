---
title: "Help on the package homework"
output:
  html_document:
    toc: true
    toc_depth: 3
---

I (Jenny) piloted the main bits of [HW10 Building your own R package](hw10_package.html). This might help you figure out how best to spend your first hour on this homework.

### Get to the starting line

  * New repo on GitHub named `gameday`. Public. NO THANKS re: README, .gitignore, license.
    - <https://github.com/jennybc/gameday>
    - Look at the commit history to watch my pilot study unfold.
  * Copy the https URL to clipboard.
  * RStudio *File > New Project ... > Version Control > Git*. Paste the URL ... *Create Project*.
  * Stage and commit `.gitignore` and `gameday.Rproj`. Push.
  * Refresh view of `gameday` repo on GitHub. Do `.gitignore` and `gameday.Rproj` appear? YES, basic local <--> remote repo stuff set up. Yay.
  * Visit Bernhard's `gameday` on GitHub and get it.
    - <https://github.com/BernhardKonrad/gameday>
    - Click on "Download ZIP" button. For me, this gets automatically un-gzipped and un-tarred when the download completes.
    - `gameday-master` directory now exists in `~/Downloads`.
  * Copy everything from `gameday-master` (Bernhard's stuff) into my local `gameday` (my stuff).
  * In RStudio, use the Git diff view to make sure things look reasonable. `.gitignore` and `gameday.Rproj` are modified. Lots of other files are brand new. Stage it all and commit. Push.
  * Restart RStudio in my `gameday` Project, so RStudio provides package building help, i.e. the Build tab with access to package-y stuff.
  * Test, document, and check the package. Everything OK? No, I had to change DESCRIPTION so that package depends on R 3.1.1 or later, which I'm running. Check again Everything OK? YES, I'm convinced I've got a working package. Yay. Stage DESCRIPTION, commit, push.
  * Build & Reload. Use `gday()` myself in the Console. Yes, it works.

### Skip almost to the finish line

I'm pretty sure I'll be able to do the micro-exercises, at least as time allows. But all of that work will be wasted if, when time to submit, I don't have a vignette, my package doesn't install from GitHub, and/or my `README` is crap. I'm going to make sure that stuff is set up and working before I loop back to the fiddly stuff.

I edited the vignette in `vignettes/overview.Rmd` then did

```r
library(devtools)
build_vignettes()
## Build and Reload via RStudio here!
library(gameday)
browseVignettes("gameday")
```

I confirmed my edited vignette was rendered and served up to me. Vignette stuff working. Yay. Stage, commit, push.

Let me confirm my currently installed version of `gameday` is Bernhard's:

```r
maintainer("gameday")
```

Yep, it reports Bernhard. That's because I haven't edited DESCRIPTION yet, but there's a reason for that.

De-install `gameday` and confirm it's truly gone from my libraries:

```r
remove.packages("gameday")
## Restart R session
library("gameday")
## Error in library("gameday") : there is no package called ‘gameday’
```

__On GitHub__, in the browser, edit `DESCRIPTION` to make me the maintainer.

Re-install __from GitHub__:

```r
library(devtools)
install_github("jennybc/gameday")
## all should go well
maintainer("gameday")
## [1] "\"Jennifer Bryan\" <jenny@stat.ubc.ca>"
```

YES I can install from GitHub. I know it worked because I did not get an error message and the maintainer is now me, which proves I'm running the GitHub version of `gameday`. Yay. __Pull from GitHub__ to get `DESCRIPTION`.

Finally, add basic install and run instructions to `README.md`:

```r
library(devtools)
install_github("jennybc/gameday")
gday("canucks")
```

Stage, commit, push. Check `README` looks OK on GitHub. Yay.

This took me about 45 minutes. Now, and only now, would I start knocking off the homework tasks. I would be scrupulous to document, test, and check often to make sure I don't lose the precious quality my package has right now: it works.
