library(shiny)
library(quantmod)
library(VGAM)

# Define server logic for random distribution application
shinyServer(function(input, output) {
    
    # acquiring data
    dataInput <- reactive({
        if (input$get == 0)
            return(NULL)
        
        return(isolate({
            getSymbols(input$symbol,src="yahoo", auto.assign = FALSE)
        }))
    })
    
    datesInput <- reactive({
        if (input$get == 0)
            return(NULL)
        
        return(isolate({
            paste0(input$dates[1], "::",  input$dates[2])
        }))
    })
    
    returns <- reactive({ 
        if (input$get == 0)
            return(NULL)
      
        if( input$ReturnType=="Daily")
           dailyReturn(dataInput())
        else if (input$ReturnType=="Weekly")
            weeklyReturn(dataInput())
        else if (input$ReturnType=="Monthly")
            monthlyReturn(dataInput())
        else if (input$ReturnType=="Quarterly")
            quarterlyReturn(dataInput())
        else if (input$ReturnType=="Yearly")
            yearlyReturn(dataInput())
        
         
    })
     

    
  
    
  
    taOptions <- reactive({
        if (input$chart_act == 0)
            return("NULL")
        
        tas <- isolate({c(input$ta_vol, input$ta_sma,  
                          input$ta_wma,input$ta_bb )})
        funcs <- c(addVo(), addSMA(),  addWMA(),  addBBands() )
        
        if (any(tas)) funcs[tas]
        else "NULL"
    })
    
    output$chart <- renderPlot({
        
       
         if(is.null(dataInput())) return ( NULL)
        
        chartSeries(dataInput(),
                    name = input$symbol,
                    type = input$chart_type,
                    subset = datesInput(), 
                    theme = "white",
                    TA = taOptions())
    
    
    })
    
    output$retchart <- renderPlot({
        
        if(is.null(dataInput())) return ( NULL)
        
        chartSeries(returns(),
                    name = input$symbol,
                    type = input$chart_type,
                    subset = datesInput(),
                    theme = "black")
        
        
    })
    
 
    
    
})