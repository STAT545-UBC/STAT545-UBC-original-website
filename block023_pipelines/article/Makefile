all: article.html

clean:
	rm -f article.html article.md figure.png

.PHONY: all clean
.DELETE_ON_ERROR:
.SECONDARY:

%.md: %.Rmd
	Rscript -e 'knitr::knit("$<", "$@")'

%.html: %.md
	pandoc -s -o $@ $<

%.html: %.Rmd
	Rscript -e 'rmarkdown::render("$<")'

article.html: figure.png

%.png: %.gv
	dot -Tpng $< >$@
