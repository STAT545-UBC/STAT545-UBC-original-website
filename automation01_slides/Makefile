all: index.html

clean:
	rm -f index.html

install-deps:
	brew install pandoc

.PHONY: all clean install-deps
.DELETE_ON_ERROR:
.SECONDARY:

revealjs-2.6.2.tar.gz:
	curl -L https://github.com/hakimel/reveal.js/archive/2.6.2.tar.gz >$@

index.html: slides.md slides.revealjs
	pandoc -pst revealjs --template $* -V theme:sky -o $@ $<

index.html: images/article.png images/pipeline.png

# Render a PNG from a GraphViz file
%.png: %.gv
	unflatten -fc9 -l9 $< |dot -Tpng >$@
