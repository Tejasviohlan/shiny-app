
library(ggplot2)
library(shiny)
library(plotly)
library(corrplot)
library(ggExtra)
library(broom)
library(lmtest)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   plot <- reactive({ ggplot(students,aes(x=get(input$x.Col),fill=Pass)) +
             xlab(input$x.Col) + theme(
               axis.title.x = element_text(colour = "red",size = 20),
               axis.title.y  = element_text(colour = "green",size = 20),
               legend.title = element_text(size = 19),
               legend.text = element_text(size = 12),
         
               
               
               plot.title = element_text(size=30,colour = "DarkBlue")
                                       )
                   })
   
   plot1 <- reactive({ ggplot(students,aes(x=get(input$X.Col),y=get(input$Y.Col))) +
       xlab(input$X.Col) + theme(
         axis.title.x = element_text(colour = "red",size = 20),
         axis.title.y  = element_text(colour = "green",size = 20),
         legend.title = element_text(size = 19),
         legend.text = element_text(size = 12),
         
         
         
         plot.title = element_text(size=30,colour = "DarkBlue")
       )
   })
   
   plot2 <- reactive({ ggplot(students,aes(x=get(input$S.Col),y=get(input$T.Col))) +
       xlab(input$S.Col) + theme(
         axis.title.x = element_text(colour = "red",size = 20),
         axis.title.y  = element_text(colour = "green",size = 20),
         legend.title = element_text(size = 19),
         legend.text = element_text(size = 12),
         
         
         
         plot.title = element_text(size=30,colour = "DarkBlue")
       )
   })
   
 
   
   
  
  
    
    output$Student <- renderDataTable(students,options = list(pageLength =10))
    output$Sum <- renderPrint({summary(students)})
    output$Str <- renderPrint({str(students)})
        
    
    
    output$histPlot <- renderPlot({  
     # hist(students[,plot()],breaks = 12)
       plot() +  geom_histogram(stat = "count") + ggtitle(paste("Histogram of ",input$x.Col)) 
      
      
      
      })
    
    output$PiePlot <- renderPlot({
       pie(with(students,table(get(input$Column)))) + title(paste("Piechart of ",input$Column),cex.main=3,col.main="DarkBlue",font.main=3)
    })
    
    output$CorrPlot <- renderPlot({
      
      corrplot(cor(students[,c("G1","G2","G3")]),type="upper",method = "number") 
    })
    
    
    output$BoxPlot <- renderPlot({
      plot1() + geom_boxplot(aes(fill=Pass)) +geom_jitter(aes(color=romantic))+ ylab(input$Y.Col) +
        ggtitle(paste("BoxPlot of ",input$X.Col,"and",input$Y.Col))
    })
    
    output$ScatterPlot <- renderPlot({
   p<- plot2() + geom_point(aes(col=Pass,shape=Pstatus,size=romantic)) + geom_smooth()+ scale_color_manual(values=c('#999999','#E69F00'))+
        ylab(input$T.Col)
    ggMarginal(p, type = "histogram", fill="transparent")
    })
    
    
    
   
    
      set.seed(123)
      split = sample.split(students$G3, SplitRatio = 2/3)
      training_set = subset(students, split == TRUE)
      test_set = subset(students, split == FALSE)
      model <- lm(formula=G3 ~ G1,data=training_set)
    
    
   
      
    output$ML <- renderPrint({ summary(model)})
    
    
    output$Res_P <- renderPlot({
      tmp <- augment(model)
      ggplot(tmp, aes(x = .fitted, y = .resid)) +
        geom_point() +
        geom_smooth(method = loess, formula = y ~ x) 
    })
    
    
    output$Test <- renderPrint({predict(model, newdata = test_set)})
    output$Mod_vis <- renderPlot({ggplot() +
                                   geom_point(aes(x = training_set$G1, y = training_set$G3),
                                              colour = 'red') +
                                   geom_line(aes(x = training_set$G1, y = predict(model, newdata = training_set)),
                                             colour = 'blue')+
        ggtitle('G1 vs G3 (Training set)') +
        xlab('G1') +
        ylab('G3')})
    
    
    output$Mod_Tes <- renderPlot({
      ggplot() +
        geom_point(aes(x = test_set$G1, y = test_set$G3),
                   colour = 'red') +
        geom_line(aes(x = training_set$G1, y = predict(model, newdata = training_set)),
                  colour = 'blue') +
        ggtitle('G1 vs G3 (Test set)') +
        xlab('G1') +
        ylab('G3')
    })
   
    
  
  
    
    
})
    


                       



