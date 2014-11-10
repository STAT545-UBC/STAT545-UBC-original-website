all: syllabus.html \
	topics.html \
	cm105_pipelines.html \
	cm106_pipelines.html \
	automation00_index.html \
	automation01_slides/index.html \
	automation02_windows.html \
	automation03_make-test-drive.html \
	automation04_make-activity.html \
	automation10_holding-area/01_automation-example_just-r/index.html \
	automation10_holding-area/02_automation-example_r-and-make/index.html \
	automation10_holding-area/03_automation-example_render-without-rstudio/index.html \
	hw09_automation.html

install-deps:
	brew install graphviz

.PHONY: all
.DELETE_ON_ERROR:
.SECONDARY:

# Patterns

%.html: %.Rmd
	Rscript -e 'rmarkdown::render("$<")'

%.html: %.md
	Rscript -e 'rmarkdown::render("$<")'

%/index.html: %/slides.revealjs %/slides.md
	pandoc -pst revealjs -V theme:sky -o $@ --template $^

%/index.html: %/README.md
	Rscript -e 'rmarkdown::render("$<", "html_document", "index.html")'

%.png: %.gv
	dot -Tpng $< >$@

# Dependencies

block023_pipelines.html: block023_pipelines/images/activity.png
