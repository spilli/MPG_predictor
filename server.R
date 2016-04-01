library(shiny) 

# Fit a linear regression model on the mtcars dataset from the datasets package. 
# This section runs only once when the app starts
data(mtcars)
fit <- lm(mpg ~ disp + am + carb ,mtcars)

shinyServer(
    function(input, output) {
        
        output$idf <- renderTable({ 
            data.frame(displacement = input$disp,
                       transmission = input$am,
                       carburetors = input$carb
            ) 
        })
        
        am <- reactive({ ifelse(input$am == "Automatic",0,1) })
        df <- reactive({ data.frame(disp = input$disp,am = am(), carb = input$carb) })
        
        predMpg <- reactive({ predict(fit,df(),levels=0.95, interval = "confidence") })
        output$pred <- renderText({ round(predMpg()[1],2) })
        output$confInt <- renderPrint({ round(predMpg()[2:3],2) })
        
        output$myplot <- renderPlot({
            par(mfrow=c(1,2),mar=c(4,4,2,1))
            
            with(mtcars,plot(mpg~disp));abline(lm(mpg~disp,mtcars),lwd=3)
            abline(v=input$disp,lwd=5,col="red")
            
            with(mtcars,plot(mpg~carb));abline(lm(mpg~carb,mtcars),lwd=3)
            abline(v=input$carb,lwd=5,col="red")
        })
        
        output$fitSum <- renderPrint(summary(fit))

    } 
)