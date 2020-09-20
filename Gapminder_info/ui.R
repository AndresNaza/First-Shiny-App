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
            )),
    
    ############################################################################
    
    tabPanel(title = "Trends",
             fluidPage(
                 plotlyOutput("trends_plot")
             )),
    
    ############################################################################
    
    
    tabPanel(title = "Linear predictions",
             fluidPage(
                 sidebarPanel(
                     
                     selectInput("country_var", "Country: ", choices=c("Afghanistan",
                                                                       "Albania",
                                                                       "Algeria",
                                                                       "Angola",
                                                                       "Argentina",
                                                                       "Australia",
                                                                       "Austria",
                                                                       "Bahrain",
                                                                       "Bangladesh",
                                                                       "Belgium",
                                                                       "Benin",
                                                                       "Bolivia",
                                                                       "Bosnia and Herzegovina",
                                                                       "Botswana",
                                                                       "Brazil",
                                                                       "Bulgaria",
                                                                       "Burkina Faso",
                                                                       "Burundi",
                                                                       "Cambodia",
                                                                       "Cameroon",
                                                                       "Canada",
                                                                       "Central African Republic",
                                                                       "Chad",
                                                                       "Chile",
                                                                       "China",
                                                                       "Colombia",
                                                                       "Comoros",
                                                                       "Congo, Dem. Rep.",
                                                                       "Congo, Rep.",
                                                                       "Costa Rica",
                                                                       "Cote d'Ivoire",
                                                                       "Croatia",
                                                                        "Cuba",
                                                                        "Czech Republic",
                                                                        "Denmark",
                                                                        "Djibouti",
                                                                        "Dominican Republic",
                                                                        "Ecuador",
                                                                        "Egypt",
                                                                        "El Salvador",
                                                                        "Equatorial Guinea",
                                                                        "Eritrea",
                                                                        "Ethiopia",
                                                                        "Finland",
                                                                        "France",
                                                                        "Gabon",
                                                                        "Gambia",
                                                                        "Germany",
                                                                        "Ghana",
                                                                        "Greece",
                                                                        "Guatemala",
                                                                        "Guinea",
                                                                        "Guinea-Bissau",
                                                                        "Haiti",
                                                                        "Honduras",
                                                                        "Hong Kong, China",
                                                                        "Hungary",
                                                                        "Iceland",
                                                                        "India",
                                                                        "Indonesia",
                                                                        "Iran",
                                                                        "Iraq",
                                                                        "Ireland",
                                                                        "Israel",
                                                                        "Italy",
                                                                        "Jamaica",
                                                                        "Japan",
                                                                        "Jordan",
                                                                        "Kenya",
                                                                        "Korea, Dem. Rep.",
                                                                        "Korea, Rep.",
                                                                        "Kuwait",
                                                                        "Lebanon",
                                                                        "Lesotho",
                                                                        "Liberia",
                                                                        "Libya",
                                                                        "Madagascar",
                                                                        "Malawi",
                                                                        "Malaysia",
                                                                        "Mali",
                                                                        "Mauritania",
                                                                        "Mauritius",
                                                                        "Mexico",
                                                                        "Mongolia",
                                                                        "Montenegro",
                                                                        "Morocco",
                                                                        "Mozambique",
                                                                        "Myanmar",
                                                                        "Namibia",
                                                                        "Nepal",
                                                                        "Netherlands",
                                                                        "New Zealand",
                                                                        "Nicaragua",
                                                                        "Niger",
                                                                        "Nigeria",
                                                                        "Norway",
                                                                        "Oman",
                                                                        "Pakistan",
                                                                        "Panama",
                                                                        "Paraguay",
                                                                        "Peru",
                                                                        "Philippines",
                                                                        "Poland",
                                                                        "Portugal",
                                                                        "Puerto Rico",
                                                                        "Reunion",
                                                                        "Romania",
                                                                        "Rwanda",
                                                                        "Sao Tome and Principe",
                                                                        "Saudi Arabia",
                                                                        "Senegal",
                                                                        "Serbia",
                                                                        "Sierra Leone",
                                                                        "Singapore",
                                                                        "Slovak Republic",
                                                                        "Slovenia",
                                                                        "Somalia",
                                                                        "South Africa",
                                                                        "Spain",
                                                                        "Sri Lanka",
                                                                        "Sudan",
                                                                        "Swaziland",
                                                                        "Sweden",
                                                                        "Switzerland",
                                                                        "Syria",
                                                                        "Taiwan",
                                                                        "Tanzania",
                                                                        "Thailand",
                                                                        "Togo",
                                                                        "Trinidad and Tobago",
                                                                        "Tunisia",
                                                                        "Turkey",
                                                                        "Uganda",
                                                                        "United Kingdom",
                                                                        "United States",
                                                                        "Uruguay",
                                                                        "Venezuela",
                                                                        "Vietnam",
                                                                        "West Bank and Gaza",
                                                                        "Yemen, Rep.",
                                                                        "Zambia",
                                                                        "Zimbabwe")),
                     
                     sliderInput("year_pred",
                                 "Wanted prediction year:",
                                 min = 2008,
                                 max = 2100,
                                 value = 2008,
                                 step=1)
                     ),
                 
                 mainPanel(plotlyOutput("prediction_plot"),
                           br(),
                           p("Predicted life expectancy: "), textOutput("pred_life_exp"),
                           br(),
                           p("Predicted Population: "), textOutput("pred_pop"),
                           br(),
                           p("Predicted GDP per capita: "), textOutput("pred_gdp")
                )
                
             ))
    
    
))
