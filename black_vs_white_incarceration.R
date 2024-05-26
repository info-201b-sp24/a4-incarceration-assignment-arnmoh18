# Load necessary libraries
library(ggplot2)
library(readr)

# Load the data
url <- "https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true"
data <- read_csv(url)

# Create the plot
ggplot() +
  geom_line(data = data, aes(x = year, y = black_prison_pop, color = "Black Prison Population")) +
  geom_line(data = data, aes(x = year, y = white_prison_pop, color = "White Prison Population")) +
  labs(title = "Comparison of Black and White Prison Populations Over Time",
       x = "Year",
       y = "Population",
       color = "Population Type") +
  theme_minimal()
