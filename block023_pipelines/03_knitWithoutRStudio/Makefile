## one Makefile to make them all

all: totalWordsByFilmRace.tsv 03_doStuff.html

lotr_raw.tsv:
	curl -L http://bit.ly/lotr_raw-tsv >lotr_raw.tsv

lotr_clean.tsv 01_filterReorder.html: lotr_raw.tsv 01_filterReorder.R
	#Rscript -e "knitr::stitch_rmd('01_filterReorder.R')"
	Rscript -e "rmarkdown::render('01_filterReorder.R')"

totalWordsByFilmRace.tsv: lotr_clean.tsv 02_aggregatePlot.R
	Rscript 02_aggregatePlot.R

03_doStuff.html: 03_doStuff.Rmd
	#Rscript -e "knitr::knit2html('03_doStuff.Rmd')"
	Rscript -e "rmarkdown::render('03_doStuff.Rmd')"

clean:
	rm -rf lotr_clean.tsv totalWordsByFilmRace.tsv *.png 0*.md *.html figure
