


library(shinythemes)
library(shiny)
library(shinydashboard)
library(caTools)
# Define UI for application that draws a histogram
shinyUI(

    # Application title
    
 navbarPage( 

   
   
   theme = shinytheme("cerulean"),"A SHINY APP!! ", 
         tabPanel("Information",
                  fluidRow(column(6,offset = 3,tags$img(src = "shiny.PNG"))),
                  fluidRow(column(10,offset=1,tags$b(headerPanel("STUDENT RESULT ANALYSIS AND PREDICTION SYSTEM" )))),
                  hr(),
                  tags$i(tags$h1("About The App:")),
                  tags$p("This webapp is designed in R using shiny. Here Analysis
                         of data is already done and ML(Machine learning)
                         models are created for result  prediction . This application 
                         allow users to predict their own results based upon the data 
                         they uploaded.
                         shiny application is Reactive in Nature it do real time
                         processing.Means users are able to perform visualisation
                         at the run time just by selecting inputs. ",style="font-size:16px;"),
                  tags$i(tags$h1("Data and Information:")),
                  tags$p("This dataset is taken from the UCI Machine Learing Repository",
                         style="font-size:16px;",
                         tags$a(tags$img(src="download.PNG"),href="http://archive.ics.uci.edu/ml/datasets/Student+Performance#"),
                         tags$p("This data approach student achievement in secondary 
                                education of two Portuguese schools. The data attributes
                                include student grades, demographic, social and school 
                                related features) and it was collected by using school
                                reports and questionnaires. Two datasets are provided 
                                regarding the performance in two distinct subjects: Mathematics (mat)
                                and Portuguese language (por). In [Cortez and Silva, 2008], the 
                                two datasets were modeled under binary/five-level classification 
                                and regression tasks. Important note: the target attribute G3 has a
                                strong correlation with attributes G2 and G1. This occurs because G3
                                is the final year grade (issued at the 3rd period), while G1 and G2 
                                correspond to the 1st and 2nd period grades. It is more difficult to 
                                predict G3 without G2 and G1, but such prediction is much more useful 
                                but here Analysis is done on Modified data.",style="font-size:16px;")
                         
                         ),
                  tags$i(tags$h1("Attribute Information:")),
                  tags$p("1) Pstatus - parent's cohabitation status (binary: 'T' - living together or 'A'- apart) ", br(),
                         "2) Medu - mother's education (numeric: 0 - none, 1 - primary education (4th grade), 2 â€“ 5th to 9th grade, 3 â€“ secondary education or 4 â€“ higher education)",br(),
                         "3) Internet - Internet access at home (binary: yes or no) ",br(),
                         "4) Romantic - with a romantic relationship (binary: yes or no) ",br(),
                         "5) G1 - first period grade (numeric: from 0 to 20) ",br(),
                         "6) G2 - second period grade (numeric: from 0 to 20) ",br(),
                         "7) G3 - final grade (numeric: from 0 to 20, output target)"
                         
                         
                         
                         ,br(),"This G3 variable is used for classifying Pass vs Fail 
                         and students grades into Fail, Sufficient, Satisfactory, Good
                         and Excellent. These classifications will be predicted based 
                         on some independent variables.",br(),"
                         Refrence Links ",a(href="https://rstudio-pubs-static.s3.amazonaws.com/83442_bbbda163e43a432dbc1906b0a6b4141a.html","https://rstudio-pubs-static.s3.amazonaws.com/83442_bbbda163e43a432dbc1906b0a6b4141a.html"),
                         a(""),
                         style="font-size:16px;"),
                  br()
                  
                  
                
                  
                  ),
         
         
         
         
         
         
         
         
         
         
         
         
         
         tabPanel("Data",
                  tags$h2("Viewing DataSet"),
                  dataTableOutput("Student"),
                  br(),
                  tags$h2("Summary"),
                  
                  verbatimTextOutput("Sum"),
                  br(),
                  tags$h2("Structure"),
                  verbatimTextOutput("Str"),
                  br()
                  ),
   
   
   
   
   
   
   
         tabPanel("Visualisation",#headerPanel("Different plots of data"
              tabsetPanel(
                tabPanel("Histogram",
                sidebarLayout(
                  sidebarPanel(
                    selectInput("x.Col","x.variable",choices = names(students))),
                      #selectInput("y.col","y.variable",choices = names(students),
                              #selected = names(students)[[2]]),
                  
                  
                  mainPanel(br(),plotOutput("histPlot"),hr()))),
                  
                  tabPanel("PieChart",
                          sidebarLayout(
                            sidebarPanel(
                              selectInput("Column","Variable",choices = names(students[c(-5,-6,-7)]))
                            ),
                            mainPanel( br(),plotOutput("PiePlot"),hr())
                                        )
                          ),
                
                tabPanel("CorrPlot",br(),
                         column(6,offset=4,headerPanel("CorrPlot of G1,G2 and G3")),plotOutput("CorrPlot")),
                
                tabPanel("BoxPlot",
                        sidebarLayout(
                           sidebarPanel(
                              selectInput("X.Col","X.variable",choices=names(students)),
                              selectInput("Y.Col","Y.variable",choices = names(students[,c("G1","G2","G3")]))
                             ),
                           mainPanel( br(),plotOutput("BoxPlot"),hr())
                        )),
                tabPanel("ScatterPlot",
                         sidebarLayout(
                            sidebarPanel(
                               selectInput("S.Col","X.variable",choices=names(students[,c("G1","G2")])),
                               selectInput("T.Col","Y.variable",choices = names(students[,c("G2","G3")]))
                            ),
                            mainPanel(br(),plotOutput("ScatterPlot"))
                         ))
                
              )
         ),
      tabPanel("Predictions",
               tabsetPanel(
                tabPanel("Linear Regression",tags$h1("Predicting G3 using G1 as predictor using Linear Regression"),
                         tags$h2("Summary of Model"),verbatimTextOutput("ML"),tags$h2("Residual v/s Fitted values"),plotOutput("Res_P"), tags$h2("Testing The Model"),verbatimTextOutput("Test"),
                         tags$h2("Visualising Modeling results"),plotOutput("Mod_vis"),
                         tags$h2("Visualising Testing results"),plotOutput("Mod_Tes")
                         
             ))
 )
 
)
)
              
 
 
 
 
 
 
 
 
 
 
 
 
      
  
  
   
     
              
 
                 
        
  


