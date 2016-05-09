#' Created on 2016.05.09
#' 
#' @author: yalei


library(shiny)
library(leaflet)


shinyUI(navbarPage("莆田害人医院分布", id="nav",
 tabPanel("Interactive leaflet Map",
    div(class="outer",
      tags$head(
        # Include our custom CSS
        includeCSS("styles.css"),
        includeScript("gomap.js")
      ),

      leaflet::leafletOutput("map", width="100%", height="100%"),
      
      absolutePanel(id = "controls", class = "panel panel-default", 
                    fixed = TRUE, draggable = TRUE, 
                    top = 60, left = "auto", 
                    right = 20, bottom = "auto",
                    width = 330, height = "auto",
                    
                    h2("参数调整"),
                    checkboxInput('is_density', '密度', value = FALSE),
                    
                    sliderInput('barCityTop', '最密集城市', min = 5, max = 20, value = 10),
                    plotOutput("barCity", height = 400)
                  )
      )
    )
))
