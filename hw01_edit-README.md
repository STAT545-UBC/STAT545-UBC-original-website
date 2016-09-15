---
title: "Homework 01: Edit README.md and Use R Markdown"
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview

Consult the [general homework guidelines](hw00_homework-guidelines.html), although much does not to apply to this simple assignment.

We assume you've been keeping up with our live class activities, which have included

  * verifying your R/RStudio/Git/GitHub setup
  * joining the STAT 545 Organization and claiming your private repo
  * successfully rendering R Markdown

Due by midnight Tuesday 2016-09-20, but I **highly recommend** you aim to submit before class. This assignment should go smoothly, but if the computer gods do not smile upon you, we should be able to straighten things out in class or office hours.

### Edit `README.md`

We created this repository for you but it is empty. When you first visit, you should see a screen like [this](img/screenshot-new-repo-with-readme.png). You need to edit your `README.md` file to welcome your visitors (you, STAT545 instructor/TAs, STAT545 peers).

If you are already familiar with GitHub, edit the `README.md` any way you wish.

If you are new to Git and GitHub, click on the `README` link in the area that looks like a file browser. Click on the pencil and make an edit. Then head down to "Commit changes". Enter a short *commit message*. Then click "Commit changes". This is how you can edit files in GitHub repository through the browser. If you are still mystified by Git(Hub), you can use this browser-based method to edit `README.md` until you get more comfortable with using Git locally and pushing to GitHub. __However, if at all possible__, we want you to pilot a more powerful workflow:

  - Pull from GitHub (just an empty precaution now, but will matter when you collaborate with others).
  - Make changes locally to local files -- RStudio is a great Markdown editor! Click Preview to see how it's going to look!
  - Save your changes.
  - Commit your changes to your repo.
  - Push the commit to GitHub.

Go [take possession of your STAT 545 private repository](git08_claim-stat545-repo.html) and have at it.

__At the very least__, change `README.md` to something like "This is the repository of Jenny Bryan," just to prove you have been there. Practice making a link, for example, to the [main STAT545 webpage](http://stat545.com).

Much better is to introduce yourself to the class; this page is private to STAT 545 but will be visible to all students and staff. Feel free to read up on Markdown and practice with some of the syntax. Put in a photo or a GIF!

Here's a [sample readme file](https://github.com/STAT545-UBC/STAT545-UBC.github.io/hw01_sample_readme.md) that you can use as reference and/or inspiration, and here is the [raw source](https://raw.githubusercontent.com/STAT545-UBC/STAT545-UBC.github.io/hw01_sample_readme.md). The *Help* menu in RStudio will bring up a Markdown Quick Reference at any time.

### Add R Markdown and Markdown for Gapminder exploration

This is optional. If you are really struggling, skip it for now. But try!

Polish and extend the R Markdown document started in class on Thursday September 15. Render it to the `github_document` output format. Commit both the `.Rmd` and `.md` files and push them to GitHub.

Give this a decent name, such as `hw01_gapminder.Rmd` (which will produce a companion file, `hw01_gapminder.md`).

### Report your process

**WE REALLY CARE ABOUT THIS! DON'T SKIP IT.**

Include a description of how you got the changes into `README.md` on GitHub.

  * Did you edit in the browser at github.com?
  * Did you pull, edit locally, save, commit, push to github.com?
  
How did it all work for the R Markdown document?

You're encouraged to reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc. Put this in your README. In a week or two, you can delete this bit.

### Submit the assignment

Follow instructions on [How to submit homework](hw00_homework-guidelines.html#how-to-submit-homework)

### Rubric

Check minus: `README.md` says equivalent of "This is the repository of Jenny Bryan". All work done via browser at github.com ... but that's just a guess, because student doesn't actually say how it was done. No attempt to submit an R Markdown document exploring the Gapminder data. The homework submission issue is not named correctly, doesn't include the SHA or tag Jenny or a link to the work to be reviewed.

Check: something in between. Student may have failed to render to the `github_document` output and commit/push the resulting `.md` file. The homework submission issue might not be perfect, but there was a good effort.

Check plus: `README.md` provides a proper introduction of student to the class. It also demonstrates experimentation with 4 or more aspects of the Markdown syntax. Examples: section headers, links, bold, italic, bullet points, image embed, etc. The student describes how they got the changes into `README.md`. Student has submitted a well-named R Markdown document with exploration of the Gapminder dataset and the rendered markdown file. Student offers a few reflections on their GitHub workflow and their experience with Markdown. The homework submission issue follows the naming convention, includes the SHA, Jenny is tagged, and there's a link to the rendered `.md` for the Gapminder exploration.
