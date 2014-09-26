---
title: General Homework Guidelines
output:
  html_document:
    toc: true
    toc_depth: 4
---

### GitHub pre-requisites

We assume the following

  * You've already [installed Git](git01_git-install.html) and (probably) [a Git client](git02_git-clients.html).
  * You've already [registered a free GitHub account](cm001_course-intro-sw-install-account-signup.html#register-a-github-account). And provided your username to us.
  * You've confirmed that you can use command line Git and/or your Git client -- perhaps even RStudio! -- to [push, pull, etc. to/from GitHub](git06_credential-caching.html). Recall our [in-class hands on activity](git05_first-use-git-rstudio.html) where we tested all this.
  * You've logged in to [GitHub](https://github.com) ...
    - [switched over to the STAT545 Organization](https://help.github.com/articles/how-do-i-access-my-organization-account) ...
    - and confirmed that you can access a repository with your name on it. Example: a student named Jennifer Bryan should be able to access a repository named `zz_jennifer_bryan-coursework`.

This is the repository where you put your homework.

DO NOT PASS GO until all of the above is DONE.

### Have a decent `README.md`

In the [first homework](hw01_edit-README.html) you have created a top-level `README.md` for your repository. Keep it in good shape!

### Authoring Markdown files

Throughout this course, any basic text document should be written in [Markdown](http://daringfireball.net/projects/markdown/basics) and should always have a filename that ends in `.md`. These files are pleasant to write and read, but are also easily converted into HTML and other output formats. GitHub provides an attractive HTML-like preview for Markdown documents. RStudio's "Preview HTML" button will compile the open document to actual HTML and open a preview.

Whenever you are editing Markdown documents in RStudio, you can display a Markdown cheatsheet by clicking the question Mark `?` at the top of the editor pane.

### Authoring R Markdown files

If your document is describing a data analysis, author it in [R Markdown](http://rmarkdown.rstudio.com), which is like Markdown, but with the addition of R "code chunks" that are runnable. The filename should end in `.Rmd` or `.rmd`. RStudio's "Knit HTML" button will compile the open document to actual HTML and open a preview.

Whenever you are editing R Markdown documents in RStudio, click the question Mark `?` at the top of the editor pane to display a Markdown cheatsheet or visit RStudio's [R Markdown website](http://rmarkdown.rstudio.com).

Here is our introductory [tutorial on rendering R Markdown](block007_first-use-rmarkdown.html).

  * Make sure to keep, commit, push the intermediate `.md` file and any figures.
  * Expose your code, i.e. use chunk option `echo = FALSE` very sparingly.

### Organization of your coursework repository

As the course goes on, you will accumulate many files in your repository. In due course, we will offer guidelines on using sub-directories to organize things.

BTW we truly mean [directories or "folders"](http://en.wikipedia.org/wiki/Directory_(computing)) -- NOT a [Git branch](http://git-scm.com/book/en/Git-Branching) or anything fancy like that!

You have a top-level `README.md` for your repository. Once you create sub-directories, you may also want to have a `README.md` file in each sub-directory to serve as a landing pages for, e.g., a homework assignment or a data directory.

### Which files to commit 

  * Always commit the main source document, e.g., the R script or R Markdown or Markdown document. Commit early, commit often!
  * For R Markdown source, also commit the intermediate Markdown (`.md`) file and any accompaying files, such as figures.
    - Some purists would say intermediate and downstream products do NOT belong in the repo. After all, you can always recreate them from source, right? But here in reality, it turns out to be incredibly handy to have this in the repo.
  * Commit the end product HTML (`.html`) file.
    - See above comment re: version control purists vs. pragmatists.
  * You may not want to commit the Markdown and HTML until the work is fairly advanced, maybe even until submission. Once these enter the repo, you really should recompile them each time you commit changes to the R Markdown source, so that the Git history reflects the way these files should evolve as an ensemble.
  * __Never ever__ edit the intermediate/output documents "by hand". Only edit the source and then regenerate the downstream products from that.

### How to submit homework

  * Make sure you have
    - Saved all the files associated with your solution locally.
    - Commited all those files to your local Git repository.
    - Pushed the current state of your local repo to GitHub.
  * Open an issue, link to the latest commit, and tag the staff:
    - Visit your GitHub repo in a web browser.
    - Just above the file list, look for "latest commit" followed by ten numbers and letters (called the revision SHA) and a clipboard icon.
    - Click the clipboard icon to copy the revision SHA to your clipboard.
    - Click on "Issues", then on "New Issue". Name the issue "Mark homework x of *firstname-lastname*", where *x* is, 1, 2, ....
    - In the issue description, tag the markers by including the text ` @STAT545-UBC/Markers`, and paste the revision SHA.
     - Click "Submit new issue". You're done! Congratulations!
  
### Make your work shine!

Here are some minor tweaks that can make a big difference in how awesome your product is.

#### Make it easy for people to access your work

Reduce the friction for TAs and profs to get the hard-working source code (the R markdown) __and__ the front-facing report (HTML).

  * Create a `README.md` in the homework's subdirectory to serve as the landing page for your submission. Whenever anyone visits this subdirectory of your repo, this will be automatically rendered nicely! In particular, hyperlinks will work.
  * With this `README.md` file, create annotated links to the documents TAs and profs will need to access. Such as:
    - Your main R markdown document.
    - The intermediate Markdown product that comes from knitting your main R markdown document. Remember GitHub will render this into pseudo-HTML automagically. Remember the figures in `figures/` need to be available in the repo in order appear here.
    - The final pretty HTML report. Read instructions below on how access the pretty, not the ugly source.
    
> You could link to an HTML report on RPubs, but a GitHub-only solution is preferred. RPubs isn't really necessary once your work is hosted on GitHub. Plus it's kinda nice to keep this private.

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
  