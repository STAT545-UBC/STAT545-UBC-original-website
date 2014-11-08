library(ggplot2)
library(plyr)

lotr_dat <- read.delim("lotr_clean.tsv")

## infer order of Race and Film factors from order in file
lotr_dat <-
  within(lotr_dat, {
    Race <- factor(as.character(Race), levels = unique(Race))
    Film <- factor(as.character(Film), levels = unique(Film))
  })
## WARNING: probably not a safe long-run strategy for communicating factor level
## order with plain text data files; I see no guarantees that unique() return 
## value will be in any particular order; I have just noticed anecdotally that
## return value is in order of appearance

## for each Film, write stripplot to file
d_ply(lotr_dat, ~ Film, function(z) {
  the_film <- z$Film[1]
  p <- ggplot(z, aes(x = Race, y = Words)) + scale_y_log10() +
    ggtitle(the_film) + 
    geom_jitter(alpha = 1/2, position = position_jitter(width = 0.1))
  print(p)
  the_film <- gsub(" ", "-", the_film)
  ggsave(paste0("stripplot_words-by-race_", the_film, ".png"))
})

## write the total words by Race for each Film to file
write.table(ddply(lotr_dat, ~ Film + Race, summarize, total_words = sum(Words)),
            "total-words-by-film-race.tsv", quote = FALSE,
            sep = "\t", row.names = FALSE)
