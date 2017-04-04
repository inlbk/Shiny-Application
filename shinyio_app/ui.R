#
# This is the user-interface definition of a Shiny web application that displays
# a bar graph of the number of fatalities and/or injuries due to weather events
# for each of nine climate regions of the contiguous United States during a 
# specified span of years.  The user specifies the requested years via a 2-sided 
# slider, and there are check boxes indicating whether to include fatalities and/or
# injuries.
#
library(shiny)


# Define UI for application that draws a bar graph of fatalities/injuries
shinyUI(fluidPage(
      
      # Application title
      titlePanel("Storm Fatalities and Injuries by Region of the U.S."),
      
      # Sidebar with slider input for starting and ending years
      # and checkboxes for whether to include fatalities and/or injuries.
      sidebarLayout(
            sidebarPanel(width=3,
                  sliderInput("sliderY", "Starting and Ending Year",
                              1950, 2011, value = c(1970, 1990)),
                  checkboxInput("show_fatalities", "Include Fatalities", value = TRUE),
                  checkboxInput("show_injuries", "Include Injuries", value = TRUE)
                  #,submitButton("Submit")
            ),
            mainPanel(
                  h3(""),width=9,
                  plotOutput("plot1")
            )
      )
))
#This shiny app is published at https://inlbk.shinyapps.io/shinyio_app/