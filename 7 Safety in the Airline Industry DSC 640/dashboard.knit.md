---
title: "Dashboard"
author: "Kyle Morris"
date: "June 13, 2020"
output: word_document
---




```r
#Import Data
airlineSafety <- read.csv("airline-safety.csv", stringsAsFactors = FALSE)

totalPY <- sum(airlineSafety$fatalities_85_99)
totalCY <- sum(airlineSafety$fatalities_00_14)

airlineSafety$percentPY <- airlineSafety$fatalities_85_99 / totalPY
airlineSafety$percentCY <- airlineSafety$fatalities_00_14 / totalCY 

# Here we've created a percentage field, how much of the total.


topFatality <- subset(airlineSafety, airlineSafety$percentCY > .05)

A <- sum(airlineSafety$avail_seat_km_per_week) -sum(topFatality$avail_seat_km_per_week)
B <- sum(airlineSafety$incidents_85_99) - sum(topFatality$incidents_85_99)
C <- sum(airlineSafety$fatal_accidents_85_99) - sum(topFatality$fatal_accidents_85_99)
D <- sum(airlineSafety$fatalities_85_99) - sum(topFatality$fatalities_85_99)
E <- sum(airlineSafety$incidents_00_14) - sum(topFatality$incidents_00_14)
F <- sum(airlineSafety$fatal_accidents_00_14) - sum(topFatality$fatal_accidents_00_14)
G <- sum(airlineSafety$fatalities_00_14) - sum(topFatality$fatalities_00_14)
H <- 1 - sum(topFatality$percentPY)
I <- 1 - sum(topFatality$percentCY)

# I wanted to look at just the top airlines by incidents, but I didn't want
# to ignore the other 49 airlines. This lets us see just how many of the
# crashes are attributable to the top airlines.



topFatality[nrow(topFatality) + 1,] = c("All Other (49 Airlines)", A, B, C, D, E, F, G, "other", H, I)

write.csv(topFatality,"topFatality.csv")
```




