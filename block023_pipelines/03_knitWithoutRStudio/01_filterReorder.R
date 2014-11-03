library(ggplot2)
library(plyr)

lotrDat <- read.delim("lotr_raw.tsv")
str(lotrDat)
tail(lotrDat)

## reorder Film factor based on story
oldFilm <- levels(lotrDat$Film)
foo <- data.frame(oldFilm = oldFilm)
jOrder <- sapply(c("Fellowship", "Towers", "Return"),
                 function(x) grep(x, oldFilm))
lotrDat <- within(lotrDat,
                  Film <- factor(as.character(lotrDat$Film),
                                 oldFilm[jOrder]))
foo$newFilm <- levels(lotrDat$Film)
foo

## no one knows that the Ainur are the wizards
## Men should be Man, for consistency
foo <- data.frame(oldRace = levels(lotrDat$Race))
lotrDat <-
  within(lotrDat, Race <- revalue(Race, c(Ainur = "Wizard", Men = "Man")))
foo$newRace <- levels(lotrDat$Race)
foo

## drop some observations and unused factor levels
lotrDat <-
  droplevels(subset(lotrDat,
                    !(Race %in% c("Gollum", "Ent", "Dead", "Nazgul"))))

## reorder Race based on words spoken
lotrDat <- within(lotrDat, Race <- reorder(Race, Words, sum))
levels(lotrDat$Race)

## make a plot
p <- ggplot(lotrDat, aes(x = Race, weight = Words))
p + geom_bar()
dev.print(png, "barchart_totalWords.png", width = 7 * 72, height = 7 * 72)

## using ggsave() led to the undesirable automatic writing of my figures to
## Rplots.pdf
## this thread seemed helpful ... but did not work for me
##http://stackoverflow.com/questions/17348359/how-to-stop-r-from-creating-empty-rplots-png-file-when-using-ggsave-and-rscript

png("barchart_totalWordsFilmDodge.png")
p + geom_bar(aes(fill = Film), position = position_dodge(width = 0.7))
dev.off()

## reorder data itself
lotrDat <- arrange(lotrDat, Race, Film, Words)
tail(lotrDat)

## write data to file
write.table(lotrDat, "lotr_clean.tsv", quote = FALSE,
            sep = "\t", row.names = FALSE)