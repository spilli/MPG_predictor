library(shiny) 
shinyUI(pageWithSidebar(
    headerPanel("Miles Per Gallon Predictor"), 
    sidebarPanel(
        h4('Enter the details of your concept car'),
        numericInput('cyl','Number of Cylinders',4,min=4,max=8,step=2),
        sliderInput('hp','Gross Horse Power (hp)',value=110,min=50,max=300,step=1),
        sliderInput('wt','Vehicle weight (lbs)',2000,min=1400,max=5000,step=10),
        sliderInput('disp','Engine displacement (cu. in.)',200,min=100,max=400,step=1),
        selectInput("am","Transmission type",c("Automatic" = "Automatic", "Manual" = "Manual")),
        tags$br(),tags$br(),tags$br(),
        p('Author : Sridhar Pilli'),
        p('Email  : spilli27@gmail.com')
    ),
    mainPanel(
        h4('This application lets you predict the miles per gallon of a concept car based
           on the number of cylinders, horse power, vehicle weight, engine displacement and 
           the type of transmission.'),

        tags$br(),
        h4('Description of input parameters'),
        h6('Number of cylinders can be either 4 or 6 or 8.'),
        h6('Horse power can be any value from 50hp to 350hp in steps of 1hp.'),
        h6('Weight of the vehicle can be 1000 to 5000 lbs in steps of 1lb.'),
        h6('Engine displacement can be 100 cu.in. to 400 cu.in in steps of 1 cu.in. '),
        h6('Transmission type can be either Automatic or Manual.'),
        
        tags$br(),
        h4('Input values you entered'),
        tableOutput("idf"),
        plotOutput("myplot"),

        #h4('The input values are sent to the following linear regression model'),
        #verbatimTextOutput("fitSum"),
        
        tags$br(),
        h4('The predicted miles per gallon is'),
        verbatimTextOutput("pred"),
        h4('The 95% confidence interval of the predicted mpg is'),
        verbatimTextOutput("confInt"),
        
        tags$br(),
        p('The model used here to predict the mpg is a linear regression model fitted 
            on the mtcars dataset from the datsets package in R. ')
        
    ) 
))

