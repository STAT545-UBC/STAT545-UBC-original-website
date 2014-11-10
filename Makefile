all: syllabus.html \
	topics.html \
	cm105_pipelines.html \
	cm106_pipelines.html \
	automation00_index.html \
	automation01_slides/slides.html \
	automation02_windows.html \
	automation03_make-test-drive.html \
	automation04_make-activity.html \
	hw09_automation.html

install-deps:
	brew install graphviz

.PHONY: all
.DELETE_ON_ERROR:
.SECONDARY:

# Patterns

%/slides.html: %/slides.revealjs %/slides.md
	pandoc -pst revealjs -V theme:sky -o $@ --template $^

%.html: %.Rmd
	Rscript -e 'rmarkdown::render("$<")'

%.html: %.md
	Rscript -e 'rmarkdown::render("$<")'

%.png: %.gv
	dot -Tpng $< >$@

# Dependencies

block023_pipelines.html: block023_pipelines/images/activity.png
