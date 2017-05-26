library(magrittr)
library(tidyr)
library(stringr)
library(ggplot2)

air.crash <- read.csv("/home/demirmeltem/Statistical-Computing-Project/final_project/aircrash_new.csv")

air.crash <- na.omit(air.crash)
air.crash <- air.crash %>% separate(Date, into = c("Month","Day","Year"))
air.crash$Location <- as.character(air.crash$Location)
#air.crash$Location <- gsub(".*", "", air.crash$Location)
air.crash <- air.crash %>% separate(Location, into = c("City", "Country"), sep = "[,]", fill = "left")
air.crash <- air.crash[-c(8, 9, 11, 12)]
air.crash$Accident.Year <- as.numeric(air.crash$Accident.Year)
colnames(air.crash) <- c("Accident.Month" ,"Accident.Day", "Accident.Year", "Accident.Time", "Accident.City",
                         "Accident.Country", "Aircraft.Operator", "Aircraft.Type", "Number.Aboard", "Number.of.Dead", "Deaths.on.Ground", "Summary")

#air.crash.private <- subset(air.crash, air.crash$Aircraft.Operator == "Private")
head(air.crash)

#Graphs

## Crash Situtaion
months <- as.data.frame(table(air.crash$Accident.Month))
months_graph <- ggplot(months, aes(Var1, Freq))
months_graph + geom_bar(fill = "lightpink4", stat="identity", position = position_stack(reverse = TRUE))+
  xlab("Months") + ylab("Crashes") +
  ggtitle("Total Number of Crashes Per Month") +
  coord_flip() + 
  theme(legend.position = "top")

years <- as.data.frame(table(air.crash$Accident.Year))
years_graph <- ggplot(years, aes(x = Var1, y = Freq, group=1))
years_graph + geom_line(color="darkblue", linetype = 1) +
  xlab("Years") + ylab("Crashes") + 
  ggtitle("Total Number of Crashes Per Year") + 
  scale_x_discrete(breaks = seq(from=1908, to=2009, by=10)) + geom_point(color = "black", size=1)
  
days <- as.data.frame(table(air.crash$Accident.Day))
days_graph <- ggplot(days, aes(x = Var1, y = Freq, group=1))
days_graph + geom_line(color="darkred", linetype = 2) +
  xlab("Days") + ylab("Crashes") + 
  ggtitle("Total Number of Crashes Per Day") + 
  geom_point(color = "black", size=1) 
  
##Death Percent

deads_by_year <- aggregate(data=air.crash, Number.of.Dead ~ Accident.Year, FUN=sum)
number_dead <- ggplot(deads_by_year, aes(x=Number.of.Dead, y=Accident.Year))+ geom_line()
library(timeline)
#timeline çizdir








