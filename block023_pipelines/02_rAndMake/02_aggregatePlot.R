library(ggplot2)
library(plyr)

lotrDat <- read.delim("lotr_clean.tsv")

## infer order of Race and Film factors from order in file
lotrDat <-
  within(lotrDat, {
    Race <- factor(as.character(Race), levels = unique(lotrDat$Race))
    Film <- factor(as.character(Film), levels = unique(lotrDat$Film))
  })
## WARNING: probably not a safe long-run strategy for communicating factor level
## order with plain text data files; I see no guarantees that unique() return 
## value will be in any particular order; I have just noticed anecdotally that
## return value is in order of appearance

## for each Film, write stripplot to file
d_ply(lotrDat, ~ Film, function(z) {
  theFilm <- z$Film[1]
  p <- ggplot(z, aes(x = Race, y = Words)) + scale_y_log10() +
    ggtitle(theFilm) + 
    geom_jitter(alpha = 1/2, position = position_jitter(width = 0.1))
  theFilm <- gsub(" ", "_", theFilm)
  png(paste0("stripplot_wordsByRace_", theFilm, ".png"))
  print(p)
  dev.off()
})

## write the total words by Race for each Film to file
write.table(ddply(lotrDat, ~ Film + Race, summarize, totalWords = sum(Words)),
            "totalWordsByFilmRace.tsv", quote = FALSE,
            sep = "\t", row.names = FALSE)




