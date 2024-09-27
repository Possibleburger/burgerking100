# Purpose: Simulates example
# Author: Daniel Xu 
# Date: 23 september 2024
# Contact: danie.xu@mail.utoronto.ca
# License: MIT
# Pre-requisites: none
# Any other information needed? NA


# Workspace setup 

library(tidyverse)
set.seed(100)

# Define neighbourhoods and years

neighbourhood <- 1:148 # neighbourhood numbers (in actual data not uniform 1-148 some numbers are not included so goes up to 174)
year <- 2013:2023 # Range of years

#Create combination of neighbourhoods and years 

data <- expand.grid(Neighbourhood = neighbourhood, Year = year)

# Convert to tibble

data <- as_tibble(data)

# Add crime statistic columns
data <- data %>%
  mutate(
    Population = sample(5000:10000, nrow(data), replace = TRUE),
    Assault = sample(1:50, nrow(data), replace = TRUE),
    Autotheft = sample(1:50, nrow(data), replace = TRUE),
    Biketheft = sample(1:50, nrow(data), replace = TRUE),
    Breakandenter = sample(1:50, nrow(data), replace = TRUE),
    Homicide = sample(1:50, nrow(data), replace = TRUE),
    Robbery = sample(1:50, nrow(data), replace = TRUE),
    Shooting = sample(1:50, nrow(data), replace = TRUE),
    Theftfrommv = sample(1:50, nrow(data), replace = TRUE),
    TheftOver = sample(1:50, nrow(data), replace = TRUE),
  )

# Arrange by neighbourhood

data <- data %>% arrange(Neighbourhood, Year)

# output data into file
write.csv(data, file = "data/raw_data/simulated.csv")




