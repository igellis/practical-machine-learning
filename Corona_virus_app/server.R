#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)
library(ggplot2)
library(dplyr)

data <- read_csv("CV_LatLon_21Jan_12Mar.csv")
data$date <- as.Date(data$date, '%m/%d/%y')

df <-data%>%group_by(country, date)%>%summarize(
  confirmed = sum(confirmed), recovered = sum(recovered), death = sum(death ))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
    
    ggplot(df[df$country %in% input$country,], aes(date)) + 
      geom_line(aes(y = confirmed, colour = "confirmed")) + 
      geom_line(aes(y = recovered, colour = "recovered")) +
      geom_line(aes(y = death, colour = 'death'))
    
  })

})


