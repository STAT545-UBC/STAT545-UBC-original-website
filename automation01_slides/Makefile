all: slides.html

graphs: \
	Makefile.png \
#	02_rAndMake/Makefile.png \
#	03_knitWithoutRStudio/Makefile.png \
	activity/Makefile.png \
	article/Makefile.png

clean:
	rm -f slides.html

install-deps:
	brew install pandoc

.PHONY: all clean install-deps
.DELETE_ON_ERROR:
.SECONDARY:

revealjs-2.6.2.tar.gz:
	curl -L https://github.com/hakimel/reveal.js/archive/2.6.2.tar.gz >$@

slides.html: %.html: %.md %.revealjs
	pandoc -pst revealjs --template $* -V theme:sky -o $@ $<

slides.html: images/article.png images/pipeline.png

# Render a PNG from a GraphViz file
%.png: %.gv
	unflatten -fc9 -l9 $< |dot -Tpng >$@

# Create a GraphViz file from this Makefile
Makefile.gv: Makefile
	$(MAKE) -Bnd all |make2graph >$@

# Create a GraphViz file from a Makefile
%/Makefile.gv: %/Makefile
	$(MAKE) -C $* -Bnd all |make2graph >$@
