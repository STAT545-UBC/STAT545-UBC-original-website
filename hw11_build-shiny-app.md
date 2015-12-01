# Shiny - Homework
Julia Gustavsen and Jenny Bryan  
2014-11-18  

**From 2014. Will not be used in 2015.**

## Big picture

We made a Shiny app that let us graph the Gapminder data. 

There is a lot you can do with Shiny. For homework we want you to:

* add the Gapminder data as a .tsv file to a directory in your gapminder app ("./data/" would be a good option for a directory). This way the data are included as part of your app. Load in the data from this directory instead of the url given in class. 
* use another type of widget to control an aspect of the data (see [Shiny Widget Gallery](http://shiny.rstudio.com/gallery/widget-gallery.html))
* edit the dropdown menu for countries so that you can choose 2 (or more) countries
* try facetting the data based on one of your user inputs
* please have your app organized with the strict directory structure required by Shiny so that your peer reviewer can download your scripts and run you app locally. Please also deploy your app to the shinyapps.io website or if you are really excited talk to Jenny about deploying to the shinyapps.stat.ubc.ca server.  

In a suitable file and place, probably a `README.md`, describe how the Shiny development work went for you. What was the hardest part? The most rewarding? How do you regard Shiny's strengths / weakness relative to webpages you can create from RMarkdown? What sort of future applications can you see for Shiny? 

### Due date

Your Shiny app is due Monday 01 December 2014.

## Please just tell me what to do

Follow the tutorial up until the end. 

* Replace the slider for the years instead with the widget `dateRangeInput`. Pay careful attention to the "format" and "startview" arguments. The `dateRangeInput` requires dates to be in yyyy-mm-dd format, so you will need to give this format to your arguments that involve the date in this function.  The `dateRangeInput` widget returns not only years, but dates in the format "yyyy-mm-dd". This is not ideal, but we just want the year, so one way to get at that is for the minimum date instead of having the `input$select_year[1]` in `server.R` to access the year, we can get at the year by using `as.numeric(format(input$name_of_your_dateRangeInput_id_in_uiR[1], "%Y"))`. 
* Edit the `selectInput` for countries by adding in values for the arguments "selected" and "multiple".  
* Either add facetting to your plot by country or add the use of colour to you plot to distinguish the 2 or more countries displayed. See [ggplot2 tutorial](cm005_still-data-ggplot2-rmarkdown.html)
* Commit the app to your Stat545/547 repo, push to Github.  Also deploy the app to shinyapps.io using the "Publish" button in Rstudio (or see [tutorial section on deployment](shiny02_activity.html#deployment))

## I want to aim higher! Shiny

* Use another approved data set to create an app that outputs a plot, a table and has 2 control widgets that change the output of the plot (i.e. meets all the requirements above, but using a different data set). 
* Add a widget to enable you to turn the facetting of the graphs "on" or "off" (either using your Gapminder app or another dataset.)
* Add images to your app.[R studio Shiny tutorial-see header "Images"](http://shiny.rstudio.com/tutorial/lesson2/)
* Deploy on shinyapps.stat.ubc.ca

## I want to aim way higher!  

* CSS or Html junkie? Try using another css theme or create and use your own css theme. `shinyUI(fluidPage(theme = "bootstrap.css"` [R studio Shiny Article on css style](http://shiny.rstudio.com/articles/css.html)
* Explore a new layout (e.g. `gridLayout()`, `fluidRow()`) and have different graphs laid out on different pages.
* Deploy your cool app and tweet to @STAT545 about it. We guarantee people will be stoked about what you created. 


## Rubric

Your peer reviewer will try run your app! 

As peer reviewer you will critique the student's shiny homework on the deployed app (either on the Stats UBC server or on shinyapps.io) *and* by looking at their code in their github repo. (We won't be able to use the `shiny::runGitHub()` since these are private repositories, but you could optionally download the student's app locally and use `shiny::runApp()` to view the app.) 

Check minus: There is a problem with some aspect of `server.R` or `ui.R`. The deployed app does not function as it should or there are missing/broken pieces to the app.  

Check: App runs! All the required widgets, interactivity and facetting/colour are included. Good work!

Check plus: Exceeded the requirements in a number of dimensions. App is deployed on shinyapps.io or on shinyapps.stat.ubc.ca. You have added a pleasant, useful dimension (widget, images, layout, css/html coding) to the app that was not required. Neat! 

Recall the [general homework rubric](http://stat545-ubc.github.io/peer-review01_marking-rubric.html).

## Authors

Written by [Julia Gustavsen][] and [Jenny Bryan][].

[Julia Gustavsen]: http://twitter.com/JuliaGustavsen
[Jenny Bryan]: http://www.stat.ubc.ca/~jenny/
