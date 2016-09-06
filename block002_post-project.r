## indicative code we might type together AFTER the creation of our first
## RStudio Project

## check top of console and here that wd has changed
getwd()
## notice where file browser is now
a <- 2
b <- 3
siqSq <- 0.5 ## this typo was good actually
x <- runif(40)
y <- a + b * x + rnorm(40, sd = sqrt(sigSq))
sigSq <- 0.5
y <- a + b * x + rnorm(40, sd = sqrt(sigSq))
x
y
(avgX <- mean(x))
write(avgX, "avgX.txt")
plot(x, y)
abline(a, b, col = "orange")
dev.print(pdf, "niftyPlot.pdf")
## notice that avgX.txt and niftyPlot.pdf have appeared in swc
## this is a good start to analysis ... moving towards saving the script
## visit History pane, select keeper commands, click to source, tidy if needed
## save it as toy.R, notice default location is swc and see it appear in swc
## quit!
ls()
## notice how much gets restored: workspace, files open for editing, history, etc.
## improve code by introducing n, change a or b or line color, etc.
## experiment with ways to re-run
## command enter to walk through
## mouse-y Run to walk through
## click on Source and the items in it mini-menu
## explore the w/ and w/o echo stuff
## visit PDF in external viewer to verify that it's changing
## one small step in your workflow, giant step towards reproducibility
## search for "niftyPlot"
## wean yourself from the mouse for things like loading data and writing anything to file
## end of this block
