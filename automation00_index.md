---
title: Automating data analysis pipelines
output:
  html_document:
    toc: true
    toc_depth: 4
---

__TO DO__ Turn this into a proper introduction.

Running R scripts at arm's length vs. interactively.

Using `Make` to record which files are inputs vs. outputs and how to use scripts and commands to make the outputs from the inputs. 

The intersection of R and `Make`: running R code snippets, running an entire R script, and rendering an R Markdown document.

The intersection of RStudio and `Make`: running the most important `Make` rules from the Build tab.

Using `Make` in the shell.

### Overview

Check out the [slides](automation01_slides/slides.html)!

### Install Make

If you are running Mac OS or Linux, Make should already be installed. Skip to the next step.

If you are running Windows, see our [page on Windows installation](automation02_windows.html).
  
### Test drive Make and RStudio

Walk before you run! Prove that Make is actually installed and that is can be found and executed from the shell and from RStudio. There is also some set-up you may want to do in order to use RStudio to edit Makefiles

Do not go any further until you have had a successful [test drive of Make](automation03_make-test-drive.html).

### Tab gotcha

Make is rather picky and __requires that lines be indented with tabs and not spaces__. In the [test drive](automation03_make-test-drive.html) we explained how to globally ask RStudio to NOT replace tabs with spaces. Below in the hands-on activity, we explain how to incorporate this request into the settings for a specific RStudio Project.

Please pause here and take a moment for this to truly sink in. __When writing a Makefile, it is very important to indent with tabs.__

If you mess up, here's the type of error you might see:

```sh
Error: `makefile:2: *** missing separator. Stop.`
```

### Hands-on activity

Go to [this page](automation04_make-activity.html)

### Resources

links!