all: report.html report.pdf

clean:
	rm -f words.tsv lengths.tsv histogram.tsv histogram.png report.md report.html report.pdf

.PHONY: all
.DELETE_ON_ERROR:
.SECONDARY:

words.tsv: /usr/share/dict/words
	cp $< $@

lengths.tsv: words.tsv
	awk '{print length}' $< >$@

histogram.tsv: lengths.tsv
	sort -n $< |uniq -c |awk 'BEGIN{print "count\tlength"} {print $$1 "\t" $$2}' >$@

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(length,count,data=read.delim("$<")); ggsave("$@")'

report.md: histogram.tsv histogram.png

%.md: %.rmd
	Rscript -e 'knitr::knit("$<", "$@")'

%.html: %.md
	Rscript -e 'rmarkdown::render("$<", "html_document")'

%.pdf: %.md
	Rscript -e 'rmarkdown::render("$<", "pdf_document")'
