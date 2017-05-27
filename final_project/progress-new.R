library(magrittr)
library(tidyr)
library(stringr)
library(ggplot2)


air.crash <- read.csv("/home/demirmeltem/Desktop/Statistical-Computing-Project/final_project/aircrash_new.csv")

#air.crash <- read.csv("/home/demirmeltem/Statistical-Computing-Project/final_project/aircrash_new.csv")

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

p1 <- ggplot(deads_by_year, aes(x = Accident.Year, y = Number.of.Dead))
p1 + geom_point() + geom_smooth() + 
  xlab("Accident Year") + ylab("Number of Dead") + 
  ggtitle("Death by Years")
  

Deads <- ddply(air.crash, c("Accident.Year"), summarise,
               total_deads = sum(Number.of.Dead), total_passengers = sum(Number.Aboard))

p2 <- ggplot(Deads, aes(y = (total_deads/total_passengers)*100, x = Deads$Accident.Year))  + 
  geom_point() + 
  geom_smooth() + 
  xlab("Years") + ylab("% Deads") + 
  ggtitle("Percent of Death by Years")
p2

##Crash Countries, cities

air.crash$Accident.Country <- str_trim(air.crash$Accident.Country, side = "both")

library(plyr)

Countries <- ddply(air.crash, c("Accident.Country"), summarise,
                   total_deads = sum(!is.na(Number.of.Dead)))

Countries <- Countries[order(Countries$total_deads, decreasing = TRUE), ]

Countries <- head(Countries, 10)

p3 <- ggplot(Countries, aes(x=Accident.Country, y=total_deads, alpha = total_deads))
p3 + geom_bar(stat = "identity", fill = "brown", position = position_stack(reverse = TRUE), width = 0.5) +
  coord_flip() +
  xlab("Countries") + ylab("Number of Deaths") + 
  ggtitle("Top 10 Countries with Maximum Fatalities")


##Aircraft Operator

Operators <- ddply(air.crash, c("Aircraft.Operator"), summarise,
                   total_deads = sum(!is.na(Number.of.Dead)))

Operators <- Operators[order(Operators$total_deads, decreasing = TRUE), ]

Operators <- head(Operators, 10)

p4 <- ggplot(Operators, aes(y= total_deads, x = Aircraft.Operator, alpha = total_deads))
p4 + geom_bar(stat = "identity", fill = "navy", position = position_stack(reverse = TRUE), width = 0.5) +
  coord_flip() +
  xlab("Aircraft Operators") + ylab("Number of Deaths") + 
  ggtitle("Top 10 Aircraft Operator causing Aircrash")

##Aircraft Type


Types <- ddply(air.crash, c("Aircraft.Type"), summarise,
                   total_deads = sum(!is.na(Number.of.Dead)))

Types <- Types[order(Types$total_deads, decreasing = TRUE), ]

Types <- head(Types, 10)

p4 <- ggplot(Types, aes(y= total_deads, x = Aircraft.Type, alpha = total_deads))
p4 + geom_bar(stat = "identity", fill = "#1C5219", position = position_stack(reverse = TRUE), width = 0.5) +
  coord_flip() +
  xlab("Aircraft Type") + ylab("Number of Deaths") + 
  ggtitle("Top 10 Aircraft Type causing Aircrash")


##Word Cloud
library(wordcloud2)


