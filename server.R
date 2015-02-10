
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
 


shinyServer(function(input, output) {
  
  set.seed(1)
  
  observe({
  knn.pred <- knn(data.frame(train.X[,input$checkGroup]),
                  data.frame(test.X[,input$checkGroup]),
                  train.Y, k = input$k)
 
 
  output$value <- renderText({ paste("Classification Error = ",ce(test.Y,knn.pred)) })
  output$confusionMatrix <- renderDataTable({
    # modify this to show title - confusion matrix
    # /false positive/positive false negative/negative
    true.positive    <- sum(knn.pred == 1 & test.Y == 1)
    false.positive   <- sum(test.Y == 1) - true.positive
    true.negative    <- sum(knn.pred == 0 & test.Y == 0)
    false.negative   <- sum(test.Y == 0) - true.negative
    row.names <- c("Prediction - FALSE", "Prediction - TRUE" )
    col.names <- c("Reference - FALSE", "Reference - TRUE")
    cbind(Outcome = row.names, as.data.frame(matrix( 
      c(true.negative, false.negative, false.positive, true.negative) ,
            nrow = 2, ncol = 2, dimnames = list(row.names, col.names))))
    }, options = table.settings
  )
    
  })
   
   observe({
     
       output$distPlot <- renderPlot({
         featurePlot(x = train.X,
                     y = factor(train.Y, labels = c("Healthy", "Heart Disease")),
                     scales = list(x = list(relation="free"),
                                   y = list(relation="free")),
                     plot = input$plot.type, 
                     auto.key = list(columns = 2)
         )  
         
       })
   })
  observe({
    input_feature_x <- prop("x",as.symbol(input$featureDisplay_x))
    input_feature_y <- prop("y",as.symbol(input$featureDisplay_y))
    
         
         data.frame(ds) %>%
           ggvis(x = input_feature_x, y = input_feature_y, 
                 fill = ~factor(num))%>%
           layer_points()%>%
      add_legend("fill",title = "Heart Disease", values = c("negative",  "positive")) %>%
         bind_shiny("ggvis", "ggvis_ui")
#       data.frame(ds) %>%
#         ggvis(x = input_feature_x, fill = ~factor(num))%>%
#         group_by(num)%>%
#           layer_histograms(stack = T)%>%
#         bind_shiny("ggvis", "ggvis_ui")
        
  })
   
})
