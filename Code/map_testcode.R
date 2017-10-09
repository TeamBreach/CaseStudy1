library(ggplot2)
library(fiftystater)

# map_id creates the aesthetic mapping to the state name column in your data
p <- ggplot(median_beer, aes(map_id = State_Name)) + 
  # map points to the fifty_states shape data
  geom_map(aes(fill = ABV), map = fifty_states) + 
  expand_limits(x = fifty_states$long, y = fifty_states$lat) +
  coord_map() +
  scale_x_continuous(breaks = NULL) + 
  scale_y_continuous(breaks = NULL) +
  labs(x = "", y = "") +
  theme(legend.position = "bottom", 
        panel.background = element_blank())

p
# add border boxes to AK/HI
p + fifty_states_inset_boxes() 


pb <- ggplot(median_beer, aes(map_id = State_Name)) + 
  # map points to the fifty_states shape data
  geom_map(aes(fill = IBU), map = fifty_states) + 
  expand_limits(x = fifty_states$long, y = fifty_states$lat) +
  coord_map() +
  scale_x_continuous(breaks = NULL) + 
  scale_y_continuous(breaks = NULL) +
  labs(x = "", y = "") +
  theme(legend.position = "bottom", 
        panel.background = element_blank())

pb