## one Makefile to make them all

all: totalWordsByFilmRace.tsv

lotr_raw.tsv:
	curl -L http://bit.ly/lotr_raw-tsv >lotr_raw.tsv

lotr_clean.tsv: lotr_raw.tsv 01_filterReorder.R
	Rscript 01_filterReorder.R

totalWordsByFilmRace.tsv: lotr_clean.tsv 02_aggregatePlot.R
	Rscript 02_aggregatePlot.R

clean:
	rm -f lotr_clean.tsv totalWordsByFilmRace.tsv *.png
