## This was written by Jenny!
## our first stand-alone script
## can be source'd
## or could be run from command line
## in Rstudio, we experimented with the various buttons
## and keyboard shortcuts RStudio's provides for sending
## code to the R console

a <- 2
b <- 7
sigSq <- 0.5
n <- 400

x <- runif(n)
y <- a + b * x +
  rnorm(n, sd = sqrt(sigSq))
(avgX <- mean(x))

write(avgX, "avgX.txt")

pdf("toy-line.pdf")
plot(x, y)
abline(a, b, col = "blue", lwd = 2)
dev.off()



