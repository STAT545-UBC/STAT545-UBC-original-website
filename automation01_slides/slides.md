---
title: 'Automating Data-analysis Pipelines'
author: 'Shaun Jackman'
date: '2014-11-03'
---

Automating Data-analysis Pipelines
------------------------------------------------------------

| UBC [STAT 545A][]/STAT 547M
| 2014-11-03
| [Shaun Jackman][sjackman.ca] [\@sjackman][]
| [Jenny Bryan][] [\@JennyBryan][]
| [![Creative Commons Attribution License](images/cc-by.png)][cc-by]

[STAT 545A]: http://stat545-ubc.github.io/
[sjackman.ca]: http://sjackman.ca
[\@sjackman]: http://twitter.com/sjackman
[Jenny Bryan]: http://www.stat.ubc.ca/~jenny/
[\@JennyBryan]: https://twitter.com/JennyBryan
[cc-by]: http://creativecommons.org/licenses/by/4.0/

Pipelines Automation Dependencies
================================================================================

Automation
------------------------------------------------------------

+ using [R][]
+ using the [shell][] and [Rscript][]
+ using [make][]

------------------------------------------------------------

[![Automation](http://imgs.xkcd.com/comics/automation.png)][xkcd automation]

&#39;Automating&#39; comes from the roots &#39;auto-&#39; meaning &#39;self-&#39;, and &#39;mating&#39;, meaning &#39;screwing&#39;.

[xkcd automation]: http://xkcd.com/1319/

Pipelines
================================================================================

A pipeline
------------------------------------------------------------

breaks up a monolithic make-all-the-things script into discrete, manageable chunks.

Each stage of the pipeline
------------------------------------------------------------

| … defines its input and its outputs.
| … does *not* modify its inputs, so it is *idempotent*.

| Rerunning a stage of the pipeline
| produces the same results as the previous run.

Advantage #1
------------------------------------------------------------

| When you modify one stage of the pipeline,
| you don't have to rerun the entire pipeline.

You only rerun the downstream, dependent stages.

Advantage #2
------------------------------------------------------------

Divide up work amongst a group by assigning to each person stages of the pipeline design.

Advantage #3
------------------------------------------------------------

| You can draw pretty pictures of your pipeline,
| because a pipeline is a graph.

------------------------------------------------------------

| [![01_justR](images/pipeline.png)](images/pipeline.gv)
| [*01_justR*](01_justR)

Automation
================================================================================

Automate a pipeline
------------------------------------------------------------

| … to reproduce previous results.
| … to recreate results deleted by fat fingers.
| … to rerun the pipeline with updated software.
| … to run the same pipeline on a new data set.

Tools
------------------------------------------------------------

+ [R][]
+ the [shell][] and [Rscript][]
+ [make][]

R
------------------------------------------------------------

```r
#!/usr/bin/env Rscript
source("00_downloadData.R")
source("01_filterReorder.R")
source("02_aggregatePlot.R")
```

. . .

+ Shows in what order to run the scripts.
+ You can resume the pipeline from the middle.

Shell and Rscript
------------------------------------------------------------

```bash
#!/bin/sh
set -eux
Rscript 00_downloadData.R
Rscript 01_filterReorder.R
Rscript 02_aggregatePlot.R
```

. . .

Allows you to easily run your pipeline from the shell.

. . .

| Option   | Effect
|----------|--------
| `set -e` | Stop at the first error
| `set -u` | Undefined variables are an error
| `set -x` | Print each command as it is run

Mix R scripts with other tools
------------------------------------------------------------

```bash
#!/bin/sh
set -eux
curl -L http://bit.ly/lotr_raw-tsv >lotr_raw.tsv
Rscript 01_filterReorder.R
Rscript 02_aggregatePlot.R
```

. . .

R is a good tool, but not always the best tool for the job.

Not sacrilege, but the principal tenet of a polyglot.

Makefile
------------------------------------------------------------

```makefile
#!/usr/bin/make -f

lotr_raw.tsv:
	curl -L http://bit.ly/lotr_raw-tsv >lotr_raw.tsv

lotr_clean.tsv: 01_filterReorder.R lotr_raw.tsv
	Rscript 01_filterReorder.R

totalWordsByFilmRace.tsv: 02_aggregatePlot.R lotr_clean.tsv
	Rscript 02_aggregatePlot.R
```

. . .

| A Makefile gives both the commands
| *and their dependencies*.

Make is beautiful
------------------------------------------------------------

| Tell Make how to create one type of file from another
| and which files you want to create.

. . .

| Make looks at which files you have
| and figures out how to create the files that you want.

Dependency graph
================================================================================

A pipeline is a graph
------------------------------------------------------------

Scripts and data files are vertices of the graph.

Dependencies between stages are edges of the graph.

------------------------------------------------------------

Both scripts and data files are shown.

| [![01_justR](images/pipeline.png)](images/pipeline.gv)
| [*01_justR*](01_justR)

------------------------------------------------------------

+ Only dependencies between scripts are shown.
+ Data files are not shown.
+ Run the scripts in *topographical* order.

| [![STAT 540 Differential Methylation in Leukemia](images/stat540diffmethleuk.png)][stat540diffmethleuk]
| *STAT 540 Differential Methylation in Leukemia*

[stat540diffmethleuk]: https://sites.google.com/site/stat540diffmethleuk/code

Order of dependencies
------------------------------------------------------------

A shell script gives *one* order in which you can successfully run the pipeline.

. . .

Unless the pipeline is completely linear, there are likely other such orders.

------------------------------------------------------------

[![STAT 540 Differential Methylation in Leukemia](images/stat540diffmethleuk.png)][stat540diffmethleuk]

A different order of commands may be more convenient, but without information of the dependencies, you're stuck with the given order.

A reproducible manuscript
================================================================================

One Makefile
------------------------------------------------------------

+ Downloads the data
+ Runs the command-line programs
+ Performs the statistical analyses using [R][]
+ and Generates the TSV tables
+ Renders the figures using [ggplot2][]
+ Renders the supplementary material using [RMarkdown][]
+ Renders the manuscript using [Pandoc][]

[R]: http://tryr.codeschool.com/
[ggplot2]: http://ggplot2.org/
[RMarkdown]: http://rmarkdown.rstudio.com/
[Pandoc]: http://johnmacfarlane.net/pandoc/

Turns this
------------------------------------------------------------

![[UniqTag Markdown][]](images/UniqTag-md.png)

[UniqTag Markdown]: https://github.com/sjackman/uniqtag-paper/blob/master/UniqTag.md

Into this
------------------------------------------------------------

![[UniqTag PDF][]](images/UniqTag-pdf.png)

[UniqTag PDF]: http://biorxiv.org/content/early/2014/08/01/007583.full.pdf

Workflow
================================================================================

------------------------------------------------------------

[Plain Text, Papers, Pandoc][] by [Kieran Healy][]

![I promise this is less insane than it appears](images/workflow-rmd-md.png)

[Plain Text, Papers, Pandoc]: http://kieranhealy.org/blog/archives/2014/01/23/plain-text/
[Kieran Healy]: http://kieranhealy.org/

Markdown for the manuscript
------------------------------------------------------------

[Markdown][] is a plain-text typesetting language

```markdown
A header
========

A list:

+ This text is *italic*
+ This text is **bold**
```

### A header

A list:

+ This text is *italic*
+ This text is **bold**

[Markdown]: https://help.github.com/articles/markdown-basics/

RMarkdown
------------------------------------------------------------

+ [RMarkdown][] interleaves prose with [R][] code
	- to aggregate and summarize the data
	- to generate tables
	- to render figures using [ggplot2][]
+ [RMarkdown][] is ideal for supplementary material

RMarkdown example
------------------------------------------------------------

~~~
The Sum of 1 + 1
================

The sum of 1 + 1 is calculated as follows.

```{r}
1 + 1
```

![*Fig. 1*: A graphical view of 1 + 1](figure.png)
~~~

[*article.Rmd*](article/article.Rmd)


The Sum of 1 + 1
------------------------------------------------------------

The sum of 1 + 1 is calculated as follows.


```r
1 + 1
```

```
## [1] 2
```

![*Fig. 1*: A graphical view of 1 + 1](article/figure.png)

------------------------------------------------------------

[![article.gv](images/article.png)](images/article.gv)

Dependencies of [*article/Makefile*](article/Makefile)

Render HTML
------------------------------------------------------------

```makefile
%.md: %.Rmd
	Rscript -e 'knitr::knit("$<", "$@")'

%.html: %.md
	pandoc -s -o $@ $<

%.html: %.Rmd
	Rscript -e 'rmarkdown::render("$<")'

article.html: figure.png

%.png: %.gv
	dot -Tpng $< >$@
```

```bash
make article.html
```

```bash
dot -Tpng figure.gv >figure.png
Rscript -e 'rmarkdown::render("article.Rmd")'
```

Knit Markdown
------------------------------------------------------------

```makefile
%.md: %.Rmd
	Rscript -e 'knitr::knit("$<", "$@")'

%.html: %.md
	pandoc -s -o $@ $<

%.html: %.Rmd
	Rscript -e 'rmarkdown::render("$<")'

article.html: figure.png

%.png: %.gv
	dot -Tpng $< >$@
```

```bash
make article.md article.html
```

```bash
Rscript -e 'knitr::knit("article.Rmd", "article.md")'
dot -Tpng figure.gv >figure.png
pandoc -s -o article.html article.md
```

Pandoc
------------------------------------------------------------

| [Pandoc][] renders attractive documents and slides
| from plain-text typesetting formats

It converts between every format known (just about)

+ Markdown
+ HTML
+ LaTeX
+ PDF
+ ODT and docx (yes, really)

Evolving a Makefile
================================================================================

------------------------------------------------------------

```bash
#!/bin/sh
set -eux
dot -Tpng -o figure.png figure.gv
Rscript -e 'knitr::knit("article.Rmd")'
pandoc -s -o article.html article.md
```

Shell script

------------------------------------------------------------

```makefile
all:
	dot -Tpng -o figure.png figure.gv
	Rscript -e 'knitr::knit("article.Rmd")'
	pandoc -s -o article.html article.md
```

First Makefile

------------------------------------------------------------

```makefile
all: article.html

article.html:
	dot -Tpng -o figure.png figure.gv
	Rscript -e 'knitr::knit("article.Rmd")'
	pandoc -s -o article.html article.md
```

Add a rule to build `article.html`

------------------------------------------------------------

```makefile
all: article.html

article.html: article.Rmd
	dot -Tpng -o figure.png figure.gv
	Rscript -e 'knitr::knit("article.Rmd")'
	pandoc -s -o article.html article.md
```

`article.html` depends on `article.Rmd`

------------------------------------------------------------

```makefile
all: article.html

figure.png: figure.gv
	dot -Tpng -o figure.png figure.gv

article.md: article.Rmd
	Rscript -e 'knitr::knit("article.Rmd")'

article.html: article.md figure.png
	pandoc -s -o article.html article.md
```

Split one rule into three

------------------------------------------------------------

```makefile
all: article.html

figure.png: figure.gv
	dot -Tpng -o $@ $<

article.md: article.Rmd
	Rscript -e 'knitr::knit("$<", "$@")'

article.html: article.md figure.png
	pandoc -s -o $@ $<
```

Use the variables `$<` and `$@` for the input and output file

------------------------------------------------------------

```makefile
all: article.html

%.png: %.gv
	dot -Tpng -o $@ $<

%.md: %.Rmd
	Rscript -e 'knitr::knit("$<", "$@")'

article.html: article.md figure.png
	pandoc -s -o $@ $<
```

Use pattern rules. The `%` matches any string

------------------------------------------------------------

```makefile
all: article.html

%.png: %.gv
	dot -Tpng -o $@ $<

%.md: %.Rmd
	Rscript -e 'knitr::knit("$<", "$@")'

%.html: %.md
	pandoc -s -o $@ $<

article.html: figure.png
```

`article.html` also depends on `figure.png`

------------------------------------------------------------

```makefile
all: article.html

clean:
	rm -f article.md article.html figure.png

%.png: %.gv
	dot -Tpng -o $@ $<

%.md: %.Rmd
	Rscript -e 'knitr::knit("$<", "$@")'

%.html: %.md
	pandoc -s -o $@ $<

article.html: figure.png
```

Add the target named `clean`

------------------------------------------------------------

```makefile
all: article.html

clean:
	rm -f article.md article.html figure.png

.PHONY: all clean
.DELETE_ON_ERROR:
.SECONDARY:

%.png: %.gv
	dot -Tpng -o $@ $<

%.md: %.Rmd
	Rscript -e 'knitr::knit("$<", "$@")'

%.html: %.md
	pandoc -s -o $@ $<

article.html: figure.png
```

Add `.PHONY`, `.DELETE_ON_ERROR` and `.SECONDARY`

------------------------------------------------------------

```makefile
all: article.html

clean:
	rm -f article.md article.html figure.png

.PHONY: all clean
.DELETE_ON_ERROR:
.SECONDARY:

# Render a GraphViz file
%.png: %.gv
	dot -Tpng -o $@ $<

# Knit a RMarkdown document
%.md: %.Rmd
	Rscript -e 'knitr::knit("$<", "$@")'

# Render a Markdown document to HTML
%.html: %.md
	pandoc -s -o $@ $<

# Dependencies on figures
article.html: figure.png
```

fin
================================================================================

Links
------------------------------------------------------------

| [STAT 545A][] | [xkcd automation][]
| [R][] | [Rscript][] | [shell][] | [make][]
| [Markdown][] | [RMarkdown][] | [Pandoc][] | [ggplot2][]
| [Plain Text, Papers, Pandoc][]
| [STAT 540 Differential Methylation in Leukemia][stat540diffmethleuk]

[\@sjackman][] | [github.com/sjackman][] | [sjackman.ca][]

[Rscript]: https://stat.ethz.ch/R-manual/R-devel/library/utils/html/Rscript.html
[make]: http://en.wikipedia.org/wiki/Make_(software)
[shell]: http://en.wikipedia.org/wiki/Shell_script

Shaun Jackman
------------------------------------------------------------

| [Genome Sciences Centre][], BC Cancer Agency
| Vancouver, Canada
| [\@sjackman][]
| [github.com/sjackman][]
| [sjackman.ca][]

![](images/sjackman.jpg)

[Genome Sciences Centre]: http://bcgsc.ca
[github.com/sjackman]: https://github.com/sjackman
