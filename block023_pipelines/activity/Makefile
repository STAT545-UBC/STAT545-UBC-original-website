all: report.html

clean:
	rm -f words.tsv histogram.tsv histogram.png report.html

.PHONY: all clean
.DELETE_ON_ERROR:
.SECONDARY:

# Download the dictionary
words.tsv:
	Rscript -e 'cat(file="$@", RCurl::getURL("https://raw.githubusercontent.com/eneko/data-repository/master/data/words.txt"))'

# Copy the dictionary to our working directory.
# This rules works on Mac OS and Linux, but not on Windows.
#words.tsv: /usr/share/dict/words
#	cp $< $@

# Generate a table of the word length frequency
histogram.tsv: histogram.r words.tsv
	Rscript $<

# Plot a histogram of word lengths
histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data = read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

# Render the report
report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'

# The following two rules calculate the table of word length frequency using
# shell commands instead of an R script.

# Count the length of each word using awk
#lengths.tsv: words.tsv
#	awk '{print length}' $< >$@

# Generate a histogram of the word lengths using shell commands
#histogram.tsv: lengths.tsv
#	sort -n $< |uniq -c |awk 'BEGIN{print "Freq\tLength"} {print $$1 "\t" $$2}' >$@
