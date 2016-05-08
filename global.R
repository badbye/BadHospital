library(jsonlite)

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
df = data.frame(do.call(rbind, data$features$geometry$coordinates))
colnames(df) = c('lon', 'lat')
df$name = data$features$properties$name