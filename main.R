library(tidyverse)
library(dplyr)

# get data
data <- read_csv("StoreData_IMMC.csv")

# rename columns
data <- data |>
  rename(department = 1,
         major_productCategory = 2,
         product_type = 3,
         make = 4,
         product = 5,
         regular_price = 6,
         reduced_price = 7,
         quantity_avaliable = 8,
         customer_rating = 9)

# remove premade labels
# delete extra columns
data <- data |>
  select(department : customer_rating) |>
  filter(department != "Department")

# format regular price and reduced price
data <- data |>
  mutate(regular_price = str_replace_all(str_replace_all(regular_price, '\\$', ''), '\\,', '')) |>
  mutate(reduced_price = str_replace_all(str_replace_all(reduced_price, '\\$', ''), '\\,', ''))

# change to numeric form
data <- data |>
  mutate(regular_price = as.numeric(regular_price)) |>
  mutate(reduced_price = as.numeric(reduced_price)) |>
  mutate(quantity_avaliable = as.numeric(quantity_avaliable)) |>
  mutate(customer_rating = as.numeric(customer_rating))

# add diff column
data <- data |>
  mutate(price_change = regular_price - reduced_price)


# plot of regular_price and price_change
data |>
  ggplot(aes(x = regular_price, y = price_change)) +
  geom_point() +
  geom_smooth(method = lm, se=FALSE) +
  scale_x_continuous(labels = scales::dollar_format()) +
  scale_y_continuous(labels = scales::dollar_format()) +
  labs(x = "Original Price",
       y = "Price Reduced",
       title = "Regular Price vs Amount of Price Reduced",
       subtitle = "the reduced price increases as the original price increases") +
  theme_bw()

# plot of rating vs quantity_avaliable
data |>
  ggplot(aes(x = customer_rating, y = quantity_avaliable)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE)

#
data <- data |>
  mutate(damage_percentage = customer_rating/quantity_avaliable) |>
  arrange(desc(damage_percentage))
