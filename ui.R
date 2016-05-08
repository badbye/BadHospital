
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)
library(DT)

shinyUI(navbarPage("莆田害人医院分布", id="nav",
 tabPanel("Interactive Map",
    div(class="outer",
      tags$head(
        # Include our custom CSS
        includeCSS("styles.css"),
        includeScript("gomap.js")
      ),

      leafletOutput("map", width="100%", height="100%"),
      # tags$head(tags$script(src="http://leaflet.github.io/Leaflet.heat/dist/leaflet-heat.js")),
      # uiOutput('heatMap'),
      
      absolutePanel(id = "controls", class = "panel panel-default", 
                    fixed = TRUE, draggable = TRUE, 
                    top = 60, left = "auto", 
                    right = 20, bottom = "auto",
                    width = 330, height = "auto",
                    
                    h2("参数调整"),
                    checkboxInput('is_density', '密度', value = 0),
                    
                    sliderInput('barCityTop', '最密集城市', min = 5, max = 20, value = 10),
                    plotOutput("barCity", height = 400)
                  )
      )
    )
#  ,
#  tabPanel("Data Explorer",
#           DT::dataTableOutput("data_table")
#           )
))
