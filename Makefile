all: syllabus.html \
	cm105_pipelines.html

.PHONY: all
.DELETE_ON_ERROR:
.SECONDARY:

%.html: %.Rmd
	Rscript -e 'rmarkdown::render("$<")'

%.html: %.md
	Rscript -e 'rmarkdown::render("$<")'
