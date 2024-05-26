# Load necessary libraries
library(ggplot2)
library(readr)
library(dplyr)

# Load the data
url <- "https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true"
data <- read_csv(url)

# Filter the data for the years 1984 to 1994
data_filtered <- data %>% filter(year >= 1984 & year <= 1994)

# Print the number of rows and columns
print(nrow(data_filtered))
print(ncol(data_filtered))

# Create the plot
ggplot(data_filtered, aes(x = year, y = total_prison_pop)) +
  geom_line() +
  labs(title = "Trend of Prison Population Over Time (1984-1994)",
       x = "Year",
       y = "Total Prison Population") +
  theme_minimal()
