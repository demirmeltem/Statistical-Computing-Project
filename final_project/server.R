library(shiny)
library(magrittr)
library(tidyr)
library(stringr)
library(ggplot2)
library(plyr)
library(dplyr)
library(wordcloud)
library(RColorBrewer)
library(tm)

shinyServer(function(input, output){
  
  output$by_years <- renderPlot({
    years <- as.data.frame(table(air.crash$Accident.Year))
    years_graph <- ggplot(years, aes(x = Var1, y = Freq, group=1))
    years_graph + geom_line(color="darkblue", linetype = 1) +
      xlab("Years") + ylab("Crashes") + 
      ggtitle("Total Number of Crashes Per Year") + 
      scale_x_discrete(breaks = seq(from=1908, to=2009, by=10)) + geom_point(color = "black", size=1)
    
  })
  
  output$by_months <- renderPlot({
    months <- as.data.frame(table(air.crash$Accident.Month))
    months_graph <- ggplot(months, aes(Var1, Freq))
    months_graph + geom_bar(fill = "lightpink4", stat="identity", position = position_stack(reverse = TRUE))+
      xlab("Months") + ylab("Crashes") +
      ggtitle("Total Number of Crashes Per Month") +
      coord_flip() + 
      theme(legend.position = "top")
  })
  
  output$by_days <- renderPlot({
    
    days <- as.data.frame(table(air.crash$Accident.Day))
    days_graph <- ggplot(days, aes(x = Var1, y = Freq, group=1))
    days_graph + geom_line(color="darkred", linetype = 2) +
      xlab("Days") + ylab("Crashes") + 
      ggtitle("Total Number of Crashes Per Day") + 
      geom_point(color = "black", size=1) 
    
  })
  
  output$no_percent <- renderPlot({
    deads_by_year <- aggregate(data=air.crash, Number.of.Dead ~ Accident.Year , FUN=sum)
    p1 <- ggplot(deads_by_year, aes(x = Accident.Year, y = Number.of.Dead))
    p1 + geom_point() + geom_smooth() + 
      xlab("Accident Year") + ylab("Number of Dead") + 
      ggtitle("Death by Years")
  })
  
  output$percent <- renderPlot({
    
    Deads <- ddply(air.crash, c("Accident.Year"), summarise,
                   total_deads = sum(Number.of.Dead), total_passengers = sum(Number.Aboard))
    
    p2 <- ggplot(Deads, aes(y = (total_deads/total_passengers)*100, x = Deads$Accident.Year))  + 
      geom_point() + 
      geom_smooth() + 
      xlab("Years") + ylab("% Deads") + 
      ggtitle("Percent of Death by Years")
    p2
  })
  
  output$countries <- renderPlot({
    air.crash$Accident.Country <- str_trim(air.crash$Accident.Country, side = "both")
    
    Countries <- ddply(air.crash, c("Accident.Country"), summarise,
                       total_deads = sum(!is.na(Number.of.Dead)))
    
    Countries <- Countries[order(Countries$total_deads, decreasing = TRUE), ]
    
    Countries <- head(Countries, 10)
    
    p3 <- ggplot(Countries, aes(x=Accident.Country, y=total_deads, alpha = total_deads))
    p3 + geom_bar(stat = "identity", col = "navy", position = position_stack(reverse = TRUE), width = 0.5) +
      coord_flip() +
      xlab("Countries") + ylab("Number of Deaths") + 
      ggtitle("Top 10 Countries with Maximum Deaths")
  })
  
  output$cities <- renderPlot({
    air.crash$Accident.City <- str_trim(air.crash$Accident.City, side = "both")
    
    Cities <- ddply(air.crash, c("Accident.City"), summarise,
                    total_deads = sum(!is.na(Number.of.Dead)))
    
    Cities <- Cities[order(Cities$total_deads, decreasing = TRUE), ]
    
    Cities <- head(Cities, 10)
    Cities <- tail(Cities, 9)
    pc <- ggplot(Cities, aes(x=Accident.City, y=total_deads, alpha = total_deads))
    pc + geom_bar(stat = "identity", col = "navy", position = position_stack(reverse = TRUE), width = 0.5) +
      coord_flip() +
      xlab("Cities") + ylab("Number of Deaths") + 
      ggtitle("Top 10 Cities with Maximum Deaths")
  })
  
  output$aircraft_operator <- renderPlot({
    Operators <- ddply(air.crash, c("Aircraft.Operator"), summarise,
                       total_deads = sum(!is.na(Number.of.Dead)))
    
    Operators <- Operators[order(Operators$total_deads, decreasing = TRUE), ]
    
    Operators <- head(Operators, 10)
    #fill="navy", semi-transparency is not supported on this device
    p4 <- ggplot(Operators, aes(y= total_deads, x = Aircraft.Operator, alpha = total_deads))
    p4 + geom_bar(stat = "identity", col="brown", position = position_stack(reverse = TRUE), width = 0.5) +
      coord_flip() +
      xlab("Aircraft Operators") + ylab("Number of Deaths") + 
      ggtitle("Top 10 Aircraft Operator causing Aircrash")
    
  })
  
  output$aircraft_type <- renderPlot({
    Types <- ddply(air.crash, c("Aircraft.Type"), summarise,
                   total_deads = sum(!is.na(Number.of.Dead)))
    
    Types <- Types[order(Types$total_deads, decreasing = TRUE), ]
    
    Types <- head(Types, 10)
    #fill = "#1C5219"
    p4 <- ggplot(Types, aes(y= total_deads, x = Aircraft.Type, alpha = total_deads))
    p4 + geom_bar(stat = "identity", col = "#1C5219", position = position_stack(reverse = TRUE), width = 0.5) +
      coord_flip() +
      xlab("Aircraft Type") + ylab("Number of Deaths") + 
      ggtitle("Top 10 Aircraft Type causing Aircrash")
    
  })
  
  output$word_cloud <- renderPlot({
    
    data <- Corpus(VectorSource(air.crash$Summary))
    
    corpus_clean <- tm_map(data, tolower)
    corpus_clean <- tm_map(corpus_clean, removePunctuation)
    corpus_clean <- tm_map(corpus_clean, PlainTextDocument)
    corpus_clean <- tm_map(corpus_clean, removeNumbers)
    corpus_clean <- tm_map(corpus_clean, removeWords, stopwords("english"))
    corpus_clean <- tm_map(corpus_clean, removeWords, "flight")
    corpus_clean <- tm_map(corpus_clean, removeWords, "crashed")
    corpus_clean <- tm_map(corpus_clean, removeWords, "plane")
    corpus_clean <- tm_map(corpus_clean, removeWords, "aircraft")
    corpus_clean <- tm_map(corpus_clean, stripWhitespace)
    corpus_clean <- tm_map(corpus_clean, tolower)
    corpus_clean <- tm_map(corpus_clean, stemDocument)
    corpus_clean <- tm_map(corpus_clean, removeWords, "i")
    corpus_clean <- tm_map(corpus_clean, removeWords, "j")
    corpus_clean <- tm_map(corpus_clean, removeWords, "v")
    
    tdm <- TermDocumentMatrix(corpus_clean)
    m <- as.matrix(tdm)
    v <- sort(rowSums(m),decreasing=TRUE)
    d <- data.frame(word = names(v),freq=v)
    pal <- brewer.pal(9, "BuGn")
    pal <- pal[-(1:2)]
    
    wordcloud(corpus_clean, max.words = 100, min.freq = 35, random.order = FALSE, colors=pal)
    
    
  })
  
})

