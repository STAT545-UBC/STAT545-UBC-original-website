# Using colors in R



### Load the Gapminder data


```r
gDat <- read.delim("gapminderDataFiveYear.txt")
str(gDat)
## 'data.frame':	1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

### Change the default plotting symbol to a solid circle

The color demos below will be more effective if the default plotting symbol is a solid circle. We limit ourselves to base R graphics in this tutorial, therefore we use `par()`, the function that queries and sets base R graphical parameters. In an interactive session or in a plain R script, do this:


```r
## how to change the plot symbol in a simple, non-knitr setting
opar <- par(pch = 19)
```

Technically, you don't need to make the assignment, but it's a good practice. We're killing two birds with one stone:

  1. Changing the default plotting symbol to a filled circle, which has code 19 in R. (Below I link to some samplers showing all the plotting symbols, FYI.)
  2. Storing the pre-existing and, in this case, default graphical parameters in `opar`.
  
When you change a graphical parameter via `par()`, the original values are returned and we're capturing them via assignment to `opar`. At the very bottom of this tutorial, we use `opar` to restore the original state. 

Big picture, it is best practice to restore the original, default state of hidden things that affect an R session. This is polite if you plan to inflict your code on others. Even if you live on an R desert island, this practice will prevent you from creating maddening little puzzles for yourself to solve in the middle of the night before a deadline.

Because of the way figures are handled by `knitr`, it is more complicated to change the default plotting symbol throughout an R Markdown document. To see how I've done it, check out a hidden chunk around here in the [source of this page](https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/block018_colors.rmd).



### Basic color specification and the default palette

I need a small well-behaved excerpt from the Gapminder data for demonstration purposes. I randomly draw 8 countries, keep their data from 2007, and sort the rows based on GDP per capita. Meet `jDat`.




```r
jDat
##         country year      pop continent lifeExp  gdpPercap
## 504     Eritrea 2007  4906585    Africa  58.040   641.3695
## 1080      Nepal 2007 28901790      Asia  63.785  1091.3598
## 276        Chad 2007 10238807    Africa  50.651  1704.0637
## 792     Jamaica 2007  2780132  Americas  72.567  7320.8803
## 396        Cuba 2007 11416987  Americas  78.273  8948.1029
## 360  Costa Rica 2007  4133884  Americas  78.782  9645.0614
## 576     Germany 2007 82400996    Europe  79.406 32170.3744
## 1152     Norway 2007  4627926    Europe  80.196 49357.1902
```

A simple scatterplot, using `plot()` from the base package `graphics`.


```r
jXlim <- c(460, 60000)
jYlim <- c(47, 82)
plot(lifeExp ~ gdpPercap, jDat, log = 'x', xlim = jXlim, ylim = jYlim,
     main = "Start your engines ...")
```

![](./block018_colors_files/figure-html/unnamed-chunk-6.png) 

You can specify color explicitly by name by supplying a character vector with one or more color names (more on those soon). If you need a color for 8 points and you input fewer, recycling will kick in. Here's what happens when you specify one or two colors via the `col =` argument of `plot()`.


```r
plot(lifeExp ~ gdpPercap, jDat, log = 'x', xlim = jXlim, ylim = jYlim,
     col = "red", main = 'col = "red"')
plot(lifeExp ~ gdpPercap, jDat, log = 'x', xlim = jXlim, ylim = jYlim,
     col = c("blue", "orange"), main = 'col = c("blue", "orange")')
```

<img src="./block018_colors_files/figure-html/unnamed-chunk-71.png" title="" alt="" width="50%" /><img src="./block018_colors_files/figure-html/unnamed-chunk-72.png" title="" alt="" width="50%" />

You can specify color explicitly with a small positive integer, which is interpreted as indexing into the current palette, which can be inspected via `palette()`. I've added these integers and the color names as labels to the figures below. The default palette contains 8 colors, which is why we're looking at data from eight countries. The default palette is ugly.


```r
plot(lifeExp ~ gdpPercap, jDat, log = 'x', xlim = jXlim, ylim = jYlim,
     col = 1:nC, main = paste0('col = 1:', nC))
with(jDat, text(x = gdpPercap, y = lifeExp, pos = 1))
plot(lifeExp ~ gdpPercap, jDat, log = 'x', xlim = jXlim, ylim = jYlim,
     col = 1:nC, main = 'the default palette()')
with(jDat, text(x = gdpPercap, y = lifeExp, labels = palette(),
                pos = rep(c(1, 3, 1), c(5, 1, 2))))     
```

<img src="./block018_colors_files/figure-html/unnamed-chunk-81.png" title="" alt="" width="50%" /><img src="./block018_colors_files/figure-html/unnamed-chunk-82.png" title="" alt="" width="50%" />

You can provide your own vector of colors instead. I am intentionally modelling best practice here too: if you're going to use custom colors, store them as an object in exactly one place, and use that object in plot calls, legend-making, etc. This makes it much easier to fiddle with your custom colors, which few of us can resist.


```r
jColors <- c('chartreuse3', 'cornflowerblue', 'darkgoldenrod1', 'peachpuff3',
             'mediumorchid2', 'turquoise3', 'wheat4', 'slategray2')
plot(lifeExp ~ gdpPercap, jDat, log = 'x', xlim = jXlim, ylim = jYlim,
     col = jColors, main = 'custom colors!')
with(jDat, text(x = gdpPercap, y = lifeExp, labels = jColors,
                pos = rep(c(1, 3, 1), c(5, 1, 2)))) 
```

![](./block018_colors_files/figure-html/unnamed-chunk-9.png) 

### What colors are available? Ditto for symbols and line types

Who would have guessed that R knows about "peachpuff3"? To see the names of all 657 the built-in colors, use `colors()`.


```r
head(colors())
## [1] "white"         "aliceblue"     "antiquewhite"  "antiquewhite1"
## [5] "antiquewhite2" "antiquewhite3"
tail(colors())
## [1] "yellow"      "yellow1"     "yellow2"     "yellow3"     "yellow4"    
## [6] "yellowgreen"
```

But it's much more exciting to see the colors displayed! Lots of people have tackled this -- for colors, plotting symbols, line types -- and put their work on the internet. Some examples:

  * I put color names [on a white background](img/r.col.white.bkgd.pdf) and [on black](img/r.col.black.bkgd.pdf) *(sorry, these are PDFs)*
  * I printed [the first 30 plotting symbols](img/r.pch.pdf) (presumably using code found elsewhere or in documentation? can't remember whom to credit) *(sorry, it's a PDF)*
  * In [Chapter 3 of R Graphics 1st edition](https://www.stat.auckland.ac.nz/~paul/RGraphics/chapter3.html), Paul Murrell shows predefined and custom line types in Figure 3.6 and plotting symbols in Figure 3.10.
  * Earl F. Glynn offers [an excellent resource](http://research.stowers-institute.org/efg/R/Color/Chart/) on R's built-in named colors.
  
### RColorBrewer

Most of us are pretty lousy at choosing colors and it's easy to spend too much time fiddling with them. [Cynthia Brewer](http://en.wikipedia.org/wiki/Cynthia_Brewer), a geographer and color specialist, has created sets of colors for print and the web and they are available in the add-on package [`RColorBrewer`](http://cran.r-project.org/web/packages/RColorBrewer/index.html). You will need to install and load this package to use.


```r
#install.packages("RColorBrewer")
library(RColorBrewer)
```

Let's look at all the associated palettes.


```r
display.brewer.all()
```

![](./block018_colors_files/figure-html/unnamed-chunk-12.png) 

They fall into three classes. From top to bottom, they are

  * sequential: great for low-to-high things where one extreme is exciting and the other is boring, like (transformations of) p-values and correlations (caveat: here I'm assuming the only exciting correlations you're likely to see are positive, i.e. near 1)
  * qualitative: great for non-ordered categorical things -- such as your typical factor, like country or continent. Note the special case "Paired" palette; example where that's useful: a non-experimental factor (e.g. type of wheat) and a binary experimental factor (e.g. untreated vs. treated).
  * diverging: great for things that range from "extreme and negative" to "extreme and positive", going through "non extreme and boring" along the way, such as t statistics and z scores and signed correlations
  
You can view a single RColorBrewer palette by specifying its name:


```r
display.brewer.pal(n = 8, name = 'Dark2')
```

![](./block018_colors_files/figure-html/unnamed-chunk-13.png) 

The package is, frankly, rather clunky, as evidenced by the requirement to specify `n` above. Sorry folks, you'll just have to cope.

Here we revisit specifying custom colors as we did above, but using a palette from RColorBrewer instead of our artisanal "peachpuff3" work of art. As before, I display the colors themselves but you'll see we're not getting the friendly names you've seen before, which brings us to our next topic.


```r
jBrewColors <- brewer.pal(n = 8, name = "Dark2")
plot(lifeExp ~ gdpPercap, jDat, log = 'x', xlim = jXlim, ylim = jYlim,
     col = jBrewColors, main = 'Dark2 qualitative palette from RColorBrewer')
with(jDat, text(x = gdpPercap, y = lifeExp, labels = jBrewColors,
                pos = rep(c(1, 3, 1), c(5, 1, 2)))) 
```

![](./block018_colors_files/figure-html/unnamed-chunk-14.png) 

### Hexadecimal RGB color specification

Instead of small positive integers and Crayola-style names, a more general and machine-readable approach to color specification is as hexadecimal triplets. Here is how the RColorBrewer Dark2 palette is actually stored:


```r
brewer.pal(n = 8, name = "Dark2")
## [1] "#1B9E77" "#D95F02" "#7570B3" "#E7298A" "#66A61E" "#E6AB02" "#A6761D"
## [8] "#666666"
```

The leading `#` is just there by convention. Parse the hexadecimal string like so: `#rrggbb`, where `rr`, `gg`, and `bb` refer to color intensity in the red, green, and blue channels, respectively. Each is specified as a two-digit base 16 number, which is the meaning of "hexadecimal" (or "hex" for short). Here's a table relating base 16 numbers to the beloved base 10 system.



<!-- html table generated in R 3.1.1 by xtable 1.7-4 package -->
<!-- Sun Oct 19 17:40:55 2014 -->
<table border=1>
<tr> <th>  </th> <th> 1 </th> <th> 2 </th> <th> 3 </th> <th> 4 </th> <th> 5 </th> <th> 6 </th> <th> 7 </th> <th> 8 </th> <th> 9 </th> <th> 10 </th> <th> 11 </th> <th> 12 </th> <th> 13 </th> <th> 14 </th> <th> 15 </th> <th> 16 </th>  </tr>
  <tr> <td align="right"> hex </td> <td> 0 </td> <td> 1 </td> <td> 2 </td> <td> 3 </td> <td> 4 </td> <td> 5 </td> <td> 6 </td> <td> 7 </td> <td> 8 </td> <td> 9 </td> <td> A </td> <td> B </td> <td> C </td> <td> D </td> <td> E </td> <td> F </td> </tr>
  <tr> <td align="right"> decimal </td> <td> 0 </td> <td> 1 </td> <td> 2 </td> <td> 3 </td> <td> 4 </td> <td> 5 </td> <td> 6 </td> <td> 7 </td> <td> 8 </td> <td> 9 </td> <td> 10 </td> <td> 11 </td> <td> 12 </td> <td> 13 </td> <td> 14 </td> <td> 15 </td> </tr>
   </table>

Example: the first color in the palette is specified as "#1B9E77", so the intensity in the green channel is 9E. What does that mean?
$$
9E = 9 * 16^1 + 14 * 16^0 = 9 * 16 + 14 = 158
$$
Note that the lowest possible channel intensity is `00` = 0 and the highest is `FF` = 255.

Important special cases that help you stay oriented. Here are the saturated RGB colors, red, blue, and green:



<!-- html table generated in R 3.1.1 by xtable 1.7-4 package -->
<!-- Sun Oct 19 17:40:55 2014 -->
<table border=1>
<tr> <th> colorName </th> <th> hex </th> <th> red </th> <th> green </th> <th> blue </th>  </tr>
  <tr> <td> blue </td> <td> #0000FF </td> <td align="right"> 0 </td> <td align="right"> 0 </td> <td align="right"> 255 </td> </tr>
  <tr> <td> green </td> <td> #00FF00 </td> <td align="right"> 0 </td> <td align="right"> 255 </td> <td align="right"> 0 </td> </tr>
  <tr> <td> red </td> <td> #FF0000 </td> <td align="right"> 255 </td> <td align="right"> 0 </td> <td align="right"> 0 </td> </tr>
   </table>

Here are shades of gray:



<!-- html table generated in R 3.1.1 by xtable 1.7-4 package -->
<!-- Sun Oct 19 17:40:55 2014 -->
<table border=1>
<tr> <th> colorName </th> <th> hex </th> <th> red </th> <th> green </th> <th> blue </th>  </tr>
  <tr> <td> white, gray100 </td> <td> #FFFFFF </td> <td align="right"> 255 </td> <td align="right"> 255 </td> <td align="right"> 255 </td> </tr>
  <tr> <td> gray67 </td> <td> #ABABAB </td> <td align="right"> 171 </td> <td align="right"> 171 </td> <td align="right"> 171 </td> </tr>
  <tr> <td> gray33 </td> <td> #545454 </td> <td align="right"> 84 </td> <td align="right"> 84 </td> <td align="right"> 84 </td> </tr>
  <tr> <td> black, gray0 </td> <td> #000000 </td> <td align="right"> 0 </td> <td align="right"> 0 </td> <td align="right"> 0 </td> </tr>
   </table>

Note that everywhere you see "gray" above, you will get the same results if you substitute "grey". We see that white corresponds to maximum intensity in all channels and black to the minimum.

To review, here are the ways to specify colors in R:

  * a positive integer, used to index into the current color palette (queried or manipulated via `palette()`)
  * a color name among those found in `colors()`
  * a hexadecimal string; in addition to a hexadecimal triple, in some contexts this can be extended to a hexadecimal quadruple with the fourth channel referring to alpha transparency

Here are some functions to read up on if you want to learn more -- don't forget to mine the "See Also" section of the help to expand your horizons: `rgb()`, `col2rgb()`, `convertColor()`.

### Alternatives to the RGB color model, especially HCL

The RGB color space or model is by no means the only or best one. It's natural for describing colors for display on a computer screen but some really important color picking tasks are hard to execute in this model. For example, it's not obvious how to construct a qualitative palette where the colors are easy for humans to distinguish, but are also perceptually comparable to one other. Appreciate this: we can use RGB to describe colors to the computer __but we don't have to use it as the space where we construct color systems__.

Color models generally have three dimensions, as RGB does, due to the physiological reality that humans have three different receptors in the retina. ([Here is an informative blog post](http://manyworldstheory.com/2013/01/15/my-favorite-rgb-color/) on RGB and the human visual system.) The closer a color model's dimensions correspond to distinct qualities people can perceive, the more useful it is. This correspondence facilitates the deliberate construction of palettes and paths through color space with specific properties. RGB lacks this concordance with human perception. Just because you have photoreceptors that detect red, green, and blue light, it doesn't mean that your *perceptual experience* of color breaks down that way. Do you experience the color yellow as a mix of red and green light? No, of course not, but that's the physiological reality. An RGB alternative you may have encountered is the Hue-Saturation-Value (HSV) model. Unfortunately, it is also quite problematic for color picking, due to its dimensions being confounded with each other.

What are the good perceptually-based color models? CIELUV and CIELAB are two well-known examples. We will focus on a variant of CIELUV, namely the Hue-Chroma-Luminance (HCL) model. It is written up nicely for an R audience in Zeileis, et al (see References for citation and link). There is a companion R package `colorspace`, which will help you to explore and exploit the HCL color model. Finally, this color model is fully embraced in `ggplot2` (as are the `RColorBrewer` palettes).

Here's what I can tell you about the HCL model's three dimensions:

  * Hue is what you usually think of when you think "what color is that?" It's the easy one! It is given as an angle, going from 0 to 360, so imagine a rainbow donut.
  * Chroma refers to colorfullness, i.e. how pure or vivid a color is. The more something seems mixed with gray, the lower its chromaticity. The lowest possible value is 0, which corresponds to actual gray. The maximum value varies with luminance.
  * Luminance is related to brightness, lightness, intensity, and value. Low luminance means dark and indeed black has luminance 0. High luminance means light and white has luminance 1.
  
> Full disclosure: I have a hard time really grasping and distinguishing chroma and luminance. As we point out above, they are not entirely independent, which speaks to the weird shape of the 3 dimensional HCL space.
  
Figure 6.6 in Wickham's `ggplot2` book is helpful for understanding the HCL color space.

![Figure 6.6 of Wickham's ggplot2 book](img/ggplot2book-fig6.6.png)

> JB re-phrasing and combining Wickham's description and caption for this figure: Each facet or panel depicts a slice through HCL space for a specific luminance, going from low to high. The extreme luminance values of 0 and 100 are omitted because they would, respectively, be a single black point and a single white point. Within a slice, the centre has chroma 0, which corresponds to a shade of grey. As you move toward the slice's edge, chroma increases and the color gets more pure and intense. Hue is mapped to angle.
  
A valuable contribution of the `colorspace` package is that it provides functions to create color palettes traversing color space in a rational way. In contrast, the palettes offered by `RColorBrewer`, though well-crafted, are unfortunately fixed.

> Here I plan to insert/recreate some visuals from the Zeileis et al paper or from the `colorspace` vignette. For the moment, that stuff is sitting in the PDF slides. So go there!

### Accomodating color blindness

the `dichromat` package ([on CRAN](http://cran.r-project.org/web/packages/dichromat/))

> obviously need to do some writing here!

### Clean up


```r
## NOT RUN
## execute this if you followed my code for
## changing the default plot symbol in a simple, non-knitr setting
## reversing the effects of this: opar <- par(pch = 19)
par(opar)
```


### References

Achim Zeileis, Kurt Hornik, Paul Murrell (2009). Escaping RGBland: Selecting Colors for Statistical Graphics. Computational Statistics & Data Analysis, 53(9), 3259-3270. [DOI](http://dx.doi.org/10.1016/j.csda.2008.11.033) | [PDF](http://eeecon.uibk.ac.at/~zeileis/papers/Zeileis+Hornik+Murrell-2009.pdf)

[Vignette](http://cran.r-project.org/web/packages/colorspace/vignettes/hcl-colors.pdf) for the `colorspace` package

Earl F. Glynn (Stowers Institute for Medical Research)

  * [excellent resources](http://research.stowers-institute.org/efg/R/Color/Chart/) for named colors, i.e. the ones available via `colors()`
  * informative talk ["Using Color in R"](http://research.stowers-institute.org/efg/Report/UsingColorInR.pdf), though features some questionable *use* of color itself

Blog post [My favorite RGB color](http://manyworldstheory.com/2013/01/15/my-favorite-rgb-color/) on the Many World Theory blog

ggplot2: Elegant Graphics for Data Analysis [available via SpringerLink](http://ezproxy.library.ubc.ca/login?url=http://link.springer.com.ezproxy.library.ubc.ca/book/10.1007/978-0-387-98141-3/page/1) by Hadley Wickham, Springer (2009) | [online docs (nice!)](http://docs.ggplot2.org/current/) | [author's website for the book](http://ggplot2.org/book/), including all the code | [author's landing page for the package](http://ggplot2.org)

  * Section 6.4.3 Colour
  
### Notes from the future

Consider incorporating in future version of this material:

  * Example-laden article by Bernice E. Rogowitz and Lloyd A. Treinish of IBM Research ["Why Should Engineers and Scientists Be Worried About Color?"](http://www.research.ibm.com/people/l/lloydt/color/color.HTM), h/t [\@EdwardTufte](https://twitter.com/EdwardTufte). Importance of signalling where zero is in colorspace, perceptually based color systems (they talk about hue, saturation, and luminance), when the heck was this written?
