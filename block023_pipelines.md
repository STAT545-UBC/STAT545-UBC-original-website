---
title: "Automating Data-analysis Pipelines"
author: "Shaun Jackman"
date: "2014-11-03"
output:
  html_document:
    toc: true
    toc_depth: 2
---

Automating Data-analysis Pipelines
================================================================================

The goal of this activity is to create a pipeline that will

+ calculate a histogram of English word lengths
+ determine the most common word length
+ generate a figure of this histogram
+ render a RMarkdown report in HTML and PDF

You will automate this pipeline using `make`!

Getting Started
================================================================================

Install `make` on Microsoft Windows
------------------------------------------------------------

These instructions are courtesy of [Dean Attali](https://github.com/daattali).

Mac OS and Linux machines come with `make` installed. You do not need to follow these instructions.

### Install Make for Windows

+ Go to the [Make for Windows](http://gnuwin32.sourceforge.net/packages/make.htm) web site
+ Download the [Setup program](http://gnuwin32.sourceforge.net/downlinks/make.php)
+ Install the file you just downloaded and copy to your clipboard the directory in which it is being installed
+ The default directory is `C:\Program Files (x86)\GnuWin32\`
+ You now have `make` installed, but you need to tell Windows where to find the program. This is called [updating your `PATH`](https://www.google.ca/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=windows%20update%20path%20variable). You will want to update the `PATH` to include the `bin` directory of the newly installed program. These are the steps on Windows 7 (for Windows 8 you'd have to Google it):

### Update your `PATH`

+ Click on the Windows logo
+ Right click on *Computer*
+ Select *Properties*
+ Select *Advanced System Settings*
+ Select *Environment variables*
+ Select the line that has the `PATH` variable. You may have to scroll down to find it
+ Select *Edit*
+ Go to the end of the line and add a semicolon `;`, followed by the path where the program was installed, followed by `\bin`. For example, I added the following to the end of the line: `;C:\Program Files (x86)\GnuWin32\bin`
+ Click Okay and close all the windows that you opened
+ Close RStudio and open it again.
+ RStudio and your command line will now know where to find `make`

Configure RStudio
------------------------------------------------------------

+ `make` is rather picky and requires that lines be indented with tabs and not spaces
+ Select *Tools -> Global Options -> Code Editing* and make sure that *Insert spaces for tabs* is *not* checked
+ If *Tools -> Project Options* is not greyed out, select *Tools -> Project Options -> Code Editing* and make sure that *Insert spaces for tabs* is *not* checked

Dependency graph of the pipeline
================================================================================

[![block023_pipelines/images/activity.png](block023_pipelines/images/activity.png)](block023_pipelines/images/activity.gv)

Use RStudio to run make
================================================================================

+ Create an RStudio project: *File -> New Project*
+ Create a new text file: *File -> New File -> Text File*
+ Start editing your first `Makefile`!
	```makefile
	all:
		echo Build all

	clean:
		echo Clean all
	```
+ Save it, and name it `Makefile`
+ Select *Build -> Configure Build Tools -> Build Tools -> Project build tools -> Makefile*
+ Select *Build -> Build All*
+ The result and any error messages will appear under the *Build* tab, usually found in the top-right corner of RStudio

### *Build* menu items

+ *Build All* runs `make all`
+ *Clean and Rebuild* runs `make clean all`
+ *Clean All* runs `make clean`

For these menu items to work your `Makefile` needs to have targets named `all` and `clean`. These non-file targets are called phony targets.

Run make from the command line
================================================================================

+ Select *Tools -> Shell*
+ Run

	```sh
	make clean
	make all
	make clean all
	```

Download or copy the dictionary
================================================================================

Download the dictionary
------------------------------------------------------------

Our first `Makefile` rule will download the dictionary `words.tsv`. The command of this rule is a one-line R script, so instead of putting the R script in a separate file, we'll include the command directly in the Makefile, since it's so short.

```makefile
words.tsv:
	Rscript -e 'cat(file="words.tsv", RCurl::getURL("https://raw.githubusercontent.com/eneko/data-repository/master/data/words.txt", ssl.verifypeer=FALSE))'
```

Copy the dictionary
------------------------------------------------------------

On Mac or Linux systems, rather than download the dictionary, we can simply copy the file `/usr/share/dict/words` that comes with the operating system. Windows machines do not have `/usr/share/dict/words`, and so there we'll have to download the dictionary. 

```makefile
words.tsv: /usr/share/dict/words
	cp /usr/share/dict/words words.tsv
```

This rule copies the input file `/usr/share/dict/words` to create the output file `words.tsv`. We then repeat these file names in the command rule, which seems rather redundant. We can use the oddly-named variables `$<` and `$@`, which represent the input file and output file respectively to save us from this redundancy.

```makefile
words.tsv: /usr/share/dict/words
	cp $< $@
```

Create a table of word lengths
================================================================================

This rule will read the list of words and generate a table of word length frequency, stored in a tab-separated-values (TSV) file. This R script is a little longer, so we'll put it in its own file, named `histogram.r`. If either the script `histogram.r` or the data file `words.tsv` were to change, we'd need to rerun this command to get up-to-date results, so both files are dependencies of this rule. The input-file variable `$<` refers to the *first* dependency, `histogram.r`.

```makefile
histogram.tsv: histogram.r words.tsv
	Rscript $<
```

### histogram.r

```r
words <- read.delim("words.tsv", stringsAsFactors = FALSE)[[1]]
Length <- nchar(words)
counts <- table(Length)
write.table(counts, "histogram.tsv",
	sep = "\t", row.names = FALSE, quote = FALSE)
```

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

Create the RMarkdown file `report.rmd` that reads the table of words lengths `histogram.tsv`, reports the most common word length and displays the histogram `histogram.png`. Here's [one solution](https://raw.githubusercontent.com/STAT545-UBC/STAT545-UBC.github.io/master/block023_pipelines/activity/report.rmd), but try not to peek until you've attempted this task yourself.

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
	rm -f words.tsv histogram.tsv histogram.png report.html
```

Select *Build -> Clean All* and then *Build -> Build All*.

Troubleshooting
================================================================================

Missing separator
------------------------------------------------------------

Error: `makefile:2: *** missing separator. Stop.`

Use tabs instead of spaces to indent command lines.

See [Configure RStudio](#configure-rstudio)

------------------------------------------------------------
