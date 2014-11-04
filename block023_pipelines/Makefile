all: slides.html

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
	pandoc -st revealjs --template $* -V theme:sky -o $@ $<

slides.html: images/article.png images/pipeline.png

%.png: %.gv
	unflatten -fc9 -l9 $< |dot -Tpng >$@
