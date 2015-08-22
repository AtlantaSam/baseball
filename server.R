library(shiny)
#library(Lahman)
#data(Teams)
library(ggplot2)

#Teams = read.csv("Teams.csv") # read file from Lahman data
## subset on a few variables
#teams <- subset(Teams, lgID %in% c("AL", "NL"))
#teams <- subset(teams, yearID>1950)
## drop some variables
#teams <- subset(teams, select=-c(Ghome,divID,DivWin:WSWin,name,park,teamIDBR:teamIDretro))
#teams <- subset(teams, select=-c(HBP,CS,BPF,PPF,X2B,X3B,W,L,BB,SO,SB,SF,RA,ER,ERA,CG,SHO,SV,IPouts,HA,HRA,BBA,SOA,E,DP,FP,attendance))
#write.csv(teams,"teams2.csv") # save file - hoping to improve performance

Teams = read.csv("teams2.csv") 

# Define server logic required to plot various variables against year
shinyServer(function(input, output) {
  
  # Compute the forumla text in a reactive function
  formulaText <- reactive({
    paste(input$variable,
          "Per Game Per Team",
          input$range[1], "to", input$range[2])
  })
  
  # Return the formula text for printing as a caption
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a plot of the requested variable 
  output$statPlot <- renderPlot({
    Teams.recent <- subset(Teams, yearID >= input$range[1] &
                             yearID <= input$range[2])
    Teams.recent$stat.game <- Teams.recent[, input$variable] / Teams.recent[, "G"]
    print(ggplot(Teams.recent, aes(yearID, stat.game)) + geom_point() +
            geom_smooth(size=2, color="red", method="loess", 
                        span=input$decimal) + 
            xlab("YEAR") + ylab("Average Per Game Per Team")   
    )
  }, width=600, height=500)
})