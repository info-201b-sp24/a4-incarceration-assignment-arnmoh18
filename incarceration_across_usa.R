# Load necessary libraries
library(ggplot2)
library(readr)
library(maps)
library(janitor)
library(stringr)

# Read the data
data <- read_csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates-1990-WA.csv")

# Filter data for Washington state
data_wa <- data %>% filter(state == "WA")

# Clean column names
data_wa <- data_wa %>% clean_names()

# Remove " County" from county_name
data_wa$county_name <- str_replace(data_wa$county_name, " County", "")

# Convert to lowercase to match the format of the map data
data_wa$county_name <- tolower(data_wa$county_name)

# Get Washington map data
wa_map <- map_data("county", region = "washington")

# Merge the spatial and jail data
merged_data <- left_join(wa_map, data_wa, by = c("subregion" = "county_name"))

# Remove NA values or replace them with a default value
merged_data$total_jail_pop_rate[is.na(merged_data$total_jail_pop_rate)] <- 0

# Plot
ggplot() +
  geom_polygon(data = merged_data, aes(x = long, y = lat, group = group, fill = total_jail_pop_rate), color = "black", size = 0.1) +
  scale_fill_continuous(low = 'white', high = 'red', name = "Total Jail Pop. Rate",
                        label = scales::comma) +
  coord_map() +
  theme_minimal() +
  labs(title = "Total Jail Population Rate in Washington State by County")
