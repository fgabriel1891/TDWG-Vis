
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)
library(sp)
library(rgdal)
library(htmltools)

shinyUI(
  navbarPage("TDWG-visualizer", id="vis",
             tabPanel("About", 
                      includeMarkdown("about.Rmd")),
                   
                   tabPanel("Interactive map",
                            div(class="outer",
                                
                                tags$head(
                                  # Include our custom CSS
                                  includeCSS("style.css")),

    # Show the main map 

      leafletOutput("mymap", width="100%",height = "100%"))
  
),

tabPanel("Download", 
         includeMarkdown("Download.Rmd"))))
  