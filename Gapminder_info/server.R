## Load libraries

library(shiny)
library(tidyverse)
library(gapminder)
library(plotly)


## Load dataset for the app

gapminder_data_set <- gapminder::gapminder %>% inner_join(gapminder::country_codes)


# Define server logic
shinyServer(function(input, output) {

    output$maps_by_year_and_var <- renderPlotly({
        
        # filter data according to year
        maps_filtered_data <- filter(gapminder_data_set, year == input$year)
        
        # selected variable and plot
        plot_map <- plot_ly(maps_filtered_data,
                            type="choropleth",
                            locations=maps_filtered_data$iso_alpha,
                            z=switch(input$selected_var,
                                     life_exp=maps_filtered_data$lifeExp,
                                     pop=maps_filtered_data$pop,
                                     GDP=maps_filtered_data$gdpPercap)
                            )
        
        plot_map
    })
    
    output$maps_table <- renderDataTable({
        
        maps_filtered_data <- filter(gapminder_data_set, year == input$year)
        
        map_table <- maps_filtered_data %>% select(continent, country, lifeExp, pop, gdpPercap) %>% 
                                            arrange(desc(switch(input$selected_var,
                                                                life_exp=lifeExp,
                                                                pop=pop,
                                                                GDP=gdpPercap)))
        map_table
    })
    
    
})
