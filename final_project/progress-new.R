library(magrittr)
library(tidyr)
library(stringr)
library(ggplot2)

air.crash <- read.csv("/home/demirmeltem/Desktop/statistical_final_report/aircrash_new.csv")

air.crash <- na.omit(air.crash)
air.crash <- air.crash %>% separate(Date, into = c("Month","Day","Year"))
air.crash$Location <- as.character(air.crash$Location)
#air.crash$Location <- gsub(".*", "", air.crash$Location)
air.crash <- air.crash %>% separate(Location, into = c("City", "Country"), sep = "[,]", fill = "left")
air.crash <- air.crash[-c(8, 9, 11, 12)]

colnames(air.crash) <- c("Accident.Month" ,"Accident.Day", "Accident.Year", "Accident.Time", "Accident.City",
                         "Accident.Country", "Aircraft.Operator", "Aircraft.Type", "Number.Aboard", "Number.of.Dead", "Deaths.on.Ground", "Summary")

#air.crash.private <- subset(air.crash, air.crash$Aircraft.Operator == "Private")
head(air.crash)

#Graphs

months <- ggplot(air.crash, aes(Accident.Month))

months + geom_bar(aes(fill = Number.of.Dead), position = position_stack(reverse = TRUE)) + coord_flip() + theme(legend.position = "top")
