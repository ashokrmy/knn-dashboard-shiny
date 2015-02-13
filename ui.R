# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)


shinyUI(navbarPage("KNN - UCI Heart Disease Data",
                   tabPanel("Results",
                            
                            # Application title
                            titlePanel("Classification of Heart Disease w/KNN"),
                            
                            # Sidebar with a slider input for number of bins
                            sidebarLayout(
                              sidebarPanel(
                                sliderInput("k",
                                            "number of neighbors",
                                            min = 1,
                                            max = 20,
                                            value = 5),
                                checkboxGroupInput("checkGroup", label = h3("Dataset Features"), 
                                                   choices = feature.list, inline = T,
                                                   selected = names(feature.list))
                                
                              ),
                              
                              # Show a plot of the generated distribution
                              mainPanel(
                                dataTableOutput('confusionMatrix'),
                                p('K-Nearest Neighbors...'),
                                verbatimTextOutput("value")
                                
                              )
                            )
                            
                   ), 
                   tabPanel("EDA",
                            
                            fluidRow(
                              column(4,uiOutput("hist_x_ui"),
                                     ggvisOutput("hist_x")),
                              
                              column(4, uiOutput("scatter_2feature_ui"),
                                     ggvisOutput("scatter_2feature")),
                              column(4,uiOutput("hist_y_ui"),
                                     ggvisOutput("hist_y"))
                            ),
                            hr(),
                            
                            
                            fluidRow(
                              
#                            
                              column(6,offset = 4, selectInput("featureDisplay_x", label = h3("Feature A"), 
                                                    choices = feature.list),
                                     selectInput("featureDisplay_y", label = h3("Feature B"), 
                                                 choices = feature.list))
                              
                            )
                            
                   ),
                   
                   
                   tabPanel("About",
                            fluidRow(
                              column(10,
                                     includeMarkdown("include.Rmd")
                              )
                            )
                            
                   )
))