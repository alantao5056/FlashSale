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
# plot of regular_price and percent_reduced
data |>
  ggplot(aes(x = regular_price, y = percent_reduced)) +
  geom_point() +
  geom_smooth(method = lm, se=FALSE) +
  scale_x_continuous(labels = scales::dollar_format()) +
  labs(x = "Original Price",
       y = "Percent Of Price Reduced",
       title = "Regular Price vs Percent of Price Reduced",
       subtitle = "a slight decrease in percent as price goes up") +
  theme_bw()

# plot of rating vs quantity_avaliable
data |>
  ggplot(aes(x = customer_rating, y = quantity_avaliable)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE) +
  labs(title = "Customer Rating and Quantity Avaliable",
       subtitle = "no obvious associations between the two",
       x = "Customer Rating",
       y = "Quantity Avaliable") + 
  theme_bw()

data |>
  summarise(average_damage_percent = mean(damage_percentage), .by = department) |>
  arrange(desc(average_damage_percent)) |>
  ggplot(aes(x= reorder(department, desc(average_damage_percent)), y = average_damage_percent)) +
  geom_col() +
  theme(axis.text.x = element_text(angle=25, vjust = 0.5)) +
  labs(title = "Damage Percentage By Department",
       subtitle = "appliances are the most easily damaged",
       x = "Department",
       y = "Damage Percentage")
  
          