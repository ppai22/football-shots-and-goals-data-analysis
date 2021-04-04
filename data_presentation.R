library(tidyverse)

source('D:/R/WORKING/football/data_load.R')
source('D:/R/WORKING/football/data_fetching.R')


df <- LoadData()

teams <- unique(df$HomeTeam)

data <- data.frame()

for (team in teams) {
  
  team.data <- FetchData(team.name = team)
  
  data <- rbind(data, team.data)
}

colnames(data) <- c("Team", "AvgShots", "AvgShotsOnTgt", "AvgGoals")

data <- data %>%
  gather(variable, value, AvgGoals:AvgShotsOnTgt:AvgShots)

data %>%
  ggplot(aes(y = Team, x = value, fill=variable)) +
  geom_bar(stat = "identity")

