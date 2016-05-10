#' Created on 2016.05.09
#' 
#' @author: yalei


library(shiny)
library(leaflet)


shinyUI(
    div(class="outer",
      tags$head(
        tags$title('XX医院分布'),
        # Include our custom CSS
        includeCSS("styles.css"),
        includeScript("gomap.js"),
        tags$script(src="http://leaflet.github.io/Leaflet.heat/dist/leaflet-heat.js")
      ),

      leaflet::leafletOutput("map", width="100%", height="100%"),
      
      absolutePanel(id = "controls", class = "panel panel-default", 
                    fixed = TRUE, draggable = TRUE, 
                    top = 10, left = "auto", 
                    right = 10, bottom = "auto",
                    width = 330, height = "auto",
                    
                    h2("参数调整"),
                    selectInput('theme', '主题:',
                                choices = theme_names, 
                                selected = '深色底图'),
                    sliderInput('opacity', '散点透明度', min = 0, max = 1, value = 0.1),
                    # selectInput('is_density', '密度', 
                    #               choices = list('散点' = 'point', '密度' = 'density'),
                    #               selected = 'density'),
                    # actionButton('switch', '刷新'),
                    
                    tags$br(),
                    tags$br(),
                    sliderInput('barCityTop', '最密集城市', min = 5, max = 20, value = 10),
                    plotOutput("barCity", height = 400)
                  )
))
