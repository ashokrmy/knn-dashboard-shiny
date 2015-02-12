# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

# shinyUI(navbarPage("Navbar!",
#                    tabPanel("Plot",
#                             sidebarLayout(
#                               sidebarPanel(
#                                 radioButtons("plotType", "Plot type",
#                                              c("Scatter"="p", "Line"="l")
#                                 )
#                               ),
#                               mainPanel(
#                                 plotOutput("plot")
#                               )
#                             )
#                    ),
#                    tabPanel("Summary",
#                             verbatimTextOutput("summary")
#                    )
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
                            
                            plotOutput("distPlot"),
                            hr(),
                            
                            fluidRow(
                              
                              column(4, offset = 1,
                                     selectInput( 'pairs.feature.A', 'Feature A', feature.list, selected = names(feature.list)[1]),
                                     selectInput('pairs.feature.B', 'Feature B', feature.list,selected = names(feature.list)[2]),
                                     selectInput( 'pairs.feature.C', 'Feature C', feature.list,selected = names(feature.list)[3])
                                     
                              )
                              
                            )
                            
                   ),
                   
                   
                   tabPanel("GGVIS",
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("featureDisplay_x", label = h3("X-Axis"), 
                                            choices = feature.list),
                                selectInput("featureDisplay_y", label = h3("Y-Axis"), 
                                            choices = feature.list)
                                
                              ),
                              
                              # Show a plot of the generated distribution
                              mainPanel(
                                uiOutput("ggvis_ui"),
                                ggvisOutput("ggvis"),
                                verbatimTextOutput("feature")
                              )
                            ))
))