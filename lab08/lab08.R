#install.packages("shiny")
library(shiny)
#runExample("01_hello")
#faithful$eruptions
#?faithful

ui <- fluidPage(
  titlePanel("Hello NYCU!"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "bins", #variable name
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    mainPanel(
      plotOutput( outputId = "distPlot")
    )
  )
)

server <- function(input, output){
  output$distPlot <- renderPlot({
    x <- faithful$eruptions
    bins <- seq(min(x), max(x), length.out = input$bins+1)
    
    hist(x, breaks = bins, col = "#D3A4FF", border = "white",
         xlab = "Eruption time(in mins)",
         main = "Histogram of Eruptions Duration")
    
  }
    
  )
}

shinyApp(ui = ui, server = server)
