library(tidyverse)

source('data_load.R')
source('data_fetching.R')



PlotPercentageShotsAndGoals <- function(season) {
  df <- LoadDataForSeasons(season)
  
  teams <- unique(df$HomeTeam)
  
  data <- data.frame()
  
  for (team in teams) {
    
    team.data <- FetchData(team.name = team)
    
    data <- rbind(data, team.data)
  }
  data
  
  data.home <- data %>% select(team.name, avg.shots.home, avg.shots.on.target.home, avg.goals.home)
  data.home$pc.goals <- data.home$avg.goals.home / data.home$avg.shots.home
  data.home$pc.missed.shots.on.target <- (data.home$avg.shots.on.target.home - data$avg.goals.home) / data.home$avg.shots.home
  data.home$pc.shots.off.target <- (data.home$avg.shots.home - data.home$avg.shots.on.target.home) / data.home$avg.shots.home
  data.home
  data.home <- data.home[order(-data.home$pc.goals),]
  row.names(data.home) <- NULL
  data.home
  
  colnames(data.home) <- c("Team", "AvgShotsHome", "AvgShotsOnTgtHome", "AvgGoalsHome",
                           "PcGoals", "PcMissedShotsOnTgt", "PcShotsOffTgt")
  
  data.home <- data.home %>%
    gather(variable, value, PcShotsOffTgt:PcGoals)
  
  data.home %>%
    ggplot(aes(y = Team, x = value, fill = variable, label = paste(as.character(round(value * 100)), "%"))) +
    geom_col(colour = "black", position = position_stack(reverse = TRUE)) +
    geom_text(size = 3, position = position_stack(reverse = TRUE, vjust = 0.5)) +
    scale_fill_brewer(palette = "Pastel2") +
    labs(title = paste("Percentage Goals, Saved Shots on Target and Shots Off Target - Season ", season))
  
}
