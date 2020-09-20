## Load libraries

library(shiny)
library(tidyverse)
library(gapminder)
library(plotly)


## Load dataset for the app

gapminder_data_set <- gapminder::gapminder %>% inner_join(gapminder::country_codes)


# Define server logic
shinyServer(function(input, output) {

    ############################################################################
    
    output$animation <- renderPlotly({
        
        animation_plot <- plot_ly(x=gapminder_data_set$gdpPercap,
                                  y=gapminder_data_set$lifeExp,
                                  size=gapminder_data_set$pop,
                                  color=gapminder_data_set$continent,
                                  frame=gapminder_data_set$year,
                                  text=paste("Country: ",gapminder_data_set$country,"\n",
                                             "Pop: ",gapminder_data_set$pop,"\n",
                                             "Life exp: ",gapminder_data_set$lifeExp,"\n",
                                             "GDP per cap: ",gapminder_data_set$gdpPercap,"\n"),
                                  hoverinfo="text",
                                  type="scatter",
                                  mode="markers") %>% 
                            layout(xaxis=list(type="log"))
        
        animation_plot
    })
    
    
    ############################################################################
    
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
    
    ############################################################################
    
    output$maps_table <- renderDataTable({
        
        maps_filtered_data <- filter(gapminder_data_set, year == input$year)
        
        map_table <- maps_filtered_data %>% select(continent, iso_alpha, country,
                                                   lifeExp, pop, gdpPercap) %>% 
                                            arrange(desc(switch(input$selected_var,
                                                                life_exp=lifeExp,
                                                                pop=pop,
                                                                GDP=gdpPercap)))
        map_table
    })
    
    ############################################################################
    
    output$trends_plot <- renderPlotly({
         
         trends_data_set <- gapminder_data_set %>% pivot_longer(cols = -c(country,continent,
                                                                          year,iso_alpha,iso_num),
                                                                names_to="data_var")
         trends <- ggplot(trends_data_set,
                             aes(x=year,y = value, color=country))+
                         geom_line()+
                         facet_grid(rows=vars(data_var),cols = vars(continent),scales = "free_y" )+
                         theme_bw()+
                         theme(legend.position = "none")+
                         scale_color_manual(values=gapminder::country_colors)
         
         trends <- ggplotly(trends)
        
         trends
    })
    
    ############################################################################
    
    output$prediction_plot <- renderPlotly({
        
        data_for_country <- filter(gapminder_data_set, country==input$country_var) %>% 
                            pivot_longer(cols = -c(country,continent,
                                                      year,iso_alpha,iso_num),
                                                   names_to="data_var")
        
        pred_plot <- ggplot(data_for_country,aes(year,value, color=data_var))+
                        geom_point()+
                        geom_smooth(method="lm")+
                        facet_wrap(~data_var, scales="free")+
                        theme_bw()+
                        theme(legend.position = "none")
        
        pred_plot <- ggplotly(pred_plot)
        
        pred_plot
        
        })
    
    ############################################################################
    
    output$pred_life_exp <- renderText({
        
        data_for_prediction <- filter(gapminder_data_set, country==input$country_var)
        
        model_life_exp <- lm(lifeExp~year,data=data_for_prediction)
        
        prediction_life_exp <- predict(model_life_exp,newdata=data.frame(year=as.double(input$year_pred)))
        
        prediction_life_exp
        
    })
    
    ############################################################################
    
    output$pred_pop <- renderText({
        
        data_for_prediction <- filter(gapminder_data_set, country==input$country_var)
        
        model_life_exp <- lm(pop~year,data=data_for_prediction)
        
        prediction_life_exp <- predict(model_life_exp,newdata=data.frame(year=as.double(input$year_pred)))
        
        prediction_life_exp
        
    })
    
    ############################################################################
    
    output$pred_gdp <- renderText({
        
        data_for_prediction <- filter(gapminder_data_set, country==input$country_var)
        
        model_life_exp <- lm(gdpPercap~year,data=data_for_prediction)
        
        prediction_life_exp <- predict(model_life_exp,newdata=data.frame(year=as.double(input$year_pred)))
        
        prediction_life_exp
        
    })
    
})
