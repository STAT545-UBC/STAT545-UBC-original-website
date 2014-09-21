---
title: "Test drive R Markdown"
output:
  html_document:
    toc: yes
    toc_depth: 4
---

### Overview

This describes a hands-on activity where the goal is to author an R Markdown document and render it to HTML. We discuss how to keep the intermediate Markdown file, the figures, and what to commit to Git and push to GitHub.

Here is the official R Markdown documentation:

  * <http://rmarkdown.rstudio.com>

### Step 0: Software installation and configuration

We assume the following

  * You've already [installed Git and (probably) a Git client](block001_git-install.html).
  * You've already [registered a free GitHub account](cm001_course-intro-sw-install-account-signup.html#register-a-github-account).
  * You've already [installed R and RStudio](block000_r-rstudio-install.html).
  * You've [tested your installation and configuration of Git, GitHub, and RStudio](block005_first-use-git-rstudio.html)
  * You've completed [Homework 01](hw01_edit-README.html) or an equivalent exercise to truly test all of the above and to introduce you to Markdown.

### Step 1: Get ready to work

Launch RStudio, probably in the Project that corresponds to the repository where you are keeping all STAT 545 coursework. Make sure the workspace is clean and you've launched a fresh R process. Make sure the working directory is sensible.

### Step 2: Practice with RStudio's boilerplate R Markdown document

I am modelling "walk before you run" here. It is best, especially for novices, to increase complexity in small increments. We will test our system's ability to render the ["hello world"](http://en.wikipedia.org/wiki/%22Hello,_world!%22_program) of R Markdown documents before we muddy the waters with our own, probably buggy, documents.

Do this: File > New File > R Markdown ...

  - Give it an informative title. This will appear in the document but does not necessarily have anything to do with the file's name. But the title and filename should be similar! The title is for human eyeballs, so it can contain spaces and punctuation. The filename is for humans and computers, so it should have similar words in it but no spaces and no punctuation.
  - Accept the default Author or edit if you wish.
  - Accept the default output format of HTML.
  - Click OK.
  
Save this document to a reasonable filename and location. The filename should end in `.rmd` or `.Rmd`. I highly recommend saving in the top-level of the directory that is also also a Git repository for your coursework and that is also an RStudio project and that is also current working directory.

Click on "Knit HTML" or do File > Knit. RStudio should display a preview of the resulting HTML. Also look at the file browser (which should be pointed at the directory where you saved the `.rmd` file). You should see the R Markdown document, i.e. `foo.rmd` AND the resulting HTML `foo.html`.

Congratulations, you've just made your first reproducible report with R Markdown.

### Step 3: Save the intermediate Markdown

*This is directly related to eventual publishing on GitHub. If that does not apply to you, skip this step.*

It will have nice side effects on GitHub if we save the intermediate Markdown file that is produced when compiling to HTML. The magical process is like so: `foo.rmd --> foo.md --> foo.html`. By default RStudio discards `foo.md` but it's easy to request that it be kept. This is one of the many things we can control in the YAML frontmatter -- the text at the top of your file between leading and trailing lines of `---`. Two approaches:

  * RStudio GUI: click on the "gear" in the top bar of the source editor, near the "Knit HTML" button. Go to the Advanced tab and check "Keep markdown source file."
  
  * "By hand:" Make your YAML frontmatter look something like this:
  
```sh
   ---  
   title: "Something fascinating"  
   author: "Jenny Bryan"  
   date: "10 September, 2014"  
   output:  
     html_document:  
       keep_md: true  
   ---  
```

Save! Render via "Knit HTML" button.

Now revisit the file browser. In addition to `foo.rmd` and `foo.html`, you should now see `foo.md` and a directory `foo_files`, where any figures created by the document will live.

### Step 4: Swap out the "guts" of the document

Select everything but the YAML frontmatter and ... delete it!

Write a single English sentence.

Insert an empty R chunk, via the "Chunk" menu in upper right of source editor or with corresponding keyboard shortcut.

    ```{r}
    ## insert your brilliant WORKING code here
    ```

Insert 1 to 3 lines of functioning code that begin the task at hand. "Walk through" and run those lines using the "Run" button or the corresponding keyboard shortcut. You MUST make sure your code actually works!

Satisfied? Save!

Now render the whole document via "Knit HTML." Voilà!

### Step 5: Develop your report

In this incremental manner, develop your report. Add code to this chunk. Refine it. Add new chunks. Go crazy! But keep running the code "manually" to make sure it works. If it doesn't work with you babysitting it, I can guarantee you it will fail, in a more spectacular and cryptic way, when run at arms-length via "Knit HTML" or `rmarkdown::render()`. Clean out your workspace and restart R and re-run everything periodically, if things get weird. There are lots of chunk menu items and keyboard shortcuts to accelerate this workflow. Render the whole document often to catch errors when they're easy to pinpoint and fix. Save often and commit every time you reach a point that you'd like as a "fall back" position.

You'll develop your own mojo soon, but this should give you your first successful R Markdown experience.

### Step 6: Publish your report

Since we are pushing coursework to GitHub anyway, I focus on how that delivers decent web publishing for "free."

Markdown documents get special treatment on GitHub: when you visit one in a web browser, instead of seeing the raw Markdown, by default you see a preview of how it will look when rendered to proper HTML. This is why, in Step 3, we alter the YAML to request retention of the intermediate Markdown file. If there are R chunks that make figures, `keep_md: true` will also cause those figure files to be left behind in a sensibly named sub-directory. If you commit and push `foo.md` and everything inside `foo_files`, then anyone with permission to view your GitHub repo can see a decent-looking version of your report.

This is (sort of) another example of keeping things machine- and human-readable. By making `foo.rmd` available, others can see and run your __actual code__. By sharing `foo.md` and/or `foo.html`, others can casually browse your end product and decide if they even want to run your code.

HTML files, such as `foo.html`, are not immediately useful on GitHub (though your local versions are easily viewable). Visit one and you'll see the raw HTML. Yuck. But there is a way to get a preview: <http://htmlpreview.github.io>. Expect some token/authentication pain with HTML files inside private repos. When it becomes vital to see proper HTML in its full glory, it's time to use a more sophisticated web publishing strategy.

### Troubleshooting

__Make sure RStudio and the `rmarkdown` package (and its dependencies) are up-to-date.__ In case of catastrophic failure to render R Markdown, consider that your software may be too old. R Markdown has been developing rapidly (written 2014-09), so you need a very current version of RStudio and `rmarkdown` to enjoy all the goodies we describe here.

__Get rid of your `.Rprofile`__, at least temporarily. I have found that a "mature" `.Rprofile` that has accumulated haphazardly over the years can cause trouble. Specifically, if you've got anything in there relating to `knitr`, `markdown`, `rmarkdown` and RStudio stuff, it may be preventing the installation or usage of the most recent goodies (see above). Comment the whole file out or rename it something else and relaunch or reinstall RStudio.

__Insert a chunk in your `.rmd` document so that it renders even when there are errors.__ Some errors are easier to diagnose if you can execute specific R statements during rendering and leave more evidence behind for forensic examination. Put [this chunk](https://gist.github.com/jennybc/679ea117b61c9126034a):

<pre><code>```{r setup, include = FALSE, cache = FALSE}
knitr::opts_chunk$set(error = TRUE)
```</code></pre>

near the top of your R Markdown document if you want to soldier on through errors, i.e. turn `foo.rmd` into `foo.md` and/or `foo.html` no matter what. This is also helpful if you are writing a tutorial and want to demo code that throws an error.

__Check your working directory.__ It's going to break your heart as you learn how often your mistakes are really mundane and basic. Ask me how I know. When things go wrong consider:

  * What is the working directory?
  * Is that file I want to read/write actually where I think it is?
  
Drop these commands into R chunks to check the above: `getwd()` will display working directory at __run time__. If you monkeyed around with working directory with, e.g., the mouse, maybe it's set to one place for your interactive development and another when "Knit HTML" takes over. `list.files()` is also handy for brute force checking of which files are lying around within arm's reach.

[Don't try to change working directory within an R Markdown document](https://github.com/yihui/knitr/blob/master/FAQ.md). Just don't. And don't be in a hurry to create a complicated sub-directory structure. RStudio/`knitr`/`rmarkdown` (which bring you the "Knit HTML" button) are rather opinionated about the working directory being set to the `.rmd` file's location and about all files living together in one big happy directory. This can all be worked around. But not today.
