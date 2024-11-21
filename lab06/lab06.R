library(jsonlite)
library(ggplot2)
library(lubridate)
data.url <- "https://opendata.cwa.gov.tw/fileapi/v1/opendataapi/F-D0047-055?Authorization=CWA-D05E3B5F-8791-4E2F-90AF-08BF0CF1F525&format=JSON"
data.file <- "Hsinchu_Weather_Forecast.json"
download.file(url = data.url, destfile = data.file)
data <- fromJSON(data.file)

my.location <- data$cwaopendata$dataset$locations$location
my.weatherElement <- my.location[[which(my.location$locationName == "東區"), "weatherElement" ]]

my.T <- my.weatherElement[[which(my.weatherElement$elementName == "T"), "time" ]]

my.maxT <- my.weatherElement[[which(my.weatherElement$elementName == "MaxT"), "time"]]

my.minT <- my.weatherElement[[which(my.weatherElement$elementName == "MinT"), "time"]]

my.df <- data.frame(time = ymd_hms(my.T$startTime, tz = "Asia/Taipei"),
                      T_value = my.T$elementValue$value,
                      max_T_value = my.maxT$elementValue$value,
                      min_T_value = my.minT$elementValue$value)

str(my.location)
str(my.weatherElement)
str(my.df)
ggplot(my.df, aes(x=time, group = 1 )) +
  geom_line(aes(x=time, y=max_T_value, group=1))+
  geom_line(aes(x=time, y=min_T_value, group=1))