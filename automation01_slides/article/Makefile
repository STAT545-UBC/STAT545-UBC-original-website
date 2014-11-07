#!/usr/bin/make -f

all: article.html

clean:
	rm -f article.html article.md figure.png

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
