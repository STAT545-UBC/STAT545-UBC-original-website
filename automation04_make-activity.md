---
title: "Automating Data-analysis Pipelines"
author: "Shaun Jackman"
date: "2014-11-03"
output:
  html_document:
    toc: true
    toc_depth: 2
    pandoc_args: "--preserve-tabs"
---

Jenny's proposed re-org and some insertions:

  * dependency graph of the pipeline
  * new RStudio project and Git repo
  * rule to copy and/or download words.txt
  * R script to compute table of word lengths
  * rule to run word length script
  * ?create all and clean targets at this point and play with them?
  * R snippet to create visual histogram
  * rule to create histogram
  * update all and clean targets; use them
  * R Markdown file to generate a report
  * rule to render the Markdown file
  * update all and clean targets; use them

Automating Data-analysis Pipelines
================================================================================

The goal of this activity is to create a pipeline that will

+ calculate a histogram of English word lengths
+ determine the most common word length
+ generate a figure of this histogram
+ render a RMarkdown report in HTML and PDF

You will automate this pipeline using `make`!

Dependency graph of the pipeline
================================================================================

[![automation01_slides/images/activity.png](automation01_slides/images/activity.png)](automation01_slides/images/activity.gv)


Download or copy the dictionary
================================================================================

Download the dictionary
------------------------------------------------------------

Our first `Makefile` rule will download the dictionary `words.txt`. The command of this rule is a one-line R script, so instead of putting the R script in a separate file, we'll include the command directly in the Makefile, since it's so short.

```makefile
words.txt:
	Rscript -e 'cat(file="words.txt", RCurl::getURL("https://raw.githubusercontent.com/eneko/data-repository/master/data/words.txt", ssl.verifypeer=FALSE))'
```

Troubleshooting

RCurl::getURL: GET_SERVER_CERTIFICATE: certificate verify failed
------------------------------------------------------------

The secure socket layer (SSL) was unable to make a secure `https` connection to the remote web site. A work around is to set the `ssl.verifypeer=FALSE` option of `RCurl::getURL`. There's more discussion of this issue on the [FAQ for RCurl](http://www.omegahat.org/RCurl/FAQ.html).

```r
RCurl::getURL(..., ssl.verifypeer=FALSE)'
```

Copy the dictionary
------------------------------------------------------------

On Mac or Linux systems, rather than download the dictionary, we can simply copy the file `/usr/share/dict/words` that comes with the operating system. Windows machines do not have `/usr/share/dict/words`, and so there we'll have to download the dictionary. 

```makefile
words.txt: /usr/share/dict/words
	cp /usr/share/dict/words words.txt
```

This rule copies the input file `/usr/share/dict/words` to create the output file `words.txt`. We then repeat these file names in the command rule, which seems rather redundant. We can use the oddly-named variables `$<` and `$@`, which represent the input file and output file respectively to save us from this redundancy.

```makefile
words.txt: /usr/share/dict/words
	cp $< $@
```

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
