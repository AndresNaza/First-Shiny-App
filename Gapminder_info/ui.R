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
    
    tabPanel(title = "Documentation",
             fluidPage(h3("Documentation"),br(),
                       p(em(strong("Objective:")), "The objective of this app is to let the user gain easy to use insights of the data contained on the Gapminder dataset."),
                       br(),
                       p(em(strong("Dataset:")), "Data has been obtained from the 'gapminder' library on CRAN. The dataset is an excerpt of the Gapminder data on life expectancy, GDP per capita, and population by country every 5 years."),
                       br(),
                       p(em(strong("Information on the App:")), "The app is simple and easy to use. It has 4 tab panels with different analysis for the user to query. Let's make a quick description of each:"),
                       p("- ",strong("Interaction over time: "), "contains an animated scatterplot, with GDP per capita on the x-axis, life expectancy on the y-axis and population as the size of the points. The points are colored by their continent."),
                       p("- ",strong("Geospacial analysis: "), "this tab has a side panel where the user is able to filter data according to the desired year and variable to check. Filters are then calculated in the world map and the bottom table is refreshed and sorted decreasingly by the selected variable."),
                       p("- ",strong("Trends: "), "several trend graphics are displayed for the user to spot any anomaly on countries trend."),
                       p("- ",strong("Linear predictions: "), "this final tab allows the user to define a linear model by country and predict the values for a given year (until 2100)."))
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
                           p("Predicted GDP per capita: "), textOutput("pred_gdp"),
                           br(),
                           p(code("IMPORTANT:"), "Take into account that this are simple linear regressions for the activity purpose. Thus, the user must consider the characteristics of the model when interpreting the results. Otherwise some predictions may result ilogical, specially when considering the life expectancy variable.")
                )
                
             ))
    
    
))
