Toy example of [automating a data-analytical pipeline](../../automation00_index.html) for [STAT 545A](http://stat545-ubc.github.io).

Shows how to create a small-but-automated analytical pipeline using R alone or R plus the shell.

See the next example [02_automation-example_r-and-make](https://github.com/STAT545-UBC/STAT545-UBC.github.io/tree/master/automation10_holding-area/02_automation-example_r-and-make) for the same pipeline implemented with `make`.

Demonstration data: the number of words spoken by various characters in the Lord of the Rings trilogy, available here:

<https://github.com/jennybc/lotr>

Suggested workflows:

  * Clone this directory. For example, clone the entire course repo, which includes this directory.
  * Start a fresh RStudio session, make sure this directory is the working directory.
  * Run any scripts you like interactively.
  * Run any script you like at arm's length, via `source()` or RStudio Source button.
  * Run `Makefile.R` interactively
    - this includes code to clean out of previous work
  * Run `Makefile.R` at arm's length
  * Run from the shell via `Rscript Makefile.R`
