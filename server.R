
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#' Created on 2016.05.09
#' 
#' @author: yalei


library(shiny)
library(magrittr)
library(leaflet)
library(lattice)
library(htmlwidgets)


shinyServer(function(input, output) {
  ## barplot of cities
  city_tb = substr(hospital$name, 1, 2) %>% table %>% sort(decreasing = T)
  if (is_mac){
    scales_list = list('fontfamily' = 'STKaiti')
  }else{
    scales_list = list()
  }
  output$barCity <- renderPlot({
    lattice::barchart(city_tb[1:input$barCityTop], scales = scales_list,
                      xlab = paste('Top', input$barCityTop),
                      panel = function(x, y, ...){
                        panel.barchart(x, y, ...);
                        ltext(x=x + 1.5, y=y, labels=x, cex = 0.8)
                      })
  })
  
  ## interactive leaflet map
  output$map <- renderLeaflet({
    base_map <- leaflet() %>% registerPlugin(heatPlugin) %>%
      addTiles(
        urlTemplate = urlTemplates[as.integer(input$theme)],
        attribution = attributions[as.integer(input$theme)]
      ) %>% 
      addCircleMarkers(lng=hospital$lon, lat=hospital$lat, 
                       popup=hospital$name, radius = 3, fill = FALSE,
                       opacity = input$opacity, color = theme_colors[as.integer(input$theme)]) %>%
      htmlwidgets::onRender("function(el, x, data) {
                            data = HTMLWidgets.dataframeToD3(data);
                            data = data.map(function(val) { return [val.lat, val.lon, 1]; });
                            L.heatLayer(data, {radius:15,blur:15,minOpacity:0.5}).addTo(this);
      }", data = hospital[, 1:2]) %>%
      setView(113.66950, 34.76974, zoom = 4)
  })
})


## Reference
# https://bl.ocks.org/timelyportfolio/8f6c8cc27597466351ad377e6774c30f
# devtools::install_github('Ramnath/htmlwidgets')