# Purpose: Cleans raw data
# Author: Daniel Xu 
# Date: 23 september 2024
# Contact: danie.xu@mail.utoronto.ca
# License: MIT
# Pre-requisites: raw_data file downloaded
# Any other information needed? NA

# Workspace setup 

library(tidyverse)

#load data
raw_data <- read_csv("data/raw_data/raw_data.csv")

#create a new population column for each year
view(raw_data)
cleaned_data <- raw_data %>%
  mutate(
    population_2014 = ASSAULT_2014 * 10000 / ASSAULT_RATE_2014,
    population_2015 = ASSAULT_2015 * 10000 / ASSAULT_RATE_2015,
    population_2016 = ASSAULT_2016 * 10000 / ASSAULT_RATE_2016,
    population_2017 = ASSAULT_2017 * 10000 / ASSAULT_RATE_2017,
    population_2018 = ASSAULT_2018 * 10000 / ASSAULT_RATE_2018,
    population_2019 = ASSAULT_2019 * 10000 / ASSAULT_RATE_2019,
    population_2020 = ASSAULT_2020 * 10000 / ASSAULT_RATE_2020,
    population_2021 = ASSAULT_2021 * 10000 / ASSAULT_RATE_2021,
    population_2022 = ASSAULT_2022 * 10000 / ASSAULT_RATE_2022,
    population_2023 = ASSAULT_2023 * 10000 / ASSAULT_RATE_2023
  )

#remove the non-rate, population2023, geometry columns

cleaned_data <- cleaned_data %>%
  select(-starts_with("ASSAULT_20"), -starts_with("AUTOTHEFT_20"), -starts_with("BIKETHEFT_20"),
         -starts_with("BREAKENTER_20"), -starts_with("HOMICIDE_20"), -starts_with("ROBBERY_20"),
         -starts_with("SHOOTING_20"), -starts_with("THEFTFROMMV_20"), -starts_with("THEFTOVER_20"),
         -"POPULATION_2023",-"geometry")

#rearrange data to separate years from crime type

cleaned_data <- pivot_longer(cleaned_data,4:103,names_to = "crime_type_and_year", values_to = "y") #pivot table to separate years
cleaned_data <- cleaned_data %>%
  mutate(year = str_extract(crime_type_and_year, "_\\d{4}"),     # extract year from crime_type_and_year
         crime_type = str_remove(crime_type_and_year, "_\\d{4}"))  # remove the year from crime_type_and_year
cleaned_data <- cleaned_data %>%
  select(-"crime_type_and_year")

#pivot the data wider so each crime type becomes a separate column

cleaned_data <- cleaned_data %>%
  pivot_wider(id_expand = FALSE,names_from = crime_type, values_from = y)
cleaned_data$year <- gsub("_", "", cleaned_data$year)

#save data 

write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
