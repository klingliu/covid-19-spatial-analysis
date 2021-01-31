library(shiny)
library(shinythemes)
library(tidyverse)
library(dplyr)
library(maps)
library(viridis)

# path_in2 <- "C:/Users/karen/Desktop/git/stat-231-private/blogproject/app folder/"
# ad_map <- read_csv(paste0(path_in2, "ad.csv"))
# sm <- read_csv(paste0(path_in2, "sm.csv"))
# actions_map <- read_csv(paste0(path_in2, "act.csv"))
# svi_map <- read_csv(paste0(path_in2, "svi.csv"))
# cities_counties <- read_csv(paste0(path_in2, "cities_counties.csv"))
# covid_cities <- read_csv(paste0(path_in2, "covid_cities.csv"))

ad_map <- read_csv("ad.csv")
sm <- read_csv("sm.csv")
actions_map <- read_csv("act.csv")
svi_map <- read_csv("svi.csv")
cities_counties <- read_csv("cities_counties.csv")
covid_cities <- read_csv("covid_cities.csv")

map_counties <- map_data(map = "county", region = ".") %>%
  rename(county = subregion, state = region) %>%
  mutate(county = case_when(county == county ~ str_to_title(county))) %>%
  mutate(state = case_when(state == state ~ str_to_title(state)))

map_counties_fips <- cities_counties %>%
  select(state, county, county_fips) %>%
  group_by(state, county, county_fips) %>%
  summarise() %>%
  inner_join(map_counties, by = c("state", "county")) %>%
  rename(county_fip = county_fips)

sm_map <- full_join(sm, map_counties_fips, by = c("county_fip", "county")) %>%
  mutate(target = log(total_post))


# define vectors for choice values and labels 
# can then refer to them in server as well (not just in defining widgets)

# for choice of dataset
#df_choices <- list(ad_map, sm_map, actions_map, svi_map)
df_choices <- c("ad_map", "sm_map", "actions_map", "svi_map")
df_choices_names <- c("Anxiety and depression during Covid-19",
                      "Social media counts for mentions of Covid-19",
                      "Stress levels associated with state mandates in response to Covid-19",
                      "CDC 2018 Social Vulnerability Index")

plot_titles <- c("Percentage of people reporting either anxiety or depression, state-level",
                 "Number of times the pandemic was mentioned in social media, monthly",
                 "Stress associated with state mandates in response to Covid-19",
                 "CDC 2018 Social Vulnerability Index")


# ui 
ui <- fluidPage(
  
  h1("Investigating Social and Emotional Factors During the Covid-19 Pandemic"),
  
  sidebarLayout(
    sidebarPanel(
      
      checkboxInput(inputId = "cities",
                    label = "Show cities on maps",
                    value = TRUE),
      radioButtons(inputId = "df1",
                   label = "Choose a dataset of interest for the first plot:",
                   choiceValues = df_choices,
                   choiceNames = df_choices_names,
                   selected = "ad_map"),
      radioButtons(inputId = "df2",
                   label = "Choose a dataset of interest for the second plot:",
                   choiceValues = df_choices,
                   choiceNames = df_choices_names,
                   selected = "ad_map"),
      radioButtons(inputId = "month",
                   label = "Choose a month of interest:",
                   choices = c("April", "May", "June", "July", "August"),
                   selected = NULL)
    ),

    mainPanel(
      
      tabsetPanel(type = "tabs",
                  tabPanel("Spatial Data",
                           plotOutput(outputId = "map1"),
                           plotOutput(outputId = "map2"))
      )
    )
  )
)

# server
server <- function(input, output){
  
  use_data1 <- reactive({
    data <- get(input$df1) %>% filter(month == input$month | is.na(month))
  })
  use_data2 <- reactive({
    data <- get(input$df2) %>% filter(month == input$month | is.na(month))
  })
  use_data_covid <- reactive({
    data <- covid_cities %>% filter(month == input$month)
  })
  
  output$map1 <- renderPlot({
    
    plot1 <- ggplot() +
      geom_polygon(data = use_data1(), aes(x = long, y = lat, group = group, fill = target), size = 0.001, colour = "white") +
      theme_void() +
      coord_fixed(ratio = 1.3) +
      labs(title = plot_titles[df_choices == input$df1],
           subtitle = "Across the United States", fill = "",
           caption = "For county-level maps, grey counties have no data.") +
      scale_fill_viridis(option = "magma", direction = -1)
    
    if (input$cities) {
      plot1 +
        geom_point(data = use_data_covid(), aes(x = lng, y = lat, size = cases), color = "green", alpha = 0.75) +
        guides(size = "none")
    } else plot1
  })
  
  output$map2 <- renderPlot({
    
    plot2 <- ggplot() +
      geom_polygon(data = use_data2(), aes(x = long, y = lat, group = group, fill = target), size = 0.001, colour = "white") +
      theme_void() +
      coord_fixed(ratio = 1.3) +
      labs(title = plot_titles[df_choices == input$df2],
           subtitle = "Across the United States", fill = "",
           caption = "For county-level maps, grey counties have no data.") +
      scale_fill_viridis(option = "magma", direction = -1)
    
    if (input$cities) {
      plot2 +
        geom_point(data = use_data_covid(), aes(x = lng, y = lat, size = cases), color = "green", alpha = 0.75) +
        guides(size = "none")
    } else plot2
  })
    
}

# call to shinyApp
shinyApp(ui = ui, server = server)


### SOME ISSUES
# Louisiana not showing up in SVI plot
# anxiety depression plot not showing for me
# labs() also needs to be interactive somehow
# make lines for county level data thinner
# also make the N/A's grey



