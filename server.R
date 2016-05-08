
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(magrittr)
library(leaflet)
library(lattice)
library(DT)


shinyServer(function(input, output) {
  ## barplot of cities
  city_tb = substr(df$name, 1, 2) %>% table %>% sort(decreasing = T)
  if (is_mac){
    scales_list = list('fontfamily' = 'STKaiti')
  }else{
    scales_list = list()
  }
  output$barCity <- renderPlot({
    lattice::barchart(city_tb[1:input$barCityTop], scales = scales_list,
                      panel = function(x, y, ...){
                        panel.barchart(x, y, ...);
                        ltext(x=x + 1.5, y=y, labels=x, cex = 0.8)
                      })
  })
  
  ## interactive map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles(
        urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
        attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
      ) %>%  
      addCircleMarkers(lng=df$lon, lat=df$lat, 
                       popup=df$name, radius = 3, 
                       opacity = 0.3) %>%
      setView(lng = mean(df$lon), lat = mean(df$lat), zoom=4)
  })
})


# X=cbind(df$lon, df$lat)
# kde2d <- KernSmooth::bkde2D(X, bandwidth=c(bw.ucv(X[,1]),bw.ucv(X[,2])),
#                             gridsize = c(10, 10))
# contour(kde2d$x1, kde2d$x2, kde2d$fhat)
# 
# CL = contourLines(kde2d$x1, kde2d$x2, kde2d$fhat)
# density_level = sapply(CL, function(x) x$level)
# m = leaflet() %>%
#   addCircleMarkers(lng=df$lon, lat=df$lat, 
#                    popup=df$name, radius = 3, 
#                    opacity = 0.3) %>%
#   setView(lng = mean(df$lon), lat = mean(df$lat), zoom=4)
# 
# for (i in seq_along(CL)){
#   m = m %>% addPolygons(CL[[i]]$x,CL[[i]]$y,
#                         fillColor = ifelse(density_level[i] >= quantile(density_level, 0.75), "red", 'yellow'), stroke  = FALSE,
#                         opacity = density_level[i] * 100 * 0.8)
# }
# m
