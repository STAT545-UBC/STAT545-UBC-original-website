---
title: "Automating Data-analysis Pipelines"
author: "Shaun Jackman and Jenny Bryan"
date: "2014-11-03"
output:
  html_document:
    toc: true
    toc_depth: 3
    pandoc_args: "--preserve-tabs"
---

Jenny's proposed re-org and some insertions:

  * ~~dependency graph of the pipeline~~
  * ~~new RStudio project and Git repo~~
  * ~~rule to copy and/or download words.txt~~
  * R script to compute table of word lengths
  * rule to run word length script
  * ?create all and clean targets at this point and play with them?
  * R snippet to create visual histogram
  * rule to create histogram
  * update all and clean targets; use them
  * R Markdown file to generate a report
  * rule to render the Markdown file
  * update all and clean targets; use them

The goal of this activity is to create a pipeline that will

  + obtain a large file of English words
  + calculate a histogram of word lengths
  + determine the most common word length
  + generate a figure of this histogram
  + render a RMarkdown report in HTML and PDF

You will automate this pipeline using `make`!

### Dependency graph of the pipeline

<!-- TO DO: remake the figure to say words.txt not words.tsv -->

[![automation01_slides/images/activity.png](automation01_slides/images/activity.png)](automation01_slides/images/activity.gv)

### Set up a new RStudio Project (and Git repo)

In Rstudio: *File > New Project > New Directory > Empty Project.* If you're a Git user, we strongly encourage you to click on "Create a git repository."

This project will be useful as a reference in the future, so give it an informative name and location. If you're a GitHub user, you may want to push it there as well.

Git(Hub) users: from here on out, we assume you will be commiting at regular intervals. At key points, we explicitly prompt you to commit.

Configure this RStudio Project to work with `make`. Consult the [`make` test drive](automation03_make-test-drive.html) for details:

  * make sure tabs are NOT replaced with spaces
  * set Project Build Tools to `Makefile`

Git folks: commit now.

### Create the Makefile

In Rstudio: *File > New File > Text File.* Save it with the name `Makefile`. Keep adding the rules we write below to this file, saving regularly.

### Get the dictionary of words

Depending on your OS and mood, you can get the file of English words by copying a local file or downloading from the internet.

#### Download the dictionary

Our first `Makefile` rule will download the dictionary `words.txt`. The command of this rule is a one-line R script, so instead of putting the R script in a separate file, we'll include the command directly in the Makefile, since it's so short. *Sure, we could download a file without using R at all but humor us: this is a tutorial about `make` and R!*

```makefile
words.txt:
	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'
```

Suggested workflow:

  * Git folks: commit anything new/modified. Start with a clean working tree.
  * Submit the above `download.file()` command in the R Console to make sure it works.
  * Inspect the downloaded words file any way you know how; make sure it's not garbage. Size should be about 2.4MB.
  * Delete `words.txt`.
  * Put the above rule into your `Makefile`. From the shell, enter `make words.txt` to verify rule works. Reinspect the words file.
  * Git folks: commit `Makefile` and `words.txt`.

#### Copy the dictionary

On Mac or Linux systems, rather than download the dictionary, we can simply copy the file `/usr/share/dict/words` that comes with the operating system. In this alternative rule, we use the shell command `cp` to copy the file.

```makefile
words.txt: /usr/share/dict/words
	cp /usr/share/dict/words words.txt
```

This rule copies the input file `/usr/share/dict/words` to create the output file `words.txt`. We then repeat these file names in the command rule, which is redundant and leaves us vulnerable to typos. `make` offers many automatic variables, so the revised rule below uses `$<` and `$@` to represent the input file and output file, respectively.

```makefile
words.txt: /usr/share/dict/words
	cp $< $@
```

Suggested workflow:

  * Git folks: commit anything new/modified. Start with a clean working tree.
  * Remove `words.txt` if you succeeded with the download approach.
  * Submit the above `cp` command in the shell to make sure it works.
  * Inspect the copied words file any way you know how; make sure it's not garbage. Size should be about 2.4MB.
  * Delete `words.txt`.
  * Put the above rule into your `Makefile`. From the shell, enter `make words.txt` to verify rule works. Reinspect the words file.
  * Git folks: look at the diff. You should see how your `words.txt` rule has changed and you might also see some differences between the local and remote words files. Interesting! Commit `Makefile` and `words.txt`.

Create a table of word lengths
================================================================================

This rule will read the list of words and generate a table of word length frequency, stored in a tab-separated-values (TSV) file. This R script is a little longer, so we'll put it in its own file, named `histogram.r`. If either the script `histogram.r` or the data file `words.txt` were to change, we'd need to rerun this command to get up-to-date results, so both files are dependencies of this rule. The input-file variable `$<` refers to the *first* dependency, `histogram.r`.

```makefile
histogram.tsv: histogram.r words.txt
	Rscript $<
```

Create the R script `histogram.r` that reads the list of words from `words.txt` and writes the table of word length frequency to `histogram.tsv`. It should be a tab-delimited TSV file with a header and two columns, named `Length` and `Freq`. Hint: you can accomplish this task using four functions: `readLines`, `nchar`, `table` and `write.table`. Here's [one solution](https://raw.githubusercontent.com/STAT545-UBC/STAT545-UBC.github.io/master/automation10_holding-area/activity/histogram.r), but try not to peek until you've attempted this task yourself.

Plot a histogram of word lengths
================================================================================

This rule will read the table of word lengths and plot a histogram using qplot. It's three lines long, but we'll still include the script in the `Makefile` directly, and use semicolons `;` to separate the R commands. The variable `$@` refers to the output file, `histogram.png`.

```makefile
histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
```

Render a HTML report
================================================================================

Finally, we'll use `rmarkdown::render` to generate the HTML report.

```makefile
report.html: report.md
	Rscript -e 'rmarkdown::render("$<")'
```

If the table of word lengths or figure were to change, `make` wouldn't know that it needs to regenerate the report. We can add additional dependencies to the rule so that `make` will regenerate the report if any of its three dependencies changes.

```makefile
report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'
```

Create the RMarkdown file `report.rmd` that reads the table of words lengths `histogram.tsv`, reports the most common word length and displays the histogram `histogram.png`. Here's [one solution](https://raw.githubusercontent.com/STAT545-UBC/STAT545-UBC.github.io/master/automation10_holding-area/activity/report.rmd), but try not to peek until you've attempted this task yourself.

Render a PDF report
================================================================================

Can you modify the `rmarkdown::render` command to generate a PDF report instead of an HTML report? Hint: look at the optional second argument of `rmarkdown::render`. Alternatively, click the *Knit* dropdown box and select *Knit PDF*, and look at how RStudio modifies the header of your RMarkdown script.

Add a default target to the Makefile
================================================================================

The *Build -> Build All* menu item of RStudio runs the `Makefile` target named `all`. To make this default target generate our report, add the report as a dependency of the target named `all`. Note that unlike other rules, this rule has no commands associated with it.

```makefile
all: report.html
```

Select *Build -> Build All*.

Add a clean target to the Makefile
================================================================================

The *Build -> Clean All* menu item of RStudio runs the `Makefile` target named `clean`. By convention this target removes all files that can be regenerated by the Makefile.

```makefile
clean:
	rm -f words.txt histogram.tsv histogram.png report.html
```

Select *Build -> Clean All* and then *Build -> Build All*.
