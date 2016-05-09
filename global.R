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