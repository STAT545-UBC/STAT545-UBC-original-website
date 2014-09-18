---
title: "Test drive R Markdown"
output:
  html_document:
    toc: yes
    toc_depth: 4
---

### Overview

This describes a hands-on activity where the goal is to author an R Markdown document and compile it to HTML. We discuss how to keep the intermediate Markdown file, the figures, and what to commit to Git and push to GitHub.

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

I am modelling "walk before you run" here. It is best, especially for novices, to increase complexity in small increments. We will test our system's ability to compile the ["hello world"](http://en.wikipedia.org/wiki/%22Hello,_world!%22_program) of R Markdown documents before we muddy the waters with our own, probably buggy, documents.

Do this: File > New File > R Markdown ...

  - Give it an informative title. This will appear in the document but does not necessarily have anything to do with the file's name. But the title and filename should be similar! The title is for human eyeballs, so it can contain spaces and punctuation. The filename is for humans and computers, so it should have similar words in it but no spaces and no punctuation.
  - Accept the default Author or edit if you wish.
  - Accept the default output format of HTML.
  - Click OK.
  
Save this document to a reasonable filename and location. The filename should end in `.rmd` or `.Rmd`. I highly recommend saving in the top-level of the directory that is also also a Git repository for your coursework and that is also an RStudio project and that is also current working directory.

Click on "Knit HTML" or do File > Knit. RStudio should display a preview of the resulting HTML. Also look at the file browser (which should be pointed at the directory where you saved the `.rmd` file). You should see the R Markdown document, i.e. `foo.rmd` AND the resulting HTML `foo.html`.

Congratulations, you've just made your first reproducible report with R Markdown.

### Step 3: Save the intermediate Markdown

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
       keep_md: TRUE  
   ---  
```

Save! Recompile via "Knit HTML" button.

Now revisit the file browser. In addition to `foo.rmd` and `foo.html`, you should now see `foo.md` and a directory `foo_files`, where any figures created by the document will live.

### Step 4: Swap out the "guts" of the document

Select everything but the YAML frontmatter and ... delete it!

Write a single English sentence.

Insert an empty R chunk, via the "Chunk" menu in upper right of source editor or with corresponding keyboard shortcut.

Insert 1 to 3 lines of functioning code that begin the task at hand. "Walk through" and run those lines using the "Run button" the corresponding keyboard shortcut. You MUST make sure your code actually works!

Satisfied? Save!

Now compile the whole document via "Knit HTML." Voilà!

### Step 5: Develop your report

In this incremental manner, develop your report. Add code to this chunk. Refine it. Add new chunks. Go crazy! But keep running the code "manually" to make sure it works. If it doesn't work with you sitting there babysitting it, I can guarantee you it will fail, in a more spectacular and cryptic way, once you run it at arms-length via "Knit HTML" or `rmarkdown::render()`. Clean out your workspace and restart R and re-run everything periodically, if things get weird. There are lots of chunk menu items and keyboard shortcuts to accelerate this workflow. Compile the whole document often to catch errors when they're easy to pinpoint and fix. Save often and commit everytime you reach a point that you'd like as a "fall back" position.

You'll develop your own mojo soon, but this should give you your first successful R Markdown experience.

### Step 6: Publish your report

Since we are pushing coursework to GitHub anyway, I focus on how that delivers decent web publishing for "free."

Markdown documents get special treatment on GitHub: when you visit one in a web browser, instead of seeing the raw Markdown, by default you see a preview of how it will look when compiled to proper HTML. This is why, in Step 3, we alter the YAML to request that the intermediate Markdown file be retained. If there are R chunks that make figures, `keep_md: yes` will also cause those figure files to be left behind in a sensibly named sub-directory. If you commit and push `foo.md` and everything inside `foo_files`, then anyone with permission to view your GitHub repo can see a decent-looking version of your report.

This is (sort of) another example of keeping things machine- and human-readable. By making `foo.rmd` available, others can see and run your __actual code__. By sharing `foo.md` and/or `foo.html`, others can casually browse your end product and decide if they even want to run your code.

HTML files, such as `foo.html`, are not immediately useful on GitHub (though your local versions are easily viewable). Visit one and you'll see the raw HTML. Yuck. But there is a way to get a preview: <http://htmlpreview.github.io>. Expect some pain with HTML files inside private repos. When it becomes vital to see proper HTML in its fully glory, it's time to use a more sophisticated web publishing strategy.