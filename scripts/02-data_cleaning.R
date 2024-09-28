# Purpose: Cleans raw data
# Author: Daniel Xu 
# Date: 23 september 2024
# Contact: danie.xu@mail.utoronto.ca
# License: MIT
# Pre-requisites: none
# Any other information needed? NA

# Workspace setup 

library(tidyverse)

# Clean data 
raw_data <- read_csv("data/raw_data/raw_data.csv")

# Create a new population column for each year

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

# Remove the non-rate columns and Population 2023

cleaned_data <- cleaned_data %>%
  select(-starts_with("ASSAULT_20"), -starts_with("AUTOTHEFT_20"), -starts_with("BIKETHEFT_20"),
         -starts_with("BREAKENTER_20"), -starts_with("HOMICIDE_20"), -starts_with("ROBBERY_20"),
         -starts_with("SHOOTING_20"), -starts_with("THEFTFROMMV_20"), -starts_with("THEFTOVER_20"),
         -"POPULATION_2023",-"geometry")

# Save data 

write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
