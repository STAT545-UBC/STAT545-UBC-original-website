# The many flavors of R objects



> "Rigor and clarity are not synonymous" -- Larry Wasserman

> "Never hesitate to sacrifice truth for clarity." -- Greg Wilson's dad

### Vectors are everywhere

Your garden variety R object is a vector. A single piece of info that you regard as a scalar is just a vector of length 1 and R will cheerfully let you add stuff to it. Square brackets are used for isolating elements of a vector for inspection, modification, etc. This is often called __indexing__. Go through the following code carefully, as it's really rather surprising. BTW, indexing begins at 1 in R, unlike many other languages that index from 0.


```r
x <- 3 * 4
x
```

```
## [1] 12
```

```r
is.vector(x)
```

```
## [1] TRUE
```

```r
length(x)
```

```
## [1] 1
```

```r
x[2] <- 100
x
```

```
## [1]  12 100
```

```r
x[5] <- 3
x
```

```
## [1]  12 100  NA  NA   3
```

```r
x[11]
```

```
## [1] NA
```

```r
x[0]
```

```
## numeric(0)
```

R is built to work with vectors. Many operations are *vectorized*, i.e. by default they will happen component-wise when given a vector as input. Newbies often don't internalize or exploit this and they write lots of unnecessary `for` loops.

```r
x <- 1:4
## which would you rather write and read?
## the vectorized version ...
(y <- x^2) 
```

```
## [1]  1  4  9 16
```

```r
## or the for loop version?
z <- vector(mode = mode(x), length = length(x))
for(i in seq_along(x)) {
  z[i] <- x[i]^2
}
identical(y, z)
```

```
## [1] TRUE
```

When reading function documentation, keep your eyes peeled for arguments that can be vectors. You'll be surprised how common they are. For example, the mean and standard deviation of random normal variates can be provided as vectors.

```r
set.seed(1999)
rnorm(5, mean = 10^(1:5))
```

```
## [1]     10.73     99.96   1001.20  10001.47 100000.13
```

```r
round(rnorm(5, sd = 10^(0:4)), 2)
```

```
## [1]     0.52    -5.49  -118.56 -1147.28 11607.42
```
This could be awesome in some settings, but dangerous in others, i.e. if you exploit this by mistake and get no warning. This is one of the reasons it's so important to keep close tabs on your R objects: are they what you expect in terms of their flavor and length or dimensions? Check early and check often.

Notice that R also recycles vectors, if they are not the necessary length. You will get a warning if R suspects recycling is unintended, i.e. when one length is not an integer multiple of another, but recycling is silent if it seems like you know what you're doing. Can be a beautiful thing when you're doing this deliberately, but devasting when you don't.

> Question: is there a way to turn recycling off? Not that I know of.


```r
(y <- 1:3)
```

```
## [1] 1 2 3
```

```r
(z <- 3:7)
```

```
## [1] 3 4 5 6 7
```

```r
y + z
```

```
## Warning: longer object length is not a multiple of shorter object length
```

```
## [1] 4 6 8 7 9
```

```r
(y <- 1:10)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

```r
(z <- 3:7)
```

```
## [1] 3 4 5 6 7
```

```r
y + z
```

```
##  [1]  4  6  8 10 12  9 11 13 15 17
```

The catenate function `c()` is your go-to function for making vectors.


```r
str(c("hello", "world"))
```

```
##  chr [1:2] "hello" "world"
```

```r
str(c(1:3, 100, 150))
```

```
##  num [1:5] 1 2 3 100 150
```

Plain vanilla R objects are called "atomic vectors" and an absolute requirement is that all the bits of info they hold are of the same flavor, i.e. all numeric or logical or character. If that's not already true upon creation, the elements will be coerced to the same flavor, using a "lowest common denominator" approach (usually character). This is another stellar opportunity for you to create an object of one flavor without meaning to do so and to remain ignorant of that for a long time. Check early, check often.


```r
(x <- c("cabbage", pi, TRUE, 4.3))
```

```
## [1] "cabbage"          "3.14159265358979" "TRUE"            
## [4] "4.3"
```

```r
str(x)
```

```
##  chr [1:4] "cabbage" "3.14159265358979" "TRUE" "4.3"
```

```r
length(x)
```

```
## [1] 4
```

```r
mode(x)
```

```
## [1] "character"
```

```r
class(x)
```

```
## [1] "character"
```

The most important atomic vector types are

  * logical: TRUE's AND FALSE's, easily coerced into 1's and 0's
  * numeric: numbers and, yes, integers and double-precision floating point numbers are different but you can live happily for a long time without worrying about this
  * character

Let's create some simple vectors for more demos below.


```r
n <- 8
set.seed(1)
(w <- round(rnorm(n), 2)) # numeric floating point
```

```
## [1] -0.63  0.18 -0.84  1.60  0.33 -0.82  0.49  0.74
```

```r
(x <- 1:n) # numeric integer
```

```
## [1] 1 2 3 4 5 6 7 8
```

```r
## another way to accomplish by hand is x <- c(1, 2, 3, 4, 5, 6, 7, 8)
(y <- LETTERS[1:n]) # character
```

```
## [1] "A" "B" "C" "D" "E" "F" "G" "H"
```

```r
(z <- runif(n) > 0.3) # logical
```

```
## [1]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE
```

Use `str()` and any other functions you wish to inspect these objects, such as `length()`, `mode()`, `class()`, `is.numeric()`, `is.logical()`, etc. Like the `is.xxx()` family of functions, there are also `as.xxx()` functions you can experiment with.


```r
str(w)
```

```
##  num [1:8] -0.63 0.18 -0.84 1.6 0.33 -0.82 0.49 0.74
```

```r
length(x)
```

```
## [1] 8
```

```r
is.logical(y)
```

```
## [1] FALSE
```

```r
as.numeric(z)
```

```
## [1] 1 1 1 1 1 0 1 0
```

### Indexing a vector

We've said, and even seen, that square brackets are used to index a vector. There is great flexibility in what one can put inside the square brackets and it's worth understanding the many options. They are all useful, just in different contexts.

Most common, useful ways to index a vector

  * logical vector: keep elements associated with TRUEs, ditch the FALSEs
  * vector of positive integers specifying the keepers
  * vector of negative integers specifying the losers
  * character vector, naming the keepers


```r
w
```

```
## [1] -0.63  0.18 -0.84  1.60  0.33 -0.82  0.49  0.74
```

```r
names(w) <- letters[seq_along(w)]
w
```

```
##     a     b     c     d     e     f     g     h 
## -0.63  0.18 -0.84  1.60  0.33 -0.82  0.49  0.74
```

```r
w < 0
```

```
##     a     b     c     d     e     f     g     h 
##  TRUE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE
```

```r
which(w < 0)
```

```
## a c f 
## 1 3 6
```

```r
w[w < 0]
```

```
##     a     c     f 
## -0.63 -0.84 -0.82
```

```r
seq(from = 1, to = length(w), by = 2)
```

```
## [1] 1 3 5 7
```

```r
w[seq(from = 1, to = length(w), by = 2)]
```

```
##     a     c     e     g 
## -0.63 -0.84  0.33  0.49
```

```r
w[-c(2, 5)]
```

```
##     a     c     d     f     g     h 
## -0.63 -0.84  1.60 -0.82  0.49  0.74
```

```r
w[c('c', 'a', 'f')]
```

```
##     c     a     f 
## -0.84 -0.63 -0.82
```

### lists hold just about anything

Lists are basically über-vectors in R. It's like a vector, but with no requirement that the elements be of the same flavor. In data analysis, you won't make lists very often, at least not consciously, but you should still know about them. Why?

  * data.frames are lists! They are a special case where each element is an atomic vector, all having the same length.
  * many functions will return lists to you and you will want to extract goodies from them, such as the p-value for a hypothesis test or the estimated error variance in a regression model

Here we repeat an assignment from above, using `list()` instead of `c()` to combine things and you'll notice that the different flavors of the consitutent parts are retained this time.

```r
## earlier: a <- c("cabbage", pi, TRUE, 4.3)
(a <- list("cabbage", pi, TRUE, 4.3))
```

```
## [[1]]
## [1] "cabbage"
## 
## [[2]]
## [1] 3.142
## 
## [[3]]
## [1] TRUE
## 
## [[4]]
## [1] 4.3
```

```r
str(a)
```

```
## List of 4
##  $ : chr "cabbage"
##  $ : num 3.14
##  $ : logi TRUE
##  $ : num 4.3
```

```r
length(a)
```

```
## [1] 4
```

```r
mode(a)
```

```
## [1] "list"
```

```r
class(a)
```

```
## [1] "list"
```

List components can also have names. You can create or change names after a list already exists or this can be integrated into the initial assignment.

```r
names(a)
```

```
## NULL
```

```r
names(a) <- c("veg", "dessert", "myAim", "number")
a
```

```
## $veg
## [1] "cabbage"
## 
## $dessert
## [1] 3.142
## 
## $myAim
## [1] TRUE
## 
## $number
## [1] 4.3
```

```r
a <- list(veg = "cabbage", dessert = pi, myAim = TRUE, number = 4.3)
names(a)
```

```
## [1] "veg"     "dessert" "myAim"   "number"
```

Indexing a list is similar to indexing a vector but it is necessarily more complex. The fundamental issue is this: if you request a single element from the list, do you want a list of length 1 containing only that element or do you want the element itself? For the former (desired return value is a list), we use single square brackets, `[` and `]`, just like indexing a vector. For the latter (desired return value is a single element), we use a dollar sign `$`, which you've already used to get one variable from a data.frame, or double square brackets, `[[` and `]]`.

> Warning: the rest of this section might make your eyes glaze over. Skip to the next section if you need to; come back later when some list is ruining your day.

A slightly more complicated list will make our demos more educational. Now we really see that the elements can differ in flavor and length.


```r
(a <- list(veg = c("cabbage", "eggplant"),
           tNum = c(pi, exp(1), sqrt(2)),
           myAim = TRUE,
           joeNum = 2:6))
```

```
## $veg
## [1] "cabbage"  "eggplant"
## 
## $tNum
## [1] 3.142 2.718 1.414
## 
## $myAim
## [1] TRUE
## 
## $joeNum
## [1] 2 3 4 5 6
```

```r
str(a)
```

```
## List of 4
##  $ veg   : chr [1:2] "cabbage" "eggplant"
##  $ tNum  : num [1:3] 3.14 2.72 1.41
##  $ myAim : logi TRUE
##  $ joeNum: int [1:5] 2 3 4 5 6
```

```r
length(a)
```

```
## [1] 4
```

```r
class(a)
```

```
## [1] "list"
```

```r
mode(a)
```

```
## [1] "list"
```

Here's are ways to get a single list element:

```r
a[[2]] # index with a positive integer
```

```
## [1] 3.142 2.718 1.414
```

```r
a$myAim # use dollar sign and element name
```

```
## [1] TRUE
```

```r
str(a$myAim) # we get myAim itself, a length 1 logical vector
```

```
##  logi TRUE
```

```r
a[["tNum"]] # index with length 1 character vector 
```

```
## [1] 3.142 2.718 1.414
```

```r
str(a[["tNum"]]) # we get tNum itself, a length 3 numeric vector
```

```
##  num [1:3] 3.14 2.72 1.41
```

```r
iWantThis <- "joeNum" # indexing with length 1 character object
a[[iWantThis]] # we get joeNum itself, a length 5 integer vector
```

```
## [1] 2 3 4 5 6
```

```r
a[[c("joeNum", "veg")]] # does not work! can't get > 1 elements! see below
```

```
## Error: subscript out of bounds
```
A case when one must use the double bracket approach, as opposed to the dollar sign, is when the indexing object itself is an R object; we show that above.

What if you want more than one element? You must index vector-style with single square brackets. Note that the return value will always be a list, unlike the return value from double square brackets, even if you only request 1 element.


```r
names(a)
```

```
## [1] "veg"    "tNum"   "myAim"  "joeNum"
```

```r
a[c("tNum", "veg")] # indexing by length 2 character vector
```

```
## $tNum
## [1] 3.142 2.718 1.414
## 
## $veg
## [1] "cabbage"  "eggplant"
```

```r
str(a[c("tNum", "veg")]) # returns list of length 2
```

```
## List of 2
##  $ tNum: num [1:3] 3.14 2.72 1.41
##  $ veg : chr [1:2] "cabbage" "eggplant"
```

```r
a["veg"] # indexing by length 1 character vector
```

```
## $veg
## [1] "cabbage"  "eggplant"
```

```r
str(a["veg"])# returns list of length 1
```

```
## List of 1
##  $ veg: chr [1:2] "cabbage" "eggplant"
```

```r
length(a["veg"]) # really, it does!
```

```
## [1] 1
```

```r
length(a["veg"][[1]]) # contrast with length of the veg vector itself
```

```
## [1] 2
```

### Creating a data.frame explicitly

In data analysis, we often import data into data.frame via `read.table()`. But one can also construct a data.frame directly using `data.frame()`.


```r
n <- 8
set.seed(1)
(jDat <- data.frame(w = round(rnorm(n), 2),
                    x = 1:n,
                    y = I(LETTERS[1:n]),
                    z = runif(n) > 0.3,
                    v = rep(LETTERS[9:12], each = 2)))
```

```
##       w x y     z v
## 1 -0.63 1 A  TRUE I
## 2  0.18 2 B  TRUE I
## 3 -0.84 3 C  TRUE J
## 4  1.60 4 D  TRUE J
## 5  0.33 5 E  TRUE K
## 6 -0.82 6 F FALSE K
## 7  0.49 7 G  TRUE L
## 8  0.74 8 H FALSE L
```

```r
str(jDat)
```

```
## 'data.frame':	8 obs. of  5 variables:
##  $ w: num  -0.63 0.18 -0.84 1.6 0.33 -0.82 0.49 0.74
##  $ x: int  1 2 3 4 5 6 7 8
##  $ y:Class 'AsIs'  chr [1:8] "A" "B" "C" "D" ...
##  $ z: logi  TRUE TRUE TRUE TRUE TRUE FALSE ...
##  $ v: Factor w/ 4 levels "I","J","K","L": 1 1 2 2 3 3 4 4
```

```r
mode(jDat)
```

```
## [1] "list"
```

```r
class(jDat)
```

```
## [1] "data.frame"
```

> Sidebar: What is `I()`, used when creating the variable $y$ in the above data.frame? Short version: it tells R to do something _quite literally_. Here we are protecting the letters from being coerced to factor. We are ensuring we get a character vector. Note we let character-to-factor conversion happen in creating the $v$ variable above. More about (foiling) R's determination to convert character data to factor can be found [here](block08_bossYourFactors.html).

data.frames really are lists! Double square brackets can be used to get individual variables. Single square brackets can be used to get one or more variables, returned as a data.frame (though `subset(..., select = ...))` is how I would more likely do in a data analysis).


```r
is.list(jDat) # data.frames are lists
```

```
## [1] TRUE
```

```r
jDat[[5]] # this works but I prefer ...
```

```
## [1] I I J J K K L L
## Levels: I J K L
```

```r
jDat$v # using dollar sign and name, when possible
```

```
## [1] I I J J K K L L
## Levels: I J K L
```

```r
jDat[c("x", "z")] # get multiple variables
```

```
##   x     z
## 1 1  TRUE
## 2 2  TRUE
## 3 3  TRUE
## 4 4  TRUE
## 5 5  TRUE
## 6 6 FALSE
## 7 7  TRUE
## 8 8 FALSE
```

```r
str(jDat[c("x", "z")]) # returns a data.frame
```

```
## 'data.frame':	8 obs. of  2 variables:
##  $ x: int  1 2 3 4 5 6 7 8
##  $ z: logi  TRUE TRUE TRUE TRUE TRUE FALSE ...
```

```r
identical(subset(jDat, select = c(x, z)), jDat[c("x", "z")])
```

```
## [1] TRUE
```

> Question: How do I make a data.frame from a list? It is an absolute requirement that the constituent vectors have the same length, although they can be of different flavors. Assuming you meet that requirement, use `as.data.frame()` to convert.


```r
## note difference in the printing of a list vs. a data.frame
(qDat <- list(w = round(rnorm(n), 2),
              x = 1:(n-1), ## <-- LOOK HERE! I MADE THIS VECTOR SHORTER!
              y = I(LETTERS[1:n])))
```

```
## $w
## [1] -0.62 -2.21  1.12 -0.04 -0.02  0.94  0.82  0.59
## 
## $x
## [1] 1 2 3 4 5 6 7
## 
## $y
## [1] "A" "B" "C" "D" "E" "F" "G" "H"
```

```r
as.data.frame(qDat) ## does not work! elements don't have same length!
```

```
## Error: arguments imply differing number of rows: 8, 7
```

```r
qDat$x <- 1:n ## fix the short variable x
(qDat <- as.data.frame(qDat)) ## we're back in business
```

```
##       w x y
## 1 -0.62 1 A
## 2 -2.21 2 B
## 3  1.12 3 C
## 4 -0.04 4 D
## 5 -0.02 5 E
## 6  0.94 6 F
## 7  0.82 7 G
## 8  0.59 8 H
```

You will encounter weirder situations in which you want to make a data.frame out of a list and there are many tricks. Ask me and we'll beef up this section.

### Indexing arrays, e.g. matrices

Though data.frames are recommended as the default receptacle for rectangular data, there are times when one will store rectangular data as a matrix instead. A matrix is a generalization of an atomic vector and the requirement that all the elements be of the same flavor still holds. General arrays are available in R, where a matrix is an important special case having dimension 2.

Let's make a simple matrix and give it decent row and column names, which we know is a good practice. You'll see familiar or self-explanatory functions below for getting to know a matrix.


```r
## don't worry if the construction of this matrix confuses you; just focus on
## the product
jMat <- outer(as.character(1:4), as.character(1:4),
              function(x, y) {
                paste0('x', x, y)
                })
jMat
```

```
##      [,1]  [,2]  [,3]  [,4] 
## [1,] "x11" "x12" "x13" "x14"
## [2,] "x21" "x22" "x23" "x24"
## [3,] "x31" "x32" "x33" "x34"
## [4,] "x41" "x42" "x43" "x44"
```

```r
str(jMat)
```

```
##  chr [1:4, 1:4] "x11" "x21" "x31" "x41" "x12" "x22" ...
```

```r
class(jMat)
```

```
## [1] "matrix"
```

```r
mode(jMat)
```

```
## [1] "character"
```

```r
dim(jMat)
```

```
## [1] 4 4
```

```r
nrow(jMat)
```

```
## [1] 4
```

```r
ncol(jMat)
```

```
## [1] 4
```

```r
rownames(jMat)
```

```
## NULL
```

```r
rownames(jMat) <- paste0("row", seq_len(nrow(jMat)))
colnames(jMat) <- paste0("col", seq_len(ncol(jMat)))
dimnames(jMat) # also useful for assignment
```

```
## [[1]]
## [1] "row1" "row2" "row3" "row4"
## 
## [[2]]
## [1] "col1" "col2" "col3" "col4"
```

```r
jMat
```

```
##      col1  col2  col3  col4 
## row1 "x11" "x12" "x13" "x14"
## row2 "x21" "x22" "x23" "x24"
## row3 "x31" "x32" "x33" "x34"
## row4 "x41" "x42" "x43" "x44"
```

Indexing a matrix is very similar to indexing a vector or a list: use square brackets and index with logical, integer numeric (positive or negative), or character vectors. Combine those approaches if you like! The main new wrinkle is the use of a comma `,` to distinguish rows and columns. The $i,j$-th element is the element at the intersection of row $i$ and column $j$ and is obtained with `jMat[i, j]`. Request an entire row or an entire column by simplying leaving the associated index empty. The `drop =` argument controls whether the return value should be an atomic vector (`drop = TRUE`) or a matrix with a single row or column (`drop = FALSE`). Notice how row and column names persist and can help you stay oriented.


```r
jMat[2, 3]
```

```
## [1] "x23"
```

```r
jMat[2, ] # getting row 2
```

```
##  col1  col2  col3  col4 
## "x21" "x22" "x23" "x24"
```

```r
is.vector(jMat[2, ]) # we get row 2 as an atomic vector
```

```
## [1] TRUE
```

```r
jMat[ , 3, drop = FALSE] # getting column 3
```

```
##      col3 
## row1 "x13"
## row2 "x23"
## row3 "x33"
## row4 "x43"
```

```r
dim(jMat[ , 3, drop = FALSE]) # we get column 3 as a 4 x 1 matrix
```

```
## [1] 4 1
```

```r
jMat[c("row1", "row4"), c("col2", "col3")]
```

```
##      col2  col3 
## row1 "x12" "x13"
## row4 "x42" "x43"
```

```r
jMat[-c(2, 3), c(TRUE, TRUE, FALSE, FALSE)] # wacky but possible
```

```
##      col1  col2 
## row1 "x11" "x12"
## row4 "x41" "x42"
```

Under the hood, of course, matrices are just vectors with some extra facilities for indexing. R is a [column-major order](http://en.wikipedia.org/wiki/Row-major_order) language, in contrast to C and Python which use row-major order. What this means is that in the underlying vector storage of a matrix, the columns are stacked up one after the other. Matrices can be indexed *exactly* like a vector, i.e. with no comma $i,j$ business, like so:

```r
jMat[7]
```

```
## [1] "x32"
```

```r
jMat
```

```
##      col1  col2  col3  col4 
## row1 "x11" "x12" "x13" "x14"
## row2 "x21" "x22" "x23" "x24"
## row3 "x31" "x32" "x33" "x34"
## row4 "x41" "x42" "x43" "x44"
```
How to understand this: start counting in the upper left corner, move down the column, continue  from the top of column 2 and you'll land on the element "x32" when you get to 7.

If you have meaningful, systematic row or column names, there are many possibilities for indexing via regular expressions. Maybe we will talk about `grep` later....

```r
jMat[1, grepl("[24]", colnames(jMat))]
```

```
##  col2  col4 
## "x12" "x14"
```

Note also that one can put an indexed matrix on the receiving end of an assignment operation and, as long as your replacement values have valid shape or extent, you can change the matrix.

```r
jMat["row1", 2:3] <- c("HEY!", "THIS IS NUTS!")
jMat
```

```
##      col1  col2   col3            col4 
## row1 "x11" "HEY!" "THIS IS NUTS!" "x14"
## row2 "x21" "x22"  "x23"           "x24"
## row3 "x31" "x32"  "x33"           "x34"
## row4 "x41" "x42"  "x43"           "x44"
```

Note that R can also work with vectors and matrices in the proper mathematical sense, i.e. perform matrix algebra. That is a separate topic. To get you started, read the help on `%*%` for matrix multiplication ...

### Creating arrays, e.g. matrices

There are 3 main ways to create a matrix. It goes without saying that the inputs must comply with the requirement that all matrix elements are the same flavor. If that's not true, you risk an error or, worse, silent conversion to character.

  * Filling a matrix with a vector
  * Glueing vectors together as rows or columns
  * Conversion of a data.frame

Let's demonstrate. Here we fill a matrix with a vector, explore filling by rows and giving row and columns at creation. Notice that recycling happens here too, so if the input vector is not large enough, R will recycle it.


```r
matrix(1:15, nrow = 5)
```

```
##      [,1] [,2] [,3]
## [1,]    1    6   11
## [2,]    2    7   12
## [3,]    3    8   13
## [4,]    4    9   14
## [5,]    5   10   15
```

```r
matrix("yo!", nrow = 3, ncol = 6)
```

```
##      [,1]  [,2]  [,3]  [,4]  [,5]  [,6] 
## [1,] "yo!" "yo!" "yo!" "yo!" "yo!" "yo!"
## [2,] "yo!" "yo!" "yo!" "yo!" "yo!" "yo!"
## [3,] "yo!" "yo!" "yo!" "yo!" "yo!" "yo!"
```

```r
matrix(c("yo!", "foo?"), nrow = 3, ncol = 6)
```

```
##      [,1]   [,2]   [,3]   [,4]   [,5]   [,6]  
## [1,] "yo!"  "foo?" "yo!"  "foo?" "yo!"  "foo?"
## [2,] "foo?" "yo!"  "foo?" "yo!"  "foo?" "yo!" 
## [3,] "yo!"  "foo?" "yo!"  "foo?" "yo!"  "foo?"
```

```r
matrix(1:15, nrow = 5, byrow = TRUE)
```

```
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
## [3,]    7    8    9
## [4,]   10   11   12
## [5,]   13   14   15
```

```r
matrix(1:15, nrow = 5,
       dimnames = list(paste0("row", 1:5),
                       paste0("col", 1:3)))
```

```
##      col1 col2 col3
## row1    1    6   11
## row2    2    7   12
## row3    3    8   13
## row4    4    9   14
## row5    5   10   15
```

Here we create a matrix by glueing vectors together. Watch the vector names propagate as row or column names.


```r
vec1 <- 5:1
vec2 <- 2^(1:5)
cbind(vec1, vec2)
```

```
##      vec1 vec2
## [1,]    5    2
## [2,]    4    4
## [3,]    3    8
## [4,]    2   16
## [5,]    1   32
```

```r
rbind(vec1, vec2)
```

```
##      [,1] [,2] [,3] [,4] [,5]
## vec1    5    4    3    2    1
## vec2    2    4    8   16   32
```

Here we create a matrix from a data.frame.


```r
vecDat <- data.frame(vec1 = 5:1,
                     vec2 = 2^(1:5))
str(vecDat)
```

```
## 'data.frame':	5 obs. of  2 variables:
##  $ vec1: int  5 4 3 2 1
##  $ vec2: num  2 4 8 16 32
```

```r
vecMat <- as.matrix(vecDat)
str(vecMat)
```

```
##  num [1:5, 1:2] 5 4 3 2 1 2 4 8 16 32
##  - attr(*, "dimnames")=List of 2
##   ..$ : NULL
##   ..$ : chr [1:2] "vec1" "vec2"
```

Here we create a matrix from a data.frame, but experience the "silently convert everything to character" fail. As an added bonus, I'm also allowing the "convert character to factor" thing to happen when we create the data.frame initially. Let this be a reminder to take control of your objects!


```r
multiDat <- data.frame(vec1 = 5:1,
                       vec2 = paste0("hi", 1:5))
str(multiDat)
```

```
## 'data.frame':	5 obs. of  2 variables:
##  $ vec1: int  5 4 3 2 1
##  $ vec2: Factor w/ 5 levels "hi1","hi2","hi3",..: 1 2 3 4 5
```

```r
(multiMat <- as.matrix(multiDat))
```

```
##      vec1 vec2 
## [1,] "5"  "hi1"
## [2,] "4"  "hi2"
## [3,] "3"  "hi3"
## [4,] "2"  "hi4"
## [5,] "1"  "hi5"
```

```r
str(multiMat)
```

```
##  chr [1:5, 1:2] "5" "4" "3" "2" "1" "hi1" "hi2" "hi3" ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : NULL
##   ..$ : chr [1:2] "vec1" "vec2"
```

### Putting it all together ... implications for data.frames

This behind the scenes tour is still aimed at making you a better data analyst. Hopefully the slog through vectors, matrices, and lists will be redeemed by greater prowess at manipulating data.frames. Why should this be true?

  * a data.frame is a *list*
  * the list elements are the variables and they are *atomic vectors*
  * data.frames are rectangular, like their matrix friends, so your intuition -- and even some syntax -- can be borrowed from the matrix world

A data.frame is a list that quacks like a matrix.

Reviewing list-style indexing of a data.frame:

```r
jDat
```

```
##       w x y     z v
## 1 -0.63 1 A  TRUE I
## 2  0.18 2 B  TRUE I
## 3 -0.84 3 C  TRUE J
## 4  1.60 4 D  TRUE J
## 5  0.33 5 E  TRUE K
## 6 -0.82 6 F FALSE K
## 7  0.49 7 G  TRUE L
## 8  0.74 8 H FALSE L
```

```r
jDat$z
```

```
## [1]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE
```

```r
iWantThis <- "z"
jDat[[iWantThis]]
```

```
## [1]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE
```

```r
str(jDat[[iWantThis]]) # we get an atomic vector
```

```
##  logi [1:8] TRUE TRUE TRUE TRUE TRUE FALSE ...
```

Reviewing vector-style indexing of a data.frame:

```r
jDat["y"]
```

```
##   y
## 1 A
## 2 B
## 3 C
## 4 D
## 5 E
## 6 F
## 7 G
## 8 H
```

```r
str(jDat["y"]) # we get a data.frame with one variable, y
```

```
## 'data.frame':	8 obs. of  1 variable:
##  $ y:Class 'AsIs'  chr [1:8] "A" "B" "C" "D" ...
```

```r
iWantThis <- c("w", "v")
jDat[iWantThis] # index with a vector of variable names
```

```
##       w v
## 1 -0.63 I
## 2  0.18 I
## 3 -0.84 J
## 4  1.60 J
## 5  0.33 K
## 6 -0.82 K
## 7  0.49 L
## 8  0.74 L
```

```r
str(jDat[c("w", "v")])
```

```
## 'data.frame':	8 obs. of  2 variables:
##  $ w: num  -0.63 0.18 -0.84 1.6 0.33 -0.82 0.49 0.74
##  $ v: Factor w/ 4 levels "I","J","K","L": 1 1 2 2 3 3 4 4
```

```r
str(subset(jDat, select = c(w, v))) # using subset() function
```

```
## 'data.frame':	8 obs. of  2 variables:
##  $ w: num  -0.63 0.18 -0.84 1.6 0.33 -0.82 0.49 0.74
##  $ v: Factor w/ 4 levels "I","J","K","L": 1 1 2 2 3 3 4 4
```

Demonstrating matrix-style indexing of a data.frame:

```r
jDat[ , "v"]
```

```
## [1] I I J J K K L L
## Levels: I J K L
```

```r
str(jDat[ , "v"])
```

```
##  Factor w/ 4 levels "I","J","K","L": 1 1 2 2 3 3 4 4
```

```r
jDat[ , "v", drop = FALSE]
```

```
##   v
## 1 I
## 2 I
## 3 J
## 4 J
## 5 K
## 6 K
## 7 L
## 8 L
```

```r
str(jDat[ , "v", drop = FALSE])
```

```
## 'data.frame':	8 obs. of  1 variable:
##  $ v: Factor w/ 4 levels "I","J","K","L": 1 1 2 2 3 3 4 4
```

```r
jDat[c(2, 4, 7), c(1, 4)] # awful and arbitrary but syntax works
```

```
##      w    z
## 2 0.18 TRUE
## 4 1.60 TRUE
## 7 0.49 TRUE
```

```r
jDat[jDat$z, ]
```

```
##       w x y    z v
## 1 -0.63 1 A TRUE I
## 2  0.18 2 B TRUE I
## 3 -0.84 3 C TRUE J
## 4  1.60 4 D TRUE J
## 5  0.33 5 E TRUE K
## 7  0.49 7 G TRUE L
```

```r
subset(jDat, subset = z)
```

```
##       w x y    z v
## 1 -0.63 1 A TRUE I
## 2  0.18 2 B TRUE I
## 3 -0.84 3 C TRUE J
## 4  1.60 4 D TRUE J
## 5  0.33 5 E TRUE K
## 7  0.49 7 G TRUE L
```

### Table of atomic R object flavors

> This table will be hideous unless Pandoc is used to compile.

+-----------+---------------+-----------+-----------+
| "flavor"  | type reported | mode()    | class()   |
|           | by typeof()   |           |           |
+===========+===============+===========+===========+
| character | character     | character | character |
+-----------+---------------+-----------+-----------+
| logical   | logical       | logical   | logical   |
+-----------+---------------+-----------+-----------+
| numeric   | integer       | numeric   | integer   |
|           | or double     |           | or double |
+-----------+---------------+-----------+-----------+
| factor    | integer       | numeric   | factor    |
+-----------+---------------+-----------+-----------+

> This should be legible no matter what.

```
+-----------+---------------+-----------+-----------+
| "flavor"  | type reported | mode()    | class()   |
|           | by typeof()   |           |           |
+===========+===============+===========+===========+
| character | character     | character | character |
+-----------+---------------+-----------+-----------+
| logical   | logical       | logical   | logical   |
+-----------+---------------+-----------+-----------+
| numeric   | integer       | numeric   | integer   |
|           | or double     |           | or double |
+-----------+---------------+-----------+-----------+
| factor    | integer       | numeric   | factor    |
+-----------+---------------+-----------+-----------+
```

Thinking about objects according to the flavors above will work fairly well for most purposes most of the time, at least when you're first getting started. Notice that most rows in the table are quite homogeneous, i.e. a logical vector is a logical vector is a logical vector. But the row pertaining to factors is an exception, which highlights the special nature of factors. (for more, go [here](block08_bossYourFactors.html)).

> JB note to self. Possible TO ADD but probably belongs in separate tutorial on changing and adding to data.frames: cbind and rbind with data.frames, transform(). do.call() tricks for data.frames. adding/removing variables to/from data.frames. Does this belong in earlier tutorial on the care and feeding of a data.frame? Fits in well with subset(), after all.
