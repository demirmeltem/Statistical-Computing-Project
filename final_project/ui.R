library(shiny)

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
                                      tabPanel("Crash Situation"),
                                      tabPanel("Death Percent"),
                                      tabPanel("Crash Location"),
                                      tabPanel("Aircraft Operator"),
                                      tabPanel("Aircraft Type"),
                                      tabPanel("Word Cloud of Summary")
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