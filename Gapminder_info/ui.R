#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(gapminder)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
    
    title = "Gapminder Information",
    
    tabPanel(title = "Instructions",
             fluidPage(h3("Instructions - Documentation"),br(),
                       p(strong("Objective:"), "The objective of this app is to let the user gain easy to use insights of the data contained on the Gapminder dataset"),
                       p(strong("Dataset:"), "Let's recall that the Gapminder dataset is an excerpt of the Gapminder data on life expectancy, GDP per capita, and population by country every 5 years."),
                       p(strong("Instructions:"), "The app is simple and easy to use. It consists of a sidebar panel and 4 tabs for analysis. Let's make a quick description of each:"),
                       p("- Sidebar: contains widget inputs for the user to filter data"),
                       p("- Life expectancy tab:"))
             ),
    
    
    ############################################################################
    tabPanel(title="Interactions over time",
             fluidPage(
                 plotlyOutput("animation")
             )),
    
    ############################################################################
    tabPanel(title="Geospacial analysis",
             fluidPage(
                 
                 sidebarPanel(
                     
                  sliderInput("year",
                              "Year of measurement:",
                              min = 1952,
                              max = 2007,
                              value = 2007,
                              step=5
                              ),
                  
                  radioButtons("selected_var",
                               label="Variable",
                               choices = c("Life expectancy"="life_exp",
                                                             "Population"="pop",
                                                             "GDP per capita"="GDP")),
                  width = 3
                 ),
                 
                 mainPanel(plotlyOutput("maps_by_year_and_var"),
                           br(),
                           dataTableOutput("maps_table"),
                           width = 9)
            ))
))
