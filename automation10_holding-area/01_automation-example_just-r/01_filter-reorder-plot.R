library(ggplot2)
library(dplyr)
# FYI: there is one call to plyr::revalue() so plyr should be installed but not
# loaded

lotr_dat <- read.delim("lotr_raw.tsv")

## reorder Film factor levels based on story
old_levels <- levels(lotr_dat$Film)
j_order <- sapply(c("Fellowship", "Towers", "Return"),
									function(x) grep(x, old_levels))
new_levels <- old_levels[j_order]

## apply new factor levels to Film
## revalue Race
##   - no one knows that the Ainur are the wizards: Ainur --> Wizard
##   - let's be consistent: Men --> Man
## drop least frequent Races
## reorder Race based on words spoken
## arrange the data on Race, Film, Words
lotr_dat <- lotr_dat %>%
	mutate(Film = factor(as.character(Film), new_levels),
				 Race = plyr::revalue(Race, c(Ainur = "Wizard", Men = "Man"))) %>%
	filter(!(Race %in% c("Gollum", "Ent", "Dead", "Nazgul"))) %>%
	mutate(Race = reorder(Race, Words, sum)) %>%
	arrange(Race, Film, Words) %>%
	droplevels

## make a plot
p <- ggplot(lotr_dat, aes(x = Race, weight = Words)) + geom_bar()
ggsave("barchart_total-words-by-race.png", p)

## write data to file
write.table(lotr_dat, "lotr_clean.tsv", quote = FALSE,
            sep = "\t", row.names = FALSE)
