library(magrittr)
library(tidyr)
library(stringr)
library(ggplot2)
library(plyr)
library(dplyr)
library(wordcloud)
library(RColorBrewer)

#air.crash <- read.csv("/home/demirmeltem/Desktop/Statistical-Computing-Project/final_project/aircrash_new.csv")

air.crash <- read.csv("/home/demirmeltem/Statistical-Computing-Project/final_project/aircrash_new.csv")

air.crash <- na.omit(air.crash)
air.crash <- air.crash %>% separate(Date, into = c("Month","Day","Year"))
air.crash$Location <- as.character(air.crash$Location)
#air.crash$Location <- gsub(".*", "", air.crash$Location)
air.crash <- air.crash[-c(7, 8, 10, 11)]
air.crash <- air.crash %>% separate(Location, into = c("City", "Country"), sep = "[,]", fill = "left")
air.crash$Accident.Country <- as.factor(air.crash$Accident.Country) 

colnames(air.crash) <- c("Accident.Month" ,"Accident.Day", "Accident.Year", "Accident.Time", "Accident.City",
                         "Accident.Country", "Aircraft.Operator", "Aircraft.Type", "Number.Aboard", "Number.of.Dead", "Deaths.on.Ground", "Summary")

#colnames(air.crash) <- c("Accident.Month" ,"Accident.Day", "Accident.Year", "Accident.Time", "Accident.Location",
 #                        "Aircraft.Operator", "Aircraft.Type", "Number.Aboard", "Number.of.Dead", "Deaths.on.Ground", "Summary")
air.crash$Accident.Year <- as.numeric(air.crash$Accident.Year)
#air.crash.private <- subset(air.crash, air.crash$Aircraft.Operator == "Private")
head(air.crash)

