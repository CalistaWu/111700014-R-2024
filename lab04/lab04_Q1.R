#install.packages("jsonlite")
library(jsonlite)
library(tidyverse)
library(magrittr)
library(ggplot2)

data.file <- "data.json"
data.url <- "https://ods.railway.gov.tw/tra-ods-web/ods/download/dataResource/8ae4cabf6973990e0169947ed32454b9"
download.file( url= data.url,destfile = data.file )

data <- fromJSON(data.file)
Hsinchu_dt <- filter( data, staCode =="1210" )

Hsinchu_dt <- Hsinchu_dt %>%
  mutate(trnOpDate = as.Date(as.character(trnOpDate), format = "%Y%m%d")) %>%
  filter(format(trnOpDate, "%d") == "01")

ggplot(Hsinchu_dt, aes( x = trnOpDate, y = gateInComingCnt, group = 1)) +
  geom_line() +
  geom_point() +
  labs( title = "Hsin Chu Station",
        x = "Date",
        y = "Gate In Coming Count" ) +
  theme_minimal()
