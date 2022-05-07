#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to do the model
shinyServer(function(input, output) {
    cars$speedsp <- ifelse(cars$speed - 15 > 0, cars$speed - 15, 0)
    model1 <- lm(dist ~ speed, data = cars)
    model2 <- lm(dist ~ speedsp + speed, data = cars)
    model1pred <- reactive({
        speedInput <- input$sliderSpeed
        predict(model1, newdata = data.frame(speed = speedInput))
    })
    
    model2pred <- reactive({
        speedInput <- input$sliderSpeed
        predict(model2, newdata =
                    data.frame(speed = speedInput,
                               speedsp = ifelse(speedInput - 15 > 0,
                                              speedInput - 15, 0)))
    })
    
    output$plot1 <- renderPlot({
        speedInput <- input$sliderSpeed
        plot(cars$speed, cars$dist, xlab = "Speed (mph)",
             ylab = "Stopping distance (ft)", bty = "n", pch = 16,
             xlim = c(3, 25), ylim = c(-2, 125))
        
        if(input$showModel1){
            abline(model1, col = "red", lwd = 2)
        }
        
        if(input$showModel2){
            model2lines <- predict(model2, newdata = data.frame(
                speed = 4:25, speedsp = ifelse(4:25 - 15 > 0, 4:25 - 15, 0)
            ))
            lines(4:25, model2lines, col = "blue", lwd = 2)
        }
        
        legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
               col = c("red", "blue"), bty = "n", cex = 1.2)
        
        if(input$showModel1){
            points(speedInput, model1pred(), col = "red", pch = 16, cex = 2)
        }
        
        if(input$showModel2){
            points(speedInput, model2pred(), col = "blue", pch = 16, cex = 2)
        }
    })
    
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
        model2pred()
    })
    
    output$about <- renderUI({
        HTML(paste("Welcome to the Predict Stopping Distance from Speed app, that was developed for the Developing Data Products Course, from Coursera. This app calculates the distance that a car takes to stop given its speed, using the cars dataset from [R].", 
                   "You just need to select the speed of the car and click in the Submit button. This information will be used to calculate the stopping distance of the car.",
                   "In the plot, the user will see the results of two linear prediction models. User can select if he/she want to see the two models or just one.", sep='<br/> <br/>'))
        
    })
    
})
