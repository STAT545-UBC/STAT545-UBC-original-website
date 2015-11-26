---
title: "Homework 08: Data cleaning"
output:
  html_document:
    toc: true
    toc_depth: 4
---

**NOTE: From 2014 and not used in 2015**

### Overview 

You have learned a lot about advance string operations combined with regular expression.    

  * Pattern matching with `grep()`, `grepl()`, `stringr::str_match()` etc.   
  * String replacement with `gsub()` etc.    
  * String splitting with `strsplit()`, `str_split_fixed()` etc.    
  * String pasting with `paste()`, `paste0()`.   
  
Now you are ready to apply them to the real world of data cleaning!    

[Here](http://biomickwatson.wordpress.com/2014/03/25/biologists-this-is-why-bioinformaticians-hate-you/) is an interesting link on why data cleaning is important and how extremely frustrating it can be.   

In this homework, you will start with the dirty version of `Gapminder` in our course repository, [gapminderDataFiveYear_dirty.txt](https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/gapminderDataFiveYear_dirty.txt), and clean it up with all the string functions you've learned. Before you begin, copy this file into your own homework repository.       

Due anytime Thursday November 6th 2014.  

### Your mission

#### Loading dirty Gapminder

Read gapminderDataFiveYear_dirty.txt into R. Experiment with `strip.white = FALSE` (default) and `strip.white = TRUE`.    
__Reflect on__ what difference this argument makes.     

#### Splitting or merging  

Now look at the columns of this data frame. Are there two pieces of information in one field? Or one piece of information splitted over two columns? Use string splitting or pasting so that each column only contains one conceptual variable.    

#### Missing values

Missing values often comes as fields with `NA` or empty strings. Is there any missing data in this dataset? Identify missing fields, and try to fill them yourself.    
  
#### Inconsistent capitalization and spelling     

Many times you will come across difference versions of the exact same record with different capitalization or spelling. Are there any in our dataset? There are several different ways to go about this:    

  * You can make a dictionary for all the correct spelling and capitalization, and map the inconsistent ones to the dictionary using `gsub()`.  
  * You may need to combine a programmatic approach with regular expression and human eyeballs to identify all the inconsistent records.   
  * In our dataset, most countries/continents are capitalized for the first letter of every word, with few execptions like "and" is not capitalized. Make use of word boundaries in regular expression to help you find potential problematic records quickly, for example, `\\b[a-z]` will match all cases where the first letter of the word is not capitalized.    

> For advanced users, check out the `replacement` argument in `?gsub` for the use of `\U` together with `perl = TRUE`. For example, `gsub("\\b([a-z])", "\\U\\1", strings, perl = TRUE)` will capitalize the first letter of every word. But it is not required in this homework.     

#### Final check

Finally, load the clean `Gapminder`, [gapminderDataFiveYear.txt](https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/gapminderDataFiveYear.txt), and use `identical()` to compare your cleaned data frame with ours. If `TRUE`, congratulations! You've successfully cleaned this dataset!    

### Other problems in data cleaning

There are other potential problems that we did not cover in this homework. Watch out for them in your own data cleaning process: 

  * Line ending: `\n` and `\r`. Most likely to happen if you are using a mixture of OS like Windows plus Linux etc.   
  * Weird characters because of encoding problems.       
  * Quotes inside quotes, non-matching quotes.   




