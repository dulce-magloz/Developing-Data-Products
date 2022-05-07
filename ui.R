#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that predicts the stopping distance from the speed of a car
shinyUI(fluidPage(

    # Application title
    titlePanel("Predict Stopping Distance from Speed"),

    # Sidebar with a slider input for the speed of the car
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderSpeed", "What is the speed of the car?", 4, 25, value = 14),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
            submitButton("Submit")
        ),

        # Show a plot with the predicted values
        mainPanel(
            tabsetPanel(type = "tabs",
                tabPanel("Model", plotOutput("plot1"),
                h4("Predicted Stopping Distance from Model 1:"),
                textOutput("pred1"),
                h4("Predicted Stopping Distance from Model 2:"),
                textOutput("pred2")),
                
                tabPanel("About", br(), htmlOutput("about"))
                
            )
        )
    )
))
