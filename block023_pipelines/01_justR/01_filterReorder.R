library(ggplot2)
library(plyr)

lotrDat <- read.delim("lotr_raw.tsv")

## reorder Film factor based on story
oldLevels <- levels(lotrDat$Film)
jOrder <- sapply(c("Fellowship", "Towers", "Return"),
                 function(x) grep(x, oldLevels))
lotrDat <- within(lotrDat,
                  Film <- factor(as.character(lotrDat$Film),
                                 oldLevels[jOrder]))

## no one knows that the Ainur are the wizards
## Men should be Man, for consistency
lotrDat <-
  within(lotrDat, Race <- revalue(Race, c(Ainur = "Wizard", Men = "Man")))

## drop some observations and unused factor levels
lotrDat <-
  droplevels(subset(lotrDat,
                    !(Race %in% c("Gollum", "Ent", "Dead", "Nazgul"))))

## reorder Race based on words spoken
lotrDat <- within(lotrDat, Race <- reorder(Race, Words, sum))

## make a plot
p <- ggplot(lotrDat, aes(x = Race, weight = Words))
p + geom_bar()
ggsave("barchart_totalWords.png")

p + geom_bar(aes(fill = Film), position = position_dodge(width = 0.7))
ggsave("barchart_totalWordsFilmDodge.png")

## reorder data itself
lotrDat <- arrange(lotrDat, Race, Film, Words)

## write data to file
write.table(lotrDat, "lotr_clean.tsv", quote = FALSE,
            sep = "\t", row.names = FALSE)