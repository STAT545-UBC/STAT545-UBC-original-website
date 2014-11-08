## one Makefile to make them all

all: total-words-by-film-race.tsv

#lotr_raw.tsv:
#	curl -L http://bit.ly/lotr_raw-tsv >lotr_raw.tsv

lotr_raw.tsv:
	Rscript 00_download-data.R

lotr_clean.tsv: lotr_raw.tsv 01_filter-reorder-plot.R
	Rscript 01_filter-reorder-plot.R
	rm Rplots.pdf

total-words-by-film-race.tsv: lotr_clean.tsv 02_aggregate-plot.R
	Rscript 02_aggregate-plot.R
	rm Rplots.pdf

clean:
	rm -f lotr_raw.tsv lotr_clean.tsv total-words-by-film-race.tsv *.png
