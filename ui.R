library(shiny)

# Define UI for baseball application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Offensive Production in Baseball since 1950"),
  
  # Sidebar with controls to select the variable to plot stats
  # adding a trend line with Loess Smoothing becaue it looks cool
  sidebarPanel(
    selectInput("variable", "Choose a Baseball Statistic:",
                list("Runs" = "R",
                     "Hits" = "H", 
                     "Home Runs" = "HR" 
                     )),
    sliderInput("range", "Choose a Range of Years from 1950-2014:",
                min = 1950, max = 2014, sep="",
                value = c(1950, 2014), step = 1),
    sliderInput("decimal", "Exampine Trends with Loess Smoothing Fraction:", 
                min = 0.05, max = 0.95, value = 0.2, step= 0.05),
    helpText("visit github repo at https://github.com/AtlantaSam/baseball.git")
  ),
  
  # Show the caption and plot of the requested stat
  mainPanel(
    h3(textOutput("caption")),
    
    plotOutput("statPlot")
  )
))