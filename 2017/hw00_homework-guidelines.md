---
title: General Homework Guidelines
output:
  html_document:
    toc: true
    toc_depth: 4
---

### GitHub pre-requisites

We assume the following

  * You can [pull from and push to GitHub from RStudio](git07_git-github-rstudio.html) RStudio.
  * You've [taken possession of your STAT 545 private repository](git08_claim-stat545-repo.html).

### Have a decent `README.md`

In the [first homework](hw01_edit-README.html) you created a top-level `README.md` for your repository. Keep it in good shape! You are allowed to edit it!

### Authoring Markdown files

Throughout this course, any basic text document should be written in [Markdown](http://daringfireball.net/projects/markdown/basics) and should always have a filename that ends in `.md`. These files are pleasant to write and read, but are also easily converted into HTML and other output formats. GitHub provides an attractive HTML-like preview for Markdown documents. RStudio's "Preview HTML" button will compile the open document to actual HTML and open a preview.

Whenever you are editing Markdown documents in RStudio, you can access a Markdown Quick Reference from the *Help* menu.

### Authoring R Markdown files

If your document is describing a data analysis, author it in [R Markdown](http://rmarkdown.rstudio.com), which is like Markdown, but with the addition of R "code chunks" that are runnable. The filename should end in `.Rmd` or `.rmd`. RStudio's "Knit HTML" button will compile the open document to actual HTML and open a preview.

You can access an R Markdown cheatsheet from *Help > Cheatsheets* or visit RStudio's [R Markdown website](http://rmarkdown.rstudio.com).

Here is our introductory [tutorial on rendering R Markdown](block007_first-use-rmarkdown.html).

  * Default to the `github_document` output format.
  * If you have a compelling reason to render to html, make sure to keep, commit, and push the intermediate `.md` file.
  * In both cases, commit and push any figures.
  * Expose your code, i.e. use chunk option `echo = FALSE` very sparingly.

### Organization of your coursework repository

As the course goes on, you will accumulate many files in your repository. In due course, we will discuss the of use sub-directories to organize things.

BTW we truly mean [directories or "folders"](http://en.wikipedia.org/wiki/Directory_(computing)) -- NOT a [Git branch](http://git-scm.com/book/en/Git-Branching) or anything fancy like that!

You have a top-level `README.md` for your repository. Once you create sub-directories, you may also want to have a `README.md` file in each sub-directory to serve as a landing pages for, e.g., a homework assignment or a data directory.

As you get more advanced, here is more advice about [making your GitHub repo](http://happygitwithr.com/repo-browsability.html) very browsable.

### How to submit homework

  * Make sure you have
    - Saved all the files associated with your solution locally.
    - Committed all those files to your local Git repository.
    - Pushed the current state of your local repo to GitHub.
  * Open an issue, link to the latest commit, and tag the staff:
    - Visit your GitHub repo in a web browser.
    - Just above the file list, look for "latest commit" followed by ten numbers and letters (called the revision SHA) and a clipboard icon.
    - Click the clipboard icon to copy the revision SHA to your clipboard.
    - Click on "Issues", then on "New Issue". Name the issue "Mark homework x of *firstname-lastname*", where *x* is, 1, 2, ....
    - In the issue description, tag Jenny by including the text `@jennybc`, and paste the revision SHA. Include a link to exactly where you want a reviewer to go.
     - Click "Submit new issue". You're done! Congratulations!
  
### Make your work shine!

Here are some minor tweaks that can make a big difference in how awesome your product is.

#### Make it easy for people to access your work

Reduce the friction for TAs and profs to get the hard-working source code (the R markdown) __and__ the front-facing report (HTML).

  * Create a `README.md` in the homework's subdirectory to serve as the landing page for your submission. Whenever anyone visits this subdirectory of your repo, this will be automatically rendered nicely! In particular, hyperlinks will work.
  * With this `README.md` file, create annotated links to the documents TAs and profs will need to access. Such as:
    - Your main R markdown document.
    - The Markdown product that comes from knitting your main R markdown document. Remember GitHub will render this into pseudo-HTML automagically. Remember the figures in `figures/` need to be available in the repo in order appear here.

If you want to see an example of a `README.md` that links to and explains a bunch of files in the same repo + subdirectory, you can look at [this example](https://github.com/jennybc/STAT545A/tree/master/hw06_scaffolds/02_rAndMake) from STAT 545A 2013.

<!--
#### Linking to HTML files in the repo

Simply visiting an HTML file in a GitHub repo just shows ugly HTML source. You need to do a little extra work to see this rendered as a proper webpage.

  * Navigate to the HTML file on GitHub. Click on "Raw" to get the raw version; the URL should look something like this: `https://raw.github.com/stat540-2014-bryan-jennifer-hw/hw01/stat540-2014-bryan-jennifer-hw01.html`. Copy that URL!
  * Create a link to that in the usual Markdown way BUT prepend `http://htmlpreview.github.io/?` to the URL. So the URL in your link should look something like this: `http://htmlpreview.github.io/?https://raw.github.com/stat540-2014-bryan-jennifer-hw/hw01/stat540-2014-bryan-jennifer-hw01.html`. You can learn more about this preview facility [here](http://htmlpreview.github.io).
  * This sort of link would be fabulous to include in `README.md`.
-->

#### Make it easy for others to run your code

  * In exactly one, very early R chunk, load any necessary packages, so your dependencies are obvious.
  * In exactly one, very early R chunk, import anything coming from an external file. This will make it easy for someone to see which data files are required, edit to reflect their locals paths if necessary, etc. There are situations where you might not keep data in the repo itself.
  * Pretend you are someone else. Clone a fresh copy of your own repo from GitHub, fire up a new RStudio session and try to knit your R markdown file. Does it "just work"? It should!
  
#### Make pretty tables

Instead of just printing an object with R, you could format the info in an attractive table. Some leads:

  * The `kable()` function from `knitr`.
  * Also look into the packages `xtable`, `pander`.
  * [Great flowchart](https://twitter.com/polesasunder/status/464132152347475968) from Andrew MacDonald [\@polesasunder](https://twitter.com/polesasunder)
