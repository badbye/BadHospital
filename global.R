library(jsonlite)
library(htmltools)


## check system
isMac <- function(){
  # use font family='STKaiti' if mac
  .Platform$OS.type == 'unix' & substr(.Platform$pkgType, 1, 3) == 'mac'
}
is_mac = isMac()


## download file from 'https://wandergis.com/hospital-viz/index.htm'
file_name = 'data.json'
if (!file.exists(file_name)){
  download.file('https://wandergis.com/hospital-viz/hospital.geojson', file_name)
}


## prepare data frame
data = jsonlite::fromJSON(file_name)
hospital = data.frame(do.call(rbind, data$features$geometry$coordinates))
colnames(hospital) = c('lon', 'lat')
hospital$name = data$features$properties$name


## register leaftlet-heat Plugin
heatPlugin <- htmltools::htmlDependency("Leaflet.heat", "99.99.99",
                             src = c(href = "http://leaflet.github.io/Leaflet.heat/dist/"),
                             script = "leaflet-heat.js"
)

registerPlugin <- function(map, plugin) {
  map$dependencies <- c(map$dependencies, list(plugin))
  map
}

## themes
urlTemplates = c('//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png',
                 '//webrd0{s}.is.autonavi.com/appmaptile?lang=zh_cn&size=1&scale=1&style=8&x={x}&y={y}&z={z}',
                 '//www.google.cn/maps/vt?lyrs=s@189&gl=cn&x={x}&y={y}&z={z}',
                 '//map.geoq.cn/ArcGIS/rest/services/ChinaOnlineStreetPurplishBlue/MapServer/tile/{z}/{y}/{x}')
attributions = c('Maps by <a href="http://www.mapbox.com/">Mapbox</a>',
                 '高德地图',
                 'Google Map',
                 'geoq'
                 )
theme_names = c('Mapbox' = 1, '电子地图' = 2, '卫星地图' = 3, '深色底图' = 4)
theme_colors = c('#9ecae1', '#9ecae1', '#7fcdbb', '#fde0dd')