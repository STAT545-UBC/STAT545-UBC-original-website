# Building Shiny apps
Dean Attali  

# Overview

Shiny is a package from RStudio that can be used to build interactive web pages with R. While that may sound scary because of the words "web pages", it's geared to R users who have 0 experience with web development, and you do not need to know any HTML/CSS/JavaScript.

You can do quite a lot with Shiny: think of it as an easy way to make an interactive web page, and that web page can seamlessly interact with R and display R objects (plots, tables, of anything else you do in R). To get a sense of the wide range of things you can do with Shiny, you can visit [ShowMeShiny.com](http://www.showmeshiny.com/), which is a gallery of user-submitted Shiny apps. 

This tutorial is a hands-on activity complement to a set of [presentation slides](https://docs.google.com/presentation/d/1dXhqqsD7dPOOdcC5Y7RW--dEU7UfU52qlb0YD3kKeLw/edit?usp=sharing) for learning how to build Shiny apps. In this activity, we'll walk through all the steps of building a Shiny app that lets you explore the products available at the BC Liquor Store. The final version of the app, including a few extra features that are left as exercises for the reader, [can be seen here](http://daattali.com/shiny/bcl/). Any activity deemed as an exercise throughout this tutorial is not mandatory for building our app, but they are good for getting more practice with Shiny.

As an alternative tutorial, I highly recommend the [official Shiny tutorial](http://shiny.rstudio.com/tutorial/). RStudio also provides a [handy cheatsheet](https://www.rstudio.com/resources/cheatsheets/) to remember all the little details after you already learned the basics.

**Exercise:** Visit [ShowMeShiny.com](http://www.showmeshiny.com/) and click through some of the showcased apps. Get a feel for the wide range of things you can do with Shiny.

# Before we begin

You'll need to have the `shiny` package, so install it.

```
install.packages("shiny")
```

To ensure you successfully installed Shiny, try running one of the demo apps.

```
library(shiny)
runExample("01_hello")
```

If the example app is running, press *Escape* to close the app, and you are ready to build your first Shiny app!

# Shiny app basics 

Every Shiny app is composed of a two parts: a web page that shows the app to the user, and a computer that powers the app. The computer that runs the app can either be your own laptop (such as when you're running an app from RStudio) or a server somewhere else. You, as the Shiny app developer, need to write these two parts (you're not going to write a computer, but rather the code that powers the app). In Shiny terminology, they are called *UI* (user interface) and *server*. UI is just a web document that the user gets to see, it's HTML that you write using Shiny's functions. Server is responsible for the logic of the app; it's the set of instructions that tell the web page what to show when the user interacts with the page.

# Create an empty Shiny app

All Shiny apps follow the same template:

```
library(shiny)
ui <- fluidPage()
server <- function(input, output, session) {}
shinyApp(ui = ui, server = server)
```

This template is by itself a working minimal Shiny app that doesn't do much. It initializes an empty UI and an empty server, and runs an app using these empty parts. Copy this template into a new file named `app.R` in a new folder. It is **very important** that the name of the file is `app.R`, otherwise it would not be recognized as a Shiny app. It is also **very important** that you place this app in its own folder, and not in a folder that already has other R scripts or files, unless those other files are used by your app.

After saving the file, RStudio should recognize that this is a Shiny app, and you should see the usual *Run* button at the top change to *Run App*.

![Shiny Run App](./img/shiny-runapp.png)

If you don't see the *Run App* button, it means you either have a very old version of RStudio, don't have Shiny installed, or didn't follow the file naming conventions.

Click the *Run App* button, and now your app should run. You won't see much because it's an empty app, but you should see that the console has some text printed in the form of `Listening on http://127.0.0.1:5274` and that a little stop sign appeared at the top of the console.  You'll also notice that you can't run any commands in the console. This is because R is busy--your R session is currently powering a Shiny app and listening for user interaction (which won't happen because the app has nothing in it yet).

Click the stop button to stop the app, or press the *Escape* key.

![Shiny Stop App](./img/shiny-stopapp.png)

You may have noticed that when you click the *Run App* button, in the console it really is just running the function `shiny::runApp()` on the folder you're in.  You can run that command instead of clicking the button if you prefer.

**Exercise:** Try running the empty app using the `runApp()` function instead of using the *Run App* button.

## Alternate way to create app template: using RStudio

FYI: You can also create a new Shiny app using RStudio's menu by selecting *File > New Project > New Directory > Shiny Web Application*.  If you do this, RStudio will create a new folder and initialize a simple Shiny app in it.  However, this Shiny app will not have an `app.R` file and instead will have two files: `ui.R` and `server.R`. This is another way to define Shiny apps, with one file for the UI and one file for the server code.  This is the preferable way to write Shiny apps when the app is complex and involved more code, but in this tutorial we'll stick to the simple single file.  If you want to break up your app into these two files, you simple put all code that is assigned to the `ui` variable in `ui.R` and all the code assigned to the `server` function in `server.R`. When RStudio sees these two files in the same folder, it will know you're writing a Shiny app.

**Exercise:** Try creating a new Shiny app using RStudio's menu. Make sure that app runs. Next, try making a new Shiny app by manually creating the two files `ui.R` and `server.R`. Rememeber that they have to be in the same folder. Also remember to put them in a *new, isolated* folder.

# Load the dataset

The dataset we'll be using contains information about all the products sold by BC Liquor Store and is provided by [OpenDataBC](https://www.opendatabc.ca/dataset/bc-liquor-store-product-price-list-current-prices). They provide a direct link to download a *csv* version of the data, and this data has the rare quality that it is immediately clean and useful. You can view the [raw data](http://pub.data.gov.bc.ca/datasets/176284/BC_Liquor_Store_Product_Price_List.csv) they provide, but I have taken a few steps to simplify the dataset to make it more useful for our app. I removed some columns, renamed other columns, and dropped a few rare factor levels.

The processed dataset we'll be using in this app is available [here](http://deanattali.com/files/bcl-data.csv) - download it now.  Put this file in the same folder that has your Shiny app.

Add a line in your app to load the data into a variable called `bcl`. It should look something like this

```
bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)
```

Place this line in your app as the second line, just after `library(shiny)`.  Make sure the file path and file name are correct, otherwise your app won't run. Try to run the app to make sure the file can be loaded without errors.

> In case you're curious, the code I used to process the raw data into the data we'll be using is available [as a gist](https://gist.github.com/daattali/56b9fa8f3e99174fba63).

**Exercise:** Load the data file into R and get a feel for what's in it. How big is it, what variables are there, what are the normal price ranges, etc.

# Build the UI

Let's start populating our app with some elements visually. This is usually the first thing you do when writing a Shiny app - add elements to the UI.

## Add simple text to the UI

You can place R strings inside `fluidPage()` to render text.

```
fluidPage("BC Liquor Store", "prices")
```

Replace the line in your app that assigns an empty `fluidPage()` into `ui` with the one above, and run the app.

The entire UI will be built by passing comma-separated arguments into the `fluidPage()` function. By passing regular text, the web page will just render boring unformatted text.

**Exercise:** Add several more strings to `fluidPage()` and run the app. Nothing too exciting is happening yet, but you should just see all the text appear in one contiguous block.

## Add formatted text and other HTML elements

If we want our text to be formatted nicer, Shiny has many functions that are wrappers around HTML tags that format text. We can use the `h1()` function for a top-level header (`\<h1\>` in HTML), `h2()` for a secondary header (`\<h2\>` in HTML), `strong()` to make text bold (`\<strong\>` in HTML), `em()` to make text italicized (`\<em\>` in HTML), and many more.

There are also functions that are wrappers to other HTML tags, such as `br()` for a line break, `img()` for an image, `a()` for a hyperlink, and others.

All of these functions are actually just wrappers to HTML tags with the equivalent name. You can add any arbitrary HTML tag using the `tags` object, which you can learn more about by reading the help file on `tags`.

Just as a demonstration, try replacing the `fluidPage()` function in your UI with

```
fluidPage(
  h1("My app"),
  "BC",
  "Liquor",
  br(),
  "Store",
  strong("prices")
)
```

Run the app with this code as the UI. Notice the formatting of the text and understand why it is rendered that way.

> For people who know basic HTML: any named argument you pass to an HTML function becomes an attribute of the HTML element, and any unnamed argument will be a child of the element. That means that you can, for example, create blue text with `div("this is blue", style = "color: blue;")`.

**Exercise:** Experiment with different HTML-wrapper functions inside `fluidPage()`. Run the `fluidPage(...)` function in the console and see the HTML that it creates.

## Add a title

We could add a title to the app with `h1()`, but Shiny also has a special function `titlePanel()`. Using `titlePanel()` not only adds a visible big title-like text to the top of the page, but it also sets the "official" title of the web page. This means that when you look at the name of the tab in the browser, you'll see this title.

Overwrite the `fluidPage()` that you experimented with so far, and replace it with the simple one below, that simply has a title and nothing else.

```
fluidPage(
  titlePanel("BC Liquor Store prices")
)
```

**Exercise:** Look at the documentation for the `titlePanel()` function and notice it has another argument. Use that argument and see if you can see what it does.

## Add a layout

You may have noticed that so far, by just adding text and HTML tags, everything is unstructured and the elements simply stack up one below the other in one column. We'll use `sidebarLayout()` to add a simple structure. It provides a simple two-column layout with a smaller sidebar and a larger main panel. We'll build our app such that all the inputs that the user can manipulate will be in the sidebar, and the results will be shown in the main panel on the right.

Add the following code after the `titlePanel()`

```
sidebarLayout(
  sidebarPanel("our inputs will go here"),
  mainPanel("the results will go here")
)
```

Remember that all the arguments inside `fluidPage()` need to be separated by commas.

So far our complete app looks like this (hopefully this isn't a surprise to you)

```
library(shiny)
bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel("our inputs will go here"),
    mainPanel("the results will go here")
  )
)

server <- function(input, output, session) {}

shinyApp(ui = ui, server = server)
```

![Shiny layout](./img/shiny-layout.png)

> If you want to be a lot more flexible with the design, you can have much more fine control over where things go by using a grid layout. We won't cover that here, but if you're interested, look at the documentation for `?column` and `?fluidRow`.

**Exercise:** Add some UI into each of the two panels (sidebar panel and main panel) and see how your app now has two columns.

## All UI functions are simply HTML wrappers

This was already mentioned, but it's important to remember: the enire UI is just HTML, and Shiny simply gives you easy tools to write it without having to know HTML. To convince yourself of this, look at the output when printing the contents of the `ui` variable.




```r
print(ui)
```

```
## <div class="container-fluid">
##   <h2>BC Liquor Store prices</h2>
##   <div class="row">
##     <div class="col-sm-4">
##       <form class="well">our inputs will go here</form>
##     </div>
##     <div class="col-sm-8">the results will go here</div>
##   </div>
## </div>
```

This should make you appreciate Shiny for not making you write horrendous HTML by hand.

## Add inputs

Inputs are what gives users a way to interact with a Shiny app. Shiny provides many input functions to support many kinds of interactions that the user could have with an app. For example, `textInput()` is used to let the user enter text, `numericInput()` lets the user select a number, `dateInput()` is for selecting a date, `selectInput()` is for creating a select box (aka a dropdown menu).

![Shiny inputs](./img/shiny-inputs.png)

All input functions have the same first two arguments: `inputId` and `label`. The `inputId` will be the name that Shiny will use to refer to this input when you want to retrieve its current value. It is important to note that every input must have a unique `inputId`. If you give more than one input the same id, Shiny will unfortunately not give you an explicit error, but your app won't work correctly. The `label` argument specifies the text in the display label that goes along with the input widget. Every input can also have multiple other arguments specific to that input type. The only way to find out what arguments you can use with a specific input function is to look at its help file.

**Exercise:** Read the documentation of `?numericInput` and try adding a numeric input to the UI. Experiment with the different arguments. Run the app and see how you can interact with this input. Then try different inputs types.

### Input for price

The first input we want to have is for specifying a price range (minimum and maximum price). The most sensible types of input for this are either `numericInput()` or `sliderInput()` since they are both used for selecting numbers. If we use `numericInput()`, we'd have to use two inputs, one for the minimum value and one for the maximum. Looking at the documentation for `sliderInput()`, you'll see that by supplying a vector of length two as the `value` argument, it can be used to specify a range rather than a single number. This sounds like what we want in this case, so we'll use `sliderInput()`. 

To create a slider input, a maximum value needs to be provided. We could use the maximum price in the dataset, which is $30,250, but I doubt I'd ever buy something that expensive. I think $100 is a more reasonable max price for me, and about 85% of the products in this dataset are below $100, so let's use that as our max.

By looking at the documentation for the slider input function, the following piece of code can be constructed.

```
sliderInput("priceInput", "Price", min = 0, max = 100,
            value = c(25, 40), pre = "$")
```

Place the code for the slider input inside `sidebarPanel()` (replace the text we wrote earlier with this input).

### Input for product type

Usually when going to the liquor store you know whether you're looking for beer or wine, and you don't want to waste your time in the wrong section.  The same is true in our app, we should be able to choose what type of product we want.

For this we want some kind of a text input. But allowing the user to enter text freely isn't the right solution because we want to restrict the user to only a few choices.  We could either use radio buttons or a select box for our purpose. Let's use radio buttons for now since there are only a few options, so take a look at the documentation for `radioButtons()` and come up with a reasonable input function code.  It should look like this:

```
radioButtons("typeInput", "Product type",
            choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
            selected = "WINE")
```

Add this input code inside `sidebarPanel()`, after the previous input (separate them with a comma).

> If you look at that input function and think "what if there were 100 types, listing htem by hand would not be fun, there's got to be a better way!", then you're right.  This is where `uiOutput()` comes in handy, but we'll talk about that later.

### Input for country

Sometimes I like to feel fancy and only look for wines imported from France. We should add one last input, to select a country. The most appropriate input type in this case is probably the select box. Look at the documentation for `selectInput()` and create an input function. For now let's only have CANADA, FRANCE, ITALY as options, and later we'll see how to include all countries. 

```
selectInput("countryInput", "Country",
            choices = c("CANADA", "FRANCE", "ITALY"))
```

Add this function as well to your app.  If you followed along, your entire app should have this code:

```
library(shiny)
bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, c(25, 40), pre = "$"),
      radioButtons("typeInput", "Product type",
                  choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                  selected = "WINE"),
      selectInput("countryInput", "Country",
                  choices = c("CANADA", "FRANCE", "ITALY"))
    ),
    mainPanel("the results will go here")
  )
)

server <- function(input, output, session) {}

shinyApp(ui = ui, server = server)
```

![Shiny add inputs](./img/shiny-addinputs.png)

## Add placeholders for outputs

After creating all the inputs, we should add elements to the UI to display the outputs. Outputs can be any object that R creates and that we want to display in our app - such as a plot, a table, or text. We're still only building the UI, so at this point we can only add *placeholders* for the outputs that will determine where an output will be and what its ID is, but it won't actually show anything. Each output needs to be constructed in the server code later.

Shiny provides several output functions, one for each type of output. Similarly to the input functions, all the ouput functions have a `outputId` argument that is used to identify each output, and this argument must be unique for each output.

### Output for a plot of the results

At the top of the main panel we'll have a plot showing somme visualization of the results. Since we want a plot, the function we use is `plotOutput()`.

Add the following code into the `mainPanel()` (replace the existing text):

```
plotOutput("coolplot")
```

This will add a placeholder in the UI for a plot named *coolplot*.

**Exercise:** To remind yourself that we are still merely constructing HTML and not creating actual plots yet, run the above `plotOutput()` function in the console to see that all it does is create some HTML.

### Output for a table summary of the results

Below the plot, we will have a table that shows all the results.  To get a table, we use the `tableOutput()` function.

Here is a simple way to create a UI element that will hold a table output:

```
tableOutput("results")
```

Add this output to the `mainPanel()` as well. Maybe add a couple `br()` in between the two outputs, just as a space buffer so that they aren't too close to each other.

If you've followed along, your app should now have this code:

```
library(shiny)
bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, c(25, 40), pre = "$"),
      radioButtons("typeInput", "Product type",
                  choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                  selected = "WINE"),
      selectInput("countryInput", "Country",
                  choices = c("CANADA", "FRANCE", "ITALY"))
    ),
    mainPanel(
      plotOutput("coolplot"),
      br(), br(),
      tableOutput("results")
    )
  )
)

server <- function(input, output, session) {}

shinyApp(ui = ui, server = server)
```

# Implement server logic to create outputs

So far we only wrote code inside that was assigned to the `ui` variable (or code that was written in `ui.R`). That's usually the easier part of a Shiny app. Now we have to write the `server` function, which will be responsible for listening to changes to the inputs and creating outputs to show in the app.

## Building an output

Recall that we created two output placeholders: *coolplot* (a plot) and *summary* (a table). We need to write code in R that will tell Shiny what kind of plot or table to display. There are three rules to build an output in Shiny. 

1. Save the output object into the `output` list (remember the app template - every server function has an `output` argument)  
2. Build the object with a `render*` function, where `*` is the type of output
3. Access input values using the `input` list (every server function has an `input` argument)

The third rule is only required if you want your output to depend on some input, so let's first see how to build a very basic output using only the first two rules. We'll create a plot and send it to the *coolplot* output. 

```
output$coolplot <- renderPlot({
  plot(rnorm(100))
})
```

This simple code shows the first two rules: we're creating a plot inside the `renderPlot()` function, and assigning it to *coolplot* in the `output` list. Remember that every output creatd in the UI must have a unique ID, now we see why. In order to attach an R object to an output with ID *x*, we assign the R object to `output$x`.

Since *coolplot* was defined as a `plotOutput`, we must use the `renderPlot` function, and we must create a plot inside the `renderPlot` function.

If you add the code above inside the server function, you should see a plot with 100 random points in the app.

**Exercise:** The code inside `renderPlot()` doesn't have to be only one line, it can be as long as you'd like as long as it returns a plot. Try making a more complex plot using `ggplot2`. The plot doesn't have to use our dataset, it could be anything, just to make sure you can use `renderPlot()`.

## Making an output react to an input

Now we'll take the plot one step further. Instead of always plotting the same plot (100 random numbers), let's use the minimum price selected as the number of points to show. It doesn't make too much sense, but it's just to learn how to make an output depend on an input.

```
output$coolplot <- renderPlot({
  plot(rnorm(input$priceInput[1]))
})
```

Replace the code previously in your server function with this code, and run the app. Whenever you choose a new minimum price range, the plot will update with a new number of points. Notice that the only thing different in the code is that instead of using the number `100` we are using `input$priceInput[1]`. 

What does this mean? Just like the variable `output` contains a list of all the outputs (and we need to assign code into them), the variable `input` contains a list of all the inputs that are defined in the UI. `input$priceInput` return a vector of length 2 containing the miminimum and maximum price. Whenever the user manipulates the slider in the app, these values are updated, and whatever code relies on it gets re-evaluated. This is a concept known as **reactivity**.

## Building the plot output

Now we have all the knowledge required to build a plot visualizing some aspect of the data. We'll create a simple histogram of the alcohol content of the products. 

First we need to make sure `ggplot2` is loaded, so add a `library(ggplot2)` at the top.

Next we'll make return a histogram of alcohol content from `renderPlot()`. Let's start with just a histogram of the whole data, unfiltered.

```
output$coolplot <- renderPlot({
  ggplot(bcl, aes(Alcohol_Content)) +
    geom_histogram()
})
```

If you run the app with this code inside your server, you sohuld see a histogram in the app.  But if you change the input values, nothing happens yet, so the next step is to actually filter the dataset based on the inputs.

Recall that we have 3 inputs: `priceInput`, `typeInput`, and `countryInput`. We can filter the data based on the values of these three inputs. We'll use `dplyr` functions to filter the data, so be sure to include `dplyr` at the top. Then we'll plot the filtered data instead of the original data.

```
output$coolplot <- renderPlot({
  filtered <-
    bcl %>%
    filter(Price >= input$priceInput[1],
           Price <= input$priceInput[2],
           Type == input$typeInput,
           Country == input$countryInput
    )
  ggplot(filtered, aes(Alcohol_Content)) +
    geom_histogram()
})
```

Place this code in your server function and run the app. If you change any input, you should see the histogram update. The way I know the histogram is correct is by noticing that the alcohol content is about 5% when I selecte beer, 40% for spirits, and 13% for wine. That sounds right.

Read this code and understand it. You've successfully created an interactive app - the plot is changing according to the user's selection.

To make sure we're on the same page, here is what your code should look like at this point:

```
library(shiny)
library(ggplot2)
library(dplyr)

bcl <- read.csv("bcl.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, c(25, 40), pre = "$"),
      radioButtons("typeInput", "Product type",
                  choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                  selected = "WINE"),
      selectInput("countryInput", "Country",
                  choices = c("CANADA", "FRANCE", "ITALY"))
    ),
    mainPanel(
      plotOutput("coolplot"),
      br(), br(),
      tableOutput("results")
    )
  )
)

server <- function(input, output, session) {
  output$coolplot <- renderPlot({
    filtered <-
      bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      )
    ggplot(filtered, aes(Alcohol_Content)) +
      geom_histogram()
  })
}

shinyApp(ui = ui, server = server)
```

![Shiny add plot](./img/shiny-addplot.png)

**Exercise:** The current plot doesn't look very nice, you could enhance the plot and make it much more pleasant to look at.

## Building the table output

Building the next output should be much easier now that we've done it once.  The other output we have was called `results` (as defined in the UI) and should be a table of all the products that match the filters.  Since it's a table output, we should use the `renderTable()` function. We'll do the exact same filtering on the data, and then simply return the data as a data.frame, and Shiny will know that it needs to display it as a table because it's defined as a `tableOutput`.

The code for creating the table output should make sense to you without too much explanation:

```
output$results <- renderTable({
  filtered <-
    bcl %>%
    filter(Price >= input$priceInput[1],
           Price <= input$priceInput[2],
           Type == input$typeInput,
           Country == input$countryInput
    )
  filtered
})
```

Add this code to your server. Don't overwrite the previous definition of `output$coolplot`, just add this code before or after that, but inside the server function. Run your app, and be amazed! You can now see a table showing all the products at the BC Liquor Store that match your criteria. 

**Exercise:** Add a new output. Either a new plot, a new table, or some piece of text that changes based on the inputs. For example, you could add a text output (`textOutput()` in the UI, `renderText()` in the server) that says how many results were found. If you choose to do this, I recommend first adding the output to the UI, then building the output in the server with static text to make sure you have the syntax correct, and only once you can see the text output in your app you should make it reflect the inputs. Protip: since `textOutput()` is written in the UI, you can wrap it in other UI functions. For example, `h2(textOutput(...))` will result in larger text.



reactivity
uiOutput



# Homework

- split app into ui.R and server.R
- add an option to sort the table by price 
- add an image
- add parameters to the plot
- put the plot and table in a separate tabs
- global.R defines objects available to both ui.R and server.R
- www folder can be used to add images or custom js/css
- experiment with packages that add extra functionality to shiny: shinyjs, leaflet, - shinydashboard, shinythemes, shinyBS, ggvis
- deploy to shinyapps.io
- advanced: talk to us to get it hosted on the UBC stats shiny server
- super advanced: host on your own shiny server
- select multiple types (either change to checkboxes, or to a select box with multiple = TRUE)
- if wine is selected, then show sweetness level filter
- let the user filter specific subtypes
