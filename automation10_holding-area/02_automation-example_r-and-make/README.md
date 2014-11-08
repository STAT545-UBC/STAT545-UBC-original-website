Toy example of [automating a data-analytical pipeline](../../automation00_index.html) for [STAT 545A](http://stat545-ubc.github.io).

Shows how to create a small-but-automated analytical pipeline using a Makefile.

See the previous example [01_automation-example_just-r](https://github.com/STAT545-UBC/STAT545-UBC.github.io/tree/master/automation10_holding-area/01_automation-example_just-r) for the same pipeline implemented with pseudo `Makefile.R`.

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