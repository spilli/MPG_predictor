library(shiny) 

# Fit a linear regression model on the mtcars dataset from the datasets package. 
# This section runs only once when the app starts
data(mtcars)
fit <- lm(mpg ~ cyl + hp + wt + disp + am + disp:cyl + cyl:hp + cyl:wt + am:hp ,mtcars)

shinyServer(
    function(input, output) {
        #output$cyl <- renderPrint({input$cyl})
        #output$hp <- renderPrint({input$hp})
        #output$wt <- renderPrint({input$wt})
        #output$disp <- renderPrint({input$disp})
        #output$am <- renderPrint({input$am})
        #output$fitSum <- renderPrint({summary(fit)})
        
        output$idf <- renderTable({ 
            data.frame(cylinders = input$cyl,
                       hp = input$hp,
                       weight = input$wt,
                       displacement = input$disp,
                       transmission = input$am
            ) 
        })
        
        am <- reactive({ ifelse(input$am == "Automatic",0,1) })
        wt <- reactive({ input$wt/1000 })
        df <- reactive({ 
            data.frame(cyl = input$cyl,
                       hp = input$hp, 
                       wt = wt(),
                       disp = input$disp,
                       am = am())
        })
        
        predMpg <- reactive({ predict(fit,df(),levels=0.95, interval = "confidence") })
        output$pred <- renderText({ round(predMpg()[1],2) })
        output$confInt <- renderPrint({ round(predMpg()[2:3],2) })
        
        output$myplot <- renderPlot({
            par(mfrow=c(2,2),mar=c(4,4,1,1))
            with(mtcars,plot(mpg~hp));abline(lm(mpg~hp,mtcars),lwd=3)
            abline(v=input$hp,lwd=5,col="red")
            
            with(mtcars,plot(mpg~I(wt*1000),xlab="wt"));abline(lm(mpg~I(wt*1000),mtcars),lwd=3)
            abline(v=input$wt,lwd=5,col="red")
            
            with(mtcars,plot(mpg~disp));abline(lm(mpg~disp,mtcars),lwd=3)
            abline(v=input$disp,lwd=5,col="red")
            
            with(mtcars,plot(mpg~cyl));abline(lm(mpg~cyl,mtcars),lwd=3)
            abline(v=input$cyl,lwd=5,col="red")
        })
        

    } 
)