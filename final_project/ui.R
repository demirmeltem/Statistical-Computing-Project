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

shinyUI(fluidPage(
  
  navbarPage("Menu",
             tabPanel("Description of Problem",
                      fixedRow(
                        column(12,
                               tags$h2("Aircraft Crash Data Analysis"),
                               fixedRow(
                                 column(12,
                                        tags$br(),
                                        "Aircraft Crash Data Analysis is for over 100 years beginning from the year 1908 to 2008. Air travel is the one of the most common transport in these days. The main purpose is to find which factor is more effecting on air crash. There is always reason to happen these air crashes. In this data frame, I believe that I can find a factor to cause these situations. It is important to examine our progress in overcoming the crashes. The data used for this analysis is a public dataset hosted by open Data by vincen tarel bundock. Various data cleaning steps were performed to work on a tidy dataset. After calculations, graphs were plotted to visualize the results and come to a conclusion. " ,
                                        tags$br(),
                                        tags$br(),
                                        "                  ",
                                        tags$br(),
                                        tags$img(src="http://dingo.care2.com/pictures/greenliving/1256/1255494.large.jpg", height=350, width=550))
                               )
                          
                        )
                        
                      )
                      
             ),
             
             tabPanel("Data Preparation",
                      sidebarLayout(position= "right",
                                    sidebarPanel(
                                      
                                    ),
                                    mainPanel(
                                      tabsetPanel(
                                        tabPanel("Original Data",
                                                 fixedRow(
                                                   column(12,
                                                          tags$h2("Description"),
                                                          fixedRow(
                                                            column(12,
                                                                   tags$br(),
                                                                   "The data set I used is a public dataset: “AirAircraft Crash data” which is hosted by open Data by Vincent Tarel Bundock at:", tags$a(href = "https://vincentarelbundock.github.io/Rdatasets/doc/gamclass/airAccs.html", "https://vincentarelbundock.github.io/Rdatasets/doc/gamclass/airAccs.html") ,
                                                                   tags$br(),
                                                                   tags$br(),
                                                                   "This data is including 5666 observations on the following 7 variables. All columns is at the below.",
		                                                                "The first state of the data:",
                                                                   tags$ol(
                                                                        tags$li(tags$b("Date"), "- The date on which the flight crashed."),
			                                                                  tags$li(tags$b("Time"), "- The time at which flight crashed."),   
			                                                                  tags$li(tags$b("Location"), "- Location of the crash"),
			                                                                  tags$li(tags$b("Operator"), "- The name of the flight operator"),
			                                                                  tags$li(tags$b("Flight"), "- Flight Number of the airplane that crashed"),
			                                                                  tags$li(tags$b("Route"), "- The Route of the flight"),
			                                                                  tags$li(tags$b("Type"), "- The type of flight carrier"),
			                                                                  tags$li(tags$b("Registration"), "- Description unavailable. This variable wouldn’t be used for analysis."),
			                                                                  tags$li(tags$b("cn.In"), "- Description unavailable."),
			                                                                  tags$li(tags$b("Aboard"), "- The number of passenger on board"),
			                                                                  tags$li(tags$b("Fatalities"), "- The number of deaths"),
			                                                                  tags$li(tags$b("Ground"), "- Description unavailable."),
			                                                                  tags$li(tags$b("Summary"), "- Brief summary ")),
                                                                   tags$br())
                                                          )
                                                          
                                                   )
                                                   
                                                 )),
                                        tabPanel("Data Cleaning",
                                                 tags$h2("Explanation"),
                                                 fixedRow(
                                                   column(12,
                                                          
                                                          tags$br(),
                                                          "All steps up into the end of the beginning is in Process.R. If I summarize the steps, it would be like this;",
                                          
                                                          tags$br(),
                                                          tags$br(),
                                                          "           ",
                                                          tags$br(),
                                                          tags$ol(
                                                            tags$li("Importing Dataset (in csv format)"),
                                                            tags$li("Evaluating missing values"),
                                                            tags$li("Spliting date column in day month year"),
                                                            tags$li("Spliting location column in Country and City."),
                                                            tags$li("Removing some unneccessary rows in data frame."),
                                                            tags$li("Giving new column names."),
                                                            tags$li("Converting some columns situation like factor to numeric etc..")
                                                          
                                                            
                                                          )
                                                          )
                                                 )
                                                 
                                                 ),
                                        tabPanel("Summary of Dataset",
                                                 fixedRow(
                                                   column(12,
                                                          tags$h2("Description"),
                                                          fixedRow(
                                                            column(12,
                                                                  
                                                                   tags$br(),
                                                                   "After cleaning dataset, here is the most important variables that are used for the analysis are as follows,",
                                                                   "The last state of the data:",
                                                                   tags$ol(
                                                                     tags$li(tags$b("Accident.Year"), "- The dataset can be grouped by year to see the yearly trends."),
                                                                     tags$li(tags$b("Accident.Month"), "- The dataset can be grouped by monthly trends (if any)"),   
                                                                     tags$li(tags$b("Accident.Day"), "-  The dataset can be grouped by daily trends (if any)"),
                                                                     tags$li(tags$b("Accident.Time"), "- The dataset can be grouped by hourly trends (if any)"),
                                                                     tags$li(tags$b("Accident.Country"), "-  The dataset can be grouped by country names"),
                                                                     tags$li(tags$b("Accident.City"), "- The dataset can be grouped by city names"),
                                                                     tags$li(tags$b("Aircraft.Operator"), "- This Aircraft Operator column is used to understand which operator had maximum crashes."),
                                                                     
                                                                     tags$li(tags$b("Aircraft.Type"), "- This Aircraft Type column is used to analyze which type of aircraft caused maximum crashes."),
                                                                     tags$li(tags$b("Number.Aboard"), "- This column is used to determine the percent of deaths that occured every year."),
                                                                     tags$li(tags$b("Number.of.Death"), "- This is count of deaths occured. Helpful in determing the total loss"),
                                                                     tags$li(tags$b("Deaths.on.Ground"), "- This is count of deaths on ground."),
                                                                     tags$li(tags$b("Summary"), "- This has reasons for the crash. Text mining can be performed on this column to understand the most frequent causes of aircrash. ")),
                                                                   tags$br())
                                                          )
                                                          
                                                   )
                                                   
                                                 )
                                                 )
                                      )
                                      
                                    ))
             ),
             
             tabPanel("Data Analysis",
                      sidebarLayout(position= "right",
                                    sidebarPanel(
                                
                                      
                                    ),
                                    mainPanel(
                                      tabsetPanel(
                                        tabPanel("Crash Situation",
                                                 tabsetPanel(
                                                   tabPanel("By Years", 
                                                            "The Date column that was split into Month, Year, Day and time are used here. A trend line in the Total number of crashes per year shows that 			number of crashes are reducing from the decade 1968-1978. And it was the maximum in the decade 1968-1978.",
                                                          
                                                            plotOutput("by_years", height = 450)),
                                                   tabPanel("By Months",
                                                            "The month analysis just gives a confirmation that crashes occur irrespective of the month. That means, the time of the year is not significant 			influencing parameter.",
                                                            plotOutput("by_months", height = 450)),
                                                   tabPanel("By Days", 
                                                            "The day analysis just gives a confirmation that crashes occur irrespective of the day. That means, the day of the month is not significant 			influencing parameter.",
                                                            plotOutput("by_days", height = 450))
                                                 )),
                                        tabPanel("Death Percent",
                                                 tabsetPanel(
                                                  tabPanel("Death by Years",
                                                           "First, the Deaths are grouped from the main Aircrash table grouped by the year. The total number of deaths is calculated by years. This 			information is used to plot the deaths over the year. Here we observe that the percent of deaths is increasing and decreasing with time. This 				analysis just gives a confirmation that crashes occur irrespective of the year. That means, Number of deaths by years is not a significant  				influencing parameter.",
                                                           plotOutput("no_percent", height = 450)),
                                                  tabPanel("Percentage of Death by Years",
                                                           "First, the Deaths are grouped from the main Aircrash table grouped by the year. The total number of deaths and number of passengers aboard is 			calculated. This information is used to plot the percent deaths over the year. Here we observe that the percent of deaths is decreasing with time. 			This should imply that the safety measures for the people onboard must have increased.",
                                                           plotOutput("percent", height = 450))
                                                 )),
                                        tabPanel("Crash Location",
                                                 tabsetPanel(
                                                   tabPanel("Death by Countries",
                                                            "The Location column that was spilled into country and city is used here. The data is grouped by the country and the total deaths for each country 			is calculated. Here we plot a graph to observe the top 10 countries which encountered the aircrash. It is observed that Russia and Brazil has had the 			maximum crashes out of all the Countries.",
                                                            plotOutput("countries", height = 450)),
                                                   tabPanel("Death by Cities", 
                                                            "The Location column that was spilled into country and city is used here. The data is grouped by the city and the total deaths for each city is 			calculated. Here we plot a graph to observe the top 10 cities which encountered the aircrash. It is observed that Moscow and San Paulo has had the maximum crashes out of 			all the Cities.",
                                                            plotOutput("cities", height = 450))
                                                   )),
                                        tabPanel("Operators",
                                                 "To understand which Operators caused more crashes the data is grouped by the Operator and the total deaths for each operator. Here we plot a graph to 			observe the top 10 operators which encountered the aircrash. It is observed that Aeroflot has had the maximum crashes out of all the Operators ",
                                                 plotOutput("aircraft_operator", height = 450)),
                                        tabPanel("Types",
                                                 "To understand which Airplane Type caused more crashes the data is grouped by the Type and the total deaths for each operator. Here we plot a graph to 			observe the top 10 Airplane Types which encountered the aircrash. It is observed that Douglas DC-3 has had the maximum crashes out of all the Types ",
                                                 plotOutput("aircraft_type", height = 450)),
                                        tabPanel("WordCloud",
                                                 "Here I have experimented with text mining in R on the summary column to form a word cloud that states the reasons for aircrash.",
                                                 plotOutput("word_cloud", height = 600, width = 600))
                                      
                                      
                                    ))
             )),
             
             tabPanel("Summary",
                      fixedRow(
                        column(12,
                               tags$h2("Summary of the insights from this analysis"),
                               fixedRow(
                                 column(12,
                                        tags$br(),
                                        "This analysis provides insights in observing the trend of aircrash over the years. It shows the percent of fatalities observed due to the crash. The analysis also help in determining which airline operator and types are worst to fly with. We also observe the top 10 countries which we should avoid to esacpe the crash. All these topics will be addressed and analyzed. " ,
                                        tags$br(),
                                        tags$br(),
                                        "    ",
                                        tags$br(),
                                        
                                        tags$ol(
                                          tags$li("Over the years the aircrash increased year until the decade 1968 - 1978. And then the number of crashes started reducing again, and it dropped considerably in the year 2008. The monthly crashes from 1908 were observed to check if any particular month was significantly responsible for the crash, but no such observation was made. Which implies that the crashes are well distributed through out the year."),
                                          tags$li("It was observed that with time there is a decrease in the percent of fatalities. This might imply that constructive measures have been undertaken over the years for the safety of people on board."),
                                          tags$li("A maximum number of aircrashes were observed as city in Sao Paulo. But There is not much difference between Sao Paulo and Moscow."),
                                          tags$li("A maximum number of aircrashes were observed in Brazil. But There is not much difference between Brazil and Russia. Russia is making perfect sense why we should not trip there. Clearly because of the weather condition. The other countries that followed up were Russia, Colombia, USSR, France, India, China, Indonesia, Japan, Canada."),
                                          tags$li("Aeroflot, Military - U.S. Air Force are worst operators as they have been responsible for maximum crashes."),
                                          tags$li("Douglas Dc-3 types of aircraft are most prone to crashes."),
                                          tags$li("Most crashes occured due to pilots, engine failures, approach, during take-off’s, on the runway, due to weather, mountains, land.")
                                        )
                                       )
                               )
                               
                        )
                        
                      )
                      
             )
             
             
  )
             
             
             
  
))
