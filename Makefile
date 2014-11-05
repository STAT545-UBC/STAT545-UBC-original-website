all: syllabus.html \
	cm105_pipelines.html \
	cm106_pipelines.html \
	block023_pipelines.html \
	block023_pipelines/slides.html

install-deps:
	brew install graphviz

.PHONY: all
.DELETE_ON_ERROR:
.SECONDARY:

# Patterns

block%/slides.html: block%/slides.revealjs block%/slides.md
	pandoc -pst revealjs -V theme:sky -o $@ --template $^

%.html: %.Rmd
	Rscript -e 'rmarkdown::render("$<")'

%.html: %.md
	Rscript -e 'rmarkdown::render("$<")'

%.png: %.gv
	dot -Tpng $< >$@

# Dependencies

block023_pipelines.html: block023_pipelines/images/activity.png
