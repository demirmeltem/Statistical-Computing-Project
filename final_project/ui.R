library(shiny)
library(magrittr)
library(tidyr)
library(stringr)
library(ggplot2)

shinyUI(fluidPage(
  
  navbarPage("Menu",
             tabPanel("Problem",
                      sidebarLayout(position= "right",
                                    sidebarPanel(
                                      
                                    ),
                                    mainPanel(
                                      
                                    ))
             ),
             
             tabPanel("Data Preparation",
                      sidebarLayout(position= "right",
                                    sidebarPanel(
                                      
                                    ),
                                    mainPanel(
                                      tabsetPanel(
                                        tabPanel("Original Data"),
                                        tabPanel("Data Cleaning"),
                                        tabPanel("Summary of Dataset")
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
                                                            plotOutput("by_years", height = 550)),
                                                   tabPanel("By Months",
                                                            plotOutput("by_months", height = 550)),
                                                   tabPanel("By Days", 
                                                            plotOutput("by_days", height = 550))
                                                 )),
                                        tabPanel("Death Percent",
                                                 tabsetPanel(
                                                  tabPanel("Death by Years",
                                                           plotOutput("no_percent", height = 550)),
                                                  tabPanel("Percentage of Death by Years",
                                                           plotOutput("percent", height = 550))
                                                 )),
                                        tabPanel("Crash Location",
                                                 plotOutput("crash_location", height = 550)),
                                        tabPanel("Aircraft Operator",
                                                 plotOutput("aircraft_operator", height = 550)),
                                        tabPanel("Aircraft Type",
                                                 plotOutput("aircraft_type", height = 550)),
                                        tabPanel("Word Cloud",
                                                 plotOutput("word_cloud", height = 550))
                                      )
                                      
                                    ))
             ),
             
             tabPanel("Summary",
                      sidebarLayout(position= "right",
                                    sidebarPanel(
                                      
                                    ),
                                    mainPanel(
                                      
                                    ))
             )
             
             
             )
  
))
