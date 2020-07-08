library(shiny)
library(lubridate)

# Define UI for random distribution application 
shinyUI(pageWithSidebar(
    
    headerPanel("FANNG Stock Chart"),
    
    sidebarPanel(
        
        helpText("Select One Stock Among FAANG Stocks."),
        
        selectInput(inputId="symbol", label="Choose one",choices=c("FB","AMZN","AAPL","NFLX","GOOG")),
       
        dateRangeInput("dates", 
                       "Interval",
                       start = "2017-01-01", end = today()),
        
        selectInput(inputId="ReturnType", label="Choose Return Type",choices=c("Daily","Weekly","Monthly","Quarterly","Yearly")), 
        actionButton("get", "Get Chart"),
        
        br(),
        br(),
        br(),
        
      
        div(
            wellPanel(
                selectInput("chart_type",
                            label = "Chart type",
                            choices = c("Candlestick" = "candlesticks", 
                                        "Matchstick" = "matchsticks",
                                        "Bar" = "bars",
                                        "Line" = "line"),
                            selected = "Line"
                ),
               
            ),
            
            wellPanel(
                p(strong("Additional Technical Analysis")),
                checkboxInput("ta_vol", label = "Volume", value = FALSE),
                checkboxInput("ta_sma", label = "Simple Moving Average", 
                              value = FALSE),
                checkboxInput("ta_wma", label = "Weighted Moving Average", 
                              value = FALSE),
                checkboxInput("ta_bb", label = "Bolinger Bands", 
                              value = FALSE),
                
                
                br(),
                
                actionButton("chart_act", "Add Technical Analysis")
            )
        )
        
    ),
    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
        
        plotOutput("chart"),
        br(),
        br(),
        
        plotOutput("retchart")
      
    )
))