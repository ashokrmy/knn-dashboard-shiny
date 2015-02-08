
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
shinyUI(navbarPage("Navbar!",
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
                            sidebarLayout(
                              sidebarPanel(
                                selectInput('plot.type', 'Plot Type',
                                            c("box", "density"),
                                            selected = "density")
                                
                              ),
                              
                              # Show a plot of the generated distribution
                              mainPanel(
                                plotOutput("distPlot")
                              )
                            ))
))
