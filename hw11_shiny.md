# Building Shiny apps - Homework
Dean Attali  
2015-12-03  

## Deadline

The homework is due Friday, December 11 2015.

## What we've done

We made a Shiny app that lets you search for products from the BC Liquor Store based on price, alcohol type, and country. We used [this dataset](https://github.com/STAT545-UBC/STAT545-UBC.github.io/blob/master/shiny_supp/2015/bcl-data.csv) and [this code](./shiny01_activity.html#final-shiny-app-code) for our app.

## What you need to do

The app we developed is functional, but there are plenty of improvements that can be made. You can compare the app we developed to [my version of this app](http://daattali.com/shiny/bcl/) to get an idea of what a more functional app could include. For the homework, you need to either develop a new Shiny app that uses a different dataset, or add 3 or more features to the BC Liquor Store app.

Regardless of whether you create a new app or just add new features to our BC Liquor Store app, you **must** do the following 3 things: 

1. Your app should be split into a `ui.R` file and a `server.R` file. Note that so far in class we only had our apps inside an `app.R` file. You can read [this official Shiny help page](http://shiny.rstudio.com/articles/app-formats.html) if you need more help with this part.

2. Add a `README.md` file to your Shiny app folder that describes what you did in your app.

3. Your app should be deployed online on [shinyapps.io](http://www.shinyapps.io). Make sure your app actually works online (sometimes your app will work in RStudio but will have errors on shinyapps.io - make sure you deploy early and often to make debugging easier).
    - Alternatively, if you want to aim higher, you can contact us once your app is finished and work with us to deploy your app on the UBC Stats Shiny Server.
    - If you want to really challenge yourself, you can try getting your own Shiny Server and host your app yourself. Read [this tutorial](http://deanattali.com/2015/05/09/setup-rstudio-shiny-server-digital-ocean/) for help on setting that up.

If you decide to create a new app, then you are free to do whatever you want - get creative!  If you want to use the BC Liquor Store app, you need to add at least 3 new features to it. There are countless possibilities, but here are just a few ideas. You can choose any 3 or more ideas from this list or do anything else.

- Add an option to sort the results table by price.
    - **Hint:** Use `checkboxInput()` to get TRUE/FALSE values from the user.

- Add an image of the BC Liquor Store to the UI.
    - **Hint:** Place the image in a folder named `www`, and use `img(src = "imagename.png")` to add the image.

- Use the `DT` package to turn the current results table into an interactive table.
    - **Hint:** Install the `DT` package, replace `tableOutput()` with `DT::dataTableOutput()` and replace `renderTable()` with `DT::renderDataTable()`.

- Add parameters to the plot.
    - **Hint:** You will need to add input functions that will be used as parameters for the plot. You could use `shinyjs::colourInput()` to let the user decide on the colours of the bars in the plot.

- The app currently behaves strangely when the user selects filters that return 0 results. For example, try searching for wines from Belgium. There will be an empty plot and empty table generated, and there will be a warning message in the R console. Try to figure out why this warning message is appearing, and how to fix it.
    - **Hint:** The problem happens because `renderPlot()` and `renderTable()` are trying to render an empty data frame. To fix this issue, the `filtered` reactive expression should check for the number of rows in the filtered data, and if that number is 0 then return `NULL` instead of a 0-row data frame.

- Place the plot and the table in separate tabs.
    - **Hint:** Use `tabsetPanel()` to create an interface with multiple tabs.

- If you know CSS, add CSS to make your app look nicer. 
    - **Hint:** Add a CSS file under `www` and use the function `includeCSS()` to use it in your app.

- Experiment with packages that add extra features to Shiny, such as `shinyjs`, `leaflet`, `shinydashboard`, `shinythemes`, `ggvis`.
    - **Hint:** Each package is unique and has a different purpose, so you need to read the documentation of each package in order to know what it provides and how to use it.
    
- Show the number of results found whenever the filters change. For example, when searching for Italian wines $20-$40, the app would show the text "We found 122 options for you".
    - **Hint:** Add a `textOutput()` to the UI, and in its corresponding `renderText()` use the number of rows in the `filtered()` object.

- Allow the user to download the results table as a .`.csv` file.
    - **Hint:** Look into the `downloadButton()` and `downloadHandler()` functions.
    
- When the user wants to see only wines, show a new input that allows the user to filter by sweetness level. Only show this input if wines are selected.
    - **Hint:** Create a new input function for the sweetness level, and use it in the server code that filters the data. Use `conditionalPanel()` to conditionally show this new input. The `condition` argument of `conditionalPanel` should be something like `input.typeInput == "WINE"`.

- Allow the user to search for multiple alcohol types simultaneously, instead of being able to choose only wines/beers/etc.
    - **Hint:** There are two approaches to do this. Either change the `typeInput` radio buttons into checkboxes (`checkboxGroupInput()`) since checkboxes support choosing multiple items, or change `typeInput` into a select box (`selectInput()`) with the argument `multiple = TRUE` to support choosing multiple options.
    
- If you look at the dataset, you'll see that each product has a "type" (beer, wine, spirit, or refreshment) and also a "subtype" (red wine, rum, cider, etc.). Add an input for "subtype" that will let the user filter for only a specific subtype of products. Since each type has different subtype options, the choices for subtype should get re-generated every time a new type is chosen. For example, if "wine" is selected, then the subtypes available should be white wine, red wine, etc.
    - **Hint:** Use `uiOutput()` to create this input in the server code.
    
- Provide a way for the user to show results from *all* countries (instead of forcing a filter by only one specific country).
    - **Hint:** There are two ways to approach this. You can either add a value of "All" to the dropdown list of country options, you can include a checkbox for "Filter by country" and only show the dropdown when it is unchecked (see [my version of this app](http://daattali.com/shiny/bcl/) to see this option in action). In both cases you'll still need to update the server code appropriately to filter by country only when the user chooses to.

## Resources

Don't forget to check out some of the [awesome resources](./shiny01_activity.html#resources) for Shiny, they can really help you out.

## Rubric

Your peer reviewer will evaluate your app based only on the Shiny app that you deploy and on the `README.md` file that described what you app does. Your reviewer will not download your code. Therefore, you really need to make sure your app works on shinyapps.io, otherwise your reviewer will not be able to give you a mark.

Check minus: The deployed app does not work or results in many errors. There is no `README` file describing what app does.

Check: Shiny app runs. The `README` file describes either a new app or 3+ additions to our BC Liquor Store app. Whatever is described in the README is actually implemented in the app.

Check plus: Amazing Shiny app. Lots of new features or a very cool new app idea. App looks great visually. App is deployed on a Shiny Server instead of on shinyapps.io.

Recall the [general homework rubric](http://stat545-ubc.github.io/peer-review01_marking-rubric.html).
