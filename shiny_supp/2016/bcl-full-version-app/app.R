library(shiny)
library(dplyr)
library(ggplot2)

# load the data (retrieve and clean raw data if this is the first time)
filename <- file.path("data", "bcl.csv")
if (file.exists(filename)) {
  bcl <- read.csv(filename, stringsAsFactors = FALSE)
} else {
  bcl <- read.csv("http://pub.data.gov.bc.ca/datasets/176284/BC_Liquor_Store_Product_Price_List.csv",
                  stringsAsFactors = FALSE)
  products <- c("BEER", "REFRESHMENT BEVERAGE", "SPIRITS", "WINE")
  bcl <- dplyr::filter(bcl, PRODUCT_CLASS_NAME %in% products) %>%
    dplyr::select(-PRODUCT_TYPE_NAME, -PRODUCT_SKU_NO, -PRODUCT_BASE_UPC_NO,
                  -PRODUCT_LITRES_PER_CONTAINER, -PRD_CONTAINER_PER_SELL_UNIT,
                  -PRODUCT_SUB_CLASS_NAME) %>%
    rename(Type = PRODUCT_CLASS_NAME,
           Subtype = PRODUCT_MINOR_CLASS_NAME,
           Name = PRODUCT_LONG_NAME,
           Country = PRODUCT_COUNTRY_ORIGIN_NAME,
           Alcohol_Content = PRODUCT_ALCOHOL_PERCENT,
           Price = CURRENT_DISPLAY_PRICE,
           Sweetness = SWEETNESS_CODE)
  bcl$Type <- sub("^REFRESHMENT BEVERAGE$", "REFRESHMENT", bcl$Type)
  dir.create("data", showWarnings = FALSE)
  write.csv(bcl, filename, row.names = FALSE)
}

ui <- fluidPage(
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, c(25, 40), pre = "$"),
      uiOutput("typeSelectOutput"),
      checkboxInput("filterCountry", "Filter by country", FALSE),
      conditionalPanel(
        condition = "input.filterCountry",
        uiOutput("countrySelectorOutput")
      ),
      br(),
      "Data source:", 
      tags$a("OpenDataBC",
             href = "https://www.opendatabc.ca/dataset/bc-liquor-store-product-price-list-current-prices"),
      br(),
      span("Created by", a(href = "http://deanattali.com", "Dean Attali"))
    ),
    mainPanel(
      h2(textOutput("summaryText")),
      downloadButton("download", "Download results"),
      br(),
      plotOutput("plot"),
      br(), br(),
      #tableOutput("prices")
      DT::dataTableOutput("prices")
    )
  )
)

server <- function(input, output, session) {
  output$countrySelectorOutput <- renderUI({
    selectInput("countryInput", "Country",
                sort(unique(bcl$Country)),
                selected = "CANADA")
  })
  
  output$typeSelectOutput <- renderUI({
    selectInput("typeInput", "Product type",
                sort(unique(bcl$Type)),
                multiple = TRUE,
                selected = unique(bcl$Type))
  })
  
  output$summaryText <- renderText({
    numOptions <- nrow(prices())
    if (is.null(numOptions)) {
      numOptions <- 0
    }
    paste0("We found ", numOptions, " options for you")
  })
  
  prices <- reactive({
    prices <- bcl
    
    if (is.null(input$countryInput)) {
      return(NULL)
    }
    
    prices <- dplyr::filter(prices, Type %in% input$typeInput)
    if (input$filterCountry) {
      prices <- dplyr::filter(prices, Country == input$countryInput)
    }
    prices <- dplyr::filter(prices, Price >= input$priceInput[1],
                            Price <= input$priceInput[2])
    
    if(nrow(prices) == 0) {
      return(NULL)
    }
    prices
  })
  
  output$plot <- renderPlot({
    if (is.null(prices())) {
      return(NULL)
    }
    
    ggplot(prices(), aes(Alcohol_Content, fill = Type)) +
      geom_histogram(colour = "black") +
      theme_classic(20)
  })
  
  output$prices <- DT::renderDataTable({
    prices()
  })
  
  output$download <- downloadHandler(
    filename = function() {
      "bcl-results.csv"
    },
    content = function(con) {
      write.csv(prices(), con)
    }
  )
}

shinyApp(ui = ui, server = server)