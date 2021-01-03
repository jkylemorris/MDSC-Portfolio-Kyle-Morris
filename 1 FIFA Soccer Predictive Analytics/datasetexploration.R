library(ggplot2)
library(pastecs)

fifaUltimate <- read.csv("fifa19ultimate.csv", header = TRUE)
fifaGame <- read.csv("fifagamedata.csv", header = TRUE)
worldCup <- read.csv("wc2018-players.csv", header = TRUE)
worldCup <- worldCup[-c(5)]

fifaUltimateNA <- fifaUltimate[complete.cases(fifaUltimate), ]
fifaGameNA <- fifaGame[complete.cases(fifaGame), ]
worldCupNA <- worldCup[complete.cases(worldCup), ]

badFifaUltimate <- nrow(fifaUltimate) - nrow(fifaUltimateNA)
badFifaGame <- nrow(fifaGame) - nrow(fifaGameNA)
badWorldCup <- nrow(worldCup) - nrow(worldCupNA)

badFifaUltimate * 100 / nrow(fifaUltimate)
badFifaGame * 100 / nrow(fifaGame)
badWorldCup * 100 / nrow(worldCup)

ggplot(subset(fifaUltimate, ps4_last > 0), aes(x = ps4_last, y = overall)) +
  geom_point(position = "jitter", alpha = 0.3) +
  geom_smooth(col = "red")

ggplot(fifaUltimate, aes(x = age, y = overall)) +
  geom_point(position = "jitter", alpha = 0.3) +
  geom_smooth(col = "red")

round(stat.desc(fifaUltimate$overall, basic = FALSE), digits = 3)

ggplot(fifaGame, aes(x = Age, y = Overall)) +
  geom_point(position = "jitter", alpha = 0.3) +
  geom_smooth(col = "red")

ggplot(fifaGame, aes(x = Age, y = Potential - Overall)) +
  geom_point(position = "jitter", alpha = 0.3) +
  geom_smooth(col = "red")

round(stat.desc(fifaGame$Overall, basic = FALSE), digits = 3)

bw <- 2 * IQR(worldCup$Age) / length(worldCup$Age)^(1/3)
ggplot(worldCup, aes(x = Age)) +
  geom_histogram(binwidth = bw)

round(stat.desc(worldCup$Age, basic = FALSE, norm = TRUE), digits = 3)

cleanFifaGame <- subset(fifaGame, select = c("Name", "Age", "Overall", "Potential", "Club","Position", "Height", "Weight", "Crossing", "Finishing", "HeadingAccuracy" , "ShortPassing" , "Volleys" , "Dribbling" , "Curve", "FKAccuracy", "LongPassing" , "BallControl" , "Acceleration" , "SprintSpeed" , "Agility" , "Reactions", "Balance" , "ShotPower" , "Jumping" , "Stamina" , "Strength" , "LongShots", "Aggression" , "Interceptions" , "Positioning", "Vision" , "Penalties" , "Composure", "Marking" , "StandingTackle" , "SlidingTackle" , "GKDiving" , "GKHandling", "GKKicking", "GKPositioning", "GKReflexes"))
cleanFifaGameNA <- cleanFifaGame[complete.cases(cleanFifaGame), ]

head(cleanFifaGameNA)
