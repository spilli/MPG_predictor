library(shiny) 
shinyUI(pageWithSidebar(
    headerPanel("Miles Per Gallon Predictor"), 
    sidebarPanel(
        h4('Enter the details of your car'),
        sliderInput('disp','Engine displacement (cu. in.)',200,min=100,max=400,step=1),
        selectInput("am","Transmission type",c("Automatic" = "Automatic", "Manual" = "Manual")),
        numericInput('carb','Number of Carburetors',4,min=1,max=8,step=1),
        tags$br(),tags$br(),tags$br(),
        p('Author : Sridhar Pilli'),
        p('Email  : spilli27@gmail.com')
    ),
    mainPanel(
        h4('Summary'),
        h6('This application lets you predict the miles per gallon of a  car based
           on the engine displacement, the type of transmission and the number of carbureters.
           Since the predictive model is based on the data from datasets package in R from 
           the 70s, any predicted mpg would map to the one from that era.'),
        
        tags$br(),
        h4('Input values you entered'),
        tableOutput("idf"),
        plotOutput("myplot",width="100%",height = "200px"),
        
        h4('The predicted miles per gallon is'),
        verbatimTextOutput("pred"),
        h4('The 95% confidence interval of the predicted mpg is'),
        verbatimTextOutput("confInt"),
        
        h4('Linear regression model'),
        verbatimTextOutput("fitSum")
        

        
    ) 
))

