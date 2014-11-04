words <- read.delim("words.tsv", stringsAsFactors = FALSE)[[1]]
Length <- nchar(words)
counts <- table(Length)
write.table(counts, "histogram.tsv",
	sep = "\t", row.names = FALSE, quote = FALSE)
