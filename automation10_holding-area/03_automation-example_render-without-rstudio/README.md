Toy example of [automating a data-analytical pipeline](../../automation00_index.html) for [STAT 545A](http://stat545-ubc.github.io).

Shows how to create a small-but-automated analytical pipeline using a `Makefile` AND using `rmarkdown::render()` on plain R scripts and R Markdown files, *without* the help of RStudio's buttons.

Demonstration data: the number of words spoken by various characters in the Lord of the Rings trilogy, available here:

<https://github.com/jennybc/lotr>

Suggested workflows:

  * Clone this directory. For example, clone the entire course repo, which includes this directory.
  * Start a fresh RStudio session, make sure this directory is the working directory.
  * Run any scripts you like interactively.
  * Run any script you like at arm's length, via `source()` or RStudio Source button.
  * In a shell, experiment with commands like these to cause scripts to be run:
    - `make lotr_clean.tsv` (replace `lotr_clean.tsv` with other targets)
    - `make clean`
    - `make all`
  * Delete various intermediates "by hand" and use `make all` to re-run necessary parts of the pipeline.
  * Note all the HTML and Markdown reports left behind by this pipeline!
  