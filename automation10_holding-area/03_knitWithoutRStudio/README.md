Toy example for [STAT 545A Homework 6](http://www.stat.ubc.ca/~jenny/STAT545A/hw06_puttingAllTogether.html).

Shows how to create a small-but-automated analytical pipeline using a Makefile AND using `rmarkdown` (or `knitr`) *without* the help of RStudio's buttons.

Demonstration data: the number of words spoken by various characters in the Lord of the Rings trilogy. Each observation gives total word count for a character in a specific scene of a single movie. Variables are character, race (hobbit vs. dwarf, etc.), film, chapter ("scene"), number of words spoken. JB will document general cleaning, analyses, etc. of that data [here](https://github.com/jennybc/lotr); these scripts are deliberately simple.

How to replicate my analysis

  * (Clone the repo! Ha! OK I'm pretending the analyst doesn't use github.)
  * Download into an empty directory:
    - Input data: [`lotr_raw.tsv`](https://github.com/jennybc/STAT545A/blob/master/hw06_scaffolds/03_knitWithoutRStudio/lotr_raw.tsv)
    - Scripts: [`01_filterReorder.R`](https://raw.github.com/jennybc/STAT545A/master/hw06_scaffolds/03_knitWithoutRStudio/01_filterReorder.R) and [`02_aggregatePlot.R`](https://raw.github.com/jennybc/STAT545A/master/hw06_scaffolds/03_knitWithoutRStudio/02_aggregatePlot.R)
    - R Markdown: [`03_doStuff.Rmd`](https://raw.github.com/jennybc/STAT545A/master/hw06_scaffolds/03_knitWithoutRStudio/03_doStuff.Rmd)
    - Makefile: [`Makefile`](https://raw.github.com/jennybc/STAT545A/master/hw06_scaffolds/03_knitWithoutRStudio/Makefile)
  * In a shell: `make all`. Or just: `make`. Or: `make stripplot_wordsByRace_The_Two_Towers.png`
  * New files you should see after running the pipeline:
    - [`barchart_totalWords.png`](https://raw.github.com/jennybc/STAT545A/master/hw06_scaffolds/03_knitWithoutRStudio/barchart_totalWords.png)
    - [`barchart_totalWordsFilmDodge.png`](https://raw.github.com/jennybc/STAT545A/master/hw06_scaffolds/03_knitWithoutRStudio/barchart_totalWordsFilmDodge.png)
    - [`lotr_clean.tsv`](https://github.com/jennybc/STAT545A/blob/master/hw06_scaffolds/03_knitWithoutRStudio/lotr_clean.tsv)
    * [`01_filterReorder.html`](http://htmlpreview.github.com/?https://github.com/jennybc/STAT545A/blob/master/hw06_scaffolds/03_knitWithoutRStudio/01_filterReorder.html), a "Compiled Notebook" (in the RStudio sense) based on `01_filterReorder.R`
    * [`03_doStuff.html`](http://htmlpreview.github.com/?https://github.com/jennybc/STAT545A/blob/master/hw06_scaffolds/03_knitWithoutRStudio/03_doStuff.html), a compiled HTML report based on [`03_doStuff.Rmd`](https://raw.github.com/jennybc/STAT545A/master/hw06_scaffolds/03_knitWithoutRStudio/03_doStuff.Rmd). Shows how to embed a pre-existing PNG (vs. only a figure actually created in an R chunk).
    - `stripplot_wordsByRace_FILM.png`, where FILM is one of the 3 movies. Example: [`stripplot_wordsByRace_The_Fellowship_Of_The_Ring.png`](https://raw.github.com/jennybc/STAT545A/master/hw06_scaffolds/03_knitWithoutRStudio/stripplot_wordsByRace_The_Fellowship_Of_The_Ring.png)
    - [`totalWordsByFilmRace.tsv`](https://github.com/jennybc/STAT545A/blob/master/hw06_scaffolds/03_knitWithoutRStudio/totalWordsByFilmRace.tsv)
  * To remove the output and get a clean slate, in a shell: `make clean`

