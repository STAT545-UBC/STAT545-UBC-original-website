---
title: "Homework 08: Data cleaning"
output:
  html_document:
    toc: true
    toc_depth: 4
---

### Overview 

You have learned a lot about advance string operations combined with regular expression.    

  * Pattern matching with `grep()`, `grepl()`, `stringr::str_match()` etc.   
  * String replacement with `gsub()` etc.    
  * String splitting with `strsplit()`, `str_split_fixed()` etc.    
  * String pasting with `paste()`, `paste0()`.   
  
Now you are ready to apply them to the real world of data cleaning!    

[Here](http://biomickwatson.wordpress.com/2014/03/25/biologists-this-is-why-bioinformaticians-hate-you/) is an interesting link on why data cleaning is important and how extremely frustrating it can be.   

In this homework, you will start with the dirty version of `Gapminder` in our course repository, [gapminderDataFiveYear_dirty.txt](https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/gapminderDataFiveYear_dirty.txt) into R, and clean it up with all the string functions you've learned. Make sure your local copy of the [course repository](https://github.com/STAT545-UBC/STAT545-UBC.github.io) is up-to-date before you begin.       

Due anytime Thursday November 6th 2014.  

### Your mission

#### Loading dirty Gapminder

Read gapminderDataFiveYear_dirty.txt into R. Experiment with `strip.white = FALSE` (default) and `strip.white = TRUE`.    
__Reflect on__ what difference this argument makes.     

#### Splitting or merging  

Now look at the columns of this data frame. You need to decide how much information each column should hold. Are there two pieces of information in one field? Or one piece of information splitted over two columns? Use string splitting or pasting where necessary.    

#### Missing values

Missing values often comes as fields with `NA` or empty strings. Are there any missing fields in this data frame? If so, you need to figure out:     

  * Can the information be found? Sometimes it's obvious, sometimes you can contact your collabrators who provided the data, and sometimes you need to search it up on the internet.    
  * If the information cannot be found, should you discard the particular record?    
  
#### Inconsistent capitalization  

Many times you will come across exact same record with different capitalization rules. Are there any in our dataset?    

In our dataset, most countries/continents are capitalized for the first letter of every word, with few execptions like "and" is not capitalized. Make use of word boundaries in regular expression to help you find potential problematic records quickly.    

> For advanced users, check out the `replacement` argument in `?gsub` for the use of `\U` together with `perl = T`. It might make your code extremely simple and efficient sometimes.   

#### Spelling  

There might be spelling mistakes and different ways of indicating the same country/continent. Correct them in our dataset. 

#### Final check

Finally, load the clean `Gapminder`, [gapminderDataFiveYear.txt](https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/gapminderDataFiveYear.txt), and use `identical()` to check your cleaned version with ours. If identical, congratulations! You've successfully cleaned this dataset!    

### Other problems in data cleaning

There are other potential problems that we did not cover in this homework. Watch out for them in your own data cleaning process: 

  * Line ending: `\n` and `\r`. Most likely to happen if you are using a mixture of OS like Windows plus Linux etc.   
  * Weird characters because of encoding problems.       
  * Quotes inside quotes, non-matching quotes.   




