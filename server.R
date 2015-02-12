
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
 
  
#   output$value <- renderText({ paste("Classification Error = ",ce(test.Y,knn.pred)) })
  
  
cat( length(knn.pred), length(test.Y)) 
  output$confusionMatrix <- renderDataTable({
    # modify this to show title - confusion matrix
    # /false positive/positive false negative/negative
    true.positive    <- sum(knn.pred == "positive" & test.Y == "positive")
    false.positive   <- sum(knn.pred == "negative" & test.Y == "positive")
    true.negative    <- sum(knn.pred == "negative" & test.Y == "negative")
    false.negative   <- sum(knn.pred == "positive" & test.Y == "negative")
    output$value <- renderText({sum(true.positive, false.positive,
                                    false.negative, true.negative)})
    row.names <- c("Prediction - FALSE", "Prediction - TRUE" )
    col.names <- c("Reference - FALSE", "Reference - TRUE")
    cbind(Outcome = row.names, as.data.frame(matrix( 
      c(true.negative, false.negative, false.positive, true.positive) ,
            nrow = 2, ncol = 2, dimnames = list(row.names, col.names))))
    }, options = table.settings
  )
    
  })
   
    observe({
     
       output$distPlot <- renderPlot({

         (ggpairs(original.ds[,c(input$pairs.feature.A,
                                 input$pairs.feature.B,
                                 input$pairs.feature.C,"num")],
                  upper = "blank", columns = 1:3,
                  lower = list(continuous = "points", combo = "dot"),
                ,color = "num"))


         
       })
<<<<<<< HEAD
   })
  observe({
    input_feature_x <- prop("x",as.symbol(input$featureDisplay_x))
    input_feature_y <- prop("y",as.symbol(input$featureDisplay_y))
    
         
         data.frame(ds) %>%
           ggvis(x = input_feature_x, y = input_feature_y, 
                 fill = ~factor(num))%>%
           layer_points()%>%
      add_legend("fill",title = "Heart Disease", values = c("negative",  "positive")) %>%
=======
    })
  observe({output$feature <- renderText({ (input$featureDisplay) })
           input_feature_x <- prop("x",as.symbol(input$featureDisplay_x))
           input_feature_y <- prop("y",as.symbol(input$featureDisplay_y))
           
         
         data.frame(ds) %>%
           ggvis(x = input_feature_x,input_feature_y, fill = ~factor(num ))%>%
           layer_points()%>%
           add_legend("fill", title = "Heart Disease" )%>%
>>>>>>> origin/master
         bind_shiny("ggvis", "ggvis_ui")
#       data.frame(ds) %>%
#         ggvis(x = input_feature_x, fill = ~factor(num))%>%
#         group_by(num)%>%
#           layer_histograms(stack = T)%>%
#         bind_shiny("ggvis", "ggvis_ui")
        
  })
   
})
