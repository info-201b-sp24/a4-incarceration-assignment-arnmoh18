# Load necessary libraries
library(dplyr)
library(readr)

# Load the data
url <- "https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true"
data_us <- read_csv(url)

data <- read_csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-jail-rates-1990-WA.csv")
data_wa <- data %>% filter(state == "WA")
data_wa <- data_wa %>% clean_names()
data_wa$county_name <- str_replace(data_wa$county_name, " County", "")
data_wa$county_name <- tolower(data_wa$county_name)


# Find the year with the highest black prison population
highest_black_pop_year <- data_us %>% filter(black_prison_pop == max(black_prison_pop, na.rm = TRUE)) %>% pull(year)

# Find the year with the lowest black prison population
lowest_black_pop_year <- data_us %>% filter(black_prison_pop == min(black_prison_pop, na.rm = TRUE)) %>% pull(year)

# Find the year with the peak total prison population
peak_year <- data_us %>% filter(total_prison_pop == max(total_prison_pop, na.rm = TRUE)) %>% pull(year)

# Find the two counties with the highest total jail population rate
top_county <- data_wa %>% 
  arrange(desc(total_jail_pop_rate)) %>% 
  slice(1) %>% 
  pull(county_name)

highest_jail_pop_county <- top_county

# Find the year with the lowest black prison population
lowest_black_pop_year <- data_us %>% filter(black_prison_pop == min(black_prison_pop, na.rm = TRUE)) %>% slice(1) %>% pull(year)

# Find the county with the lowest total jail population rate
lowest_jail_pop_county <- data_wa %>% 
  arrange(total_jail_pop_rate) %>% 
  slice(1) %>% 
  pull(county_name)

# Print the varibles
print(paste("The year with the highest black prison population is", highest_black_pop_year))
print(paste("The year with the lowest black prison population is", lowest_black_pop_year))
print(paste("The year with the peak total prison population is", peak_year))
print(paste("The county with the highest total jail population rate is", highest_jail_pop_county))
print(paste("The county with the lowest total jail population rate is", lowest_jail_pop_county))
