#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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


# Define UI for application that draws a histogram
shinyUI( fluidPage(
  
  # Application title
  titlePanel("Corona virus development per country over time"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      p(strong("Supporting documentation:",style="color:red")), 
      a('This application gives you insight in the development of the Corona virus. You can get insights in the number of confirmed, recovered and death cases per country over time.'),
      
      selectInput(inputId = "country",
                  label = "Select countries",
                  choices = unique(df$country)),
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))




