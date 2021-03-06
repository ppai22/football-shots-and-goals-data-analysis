library(tidyverse)

source('constants.R')
source('data_load.R')


FetchData <- function(team.name, season=NULL) {
  
  df <- LoadData()
  
  team.df <- filter(df, HomeTeam == team.name | AwayTeam == team.name)
  
  if (!is.null(season)) {
    if (is.element(season, kSeasons)) {
      team.df <- filter(team.df, Season == season)
    }
  }
  
  avg.shots.home <- sum(filter(team.df, HomeTeam == team.name)$HS) / nrow(filter(team.df, HomeTeam == team.name))
  avg.shots.away <- sum(filter(team.df, AwayTeam == team.name)$AS) / nrow(filter(team.df, AwayTeam == team.name))
  avg.shots <- (sum(filter(team.df, HomeTeam == team.name)$HS) +
                  sum(filter(team.df, AwayTeam == team.name)$AS)) / nrow(team.df)

  avg.shots.on.target.home <- sum(filter(team.df, HomeTeam == team.name)$HST) / nrow(filter(team.df, HomeTeam == team.name))
  avg.shots.on.target.away <- sum(filter(team.df, AwayTeam == team.name)$AST) / nrow(filter(team.df, AwayTeam == team.name))
  avg.shots.on.target <- (sum(filter(team.df, HomeTeam == team.name)$HST) +
                            sum(filter(team.df, AwayTeam == team.name)$AST)) / nrow(team.df)
  avg.shots.on.target

  avg.goals.home <- sum(filter(team.df, HomeTeam == team.name)$FTHG) / nrow(filter(team.df, HomeTeam == team.name))
  avg.goals.away <- sum(filter(team.df, AwayTeam == team.name)$FTAG) / nrow(filter(team.df, AwayTeam == team.name))
  avg.goals <- (sum(filter(team.df, HomeTeam == team.name)$FTHG) +
                  sum(filter(team.df, AwayTeam == team.name)$FTAG)) / nrow(team.df)


  home.shots.goals.data <- c(avg.goals.home, avg.shots.on.target.home, avg.shots.home)
  away.shots.goals.data <- c(avg.goals.away, avg.shots.on.target.away, avg.shots.away)
  full.shots.goals.data <- c(avg.goals, avg.shots.on.target, avg.shots)

  team.data <- data.frame(team.name,
                          avg.shots.home,
                          avg.shots.on.target.home,
                          avg.goals.home,
                          avg.shots.away,
                          avg.shots.on.target.away,
                          avg.goals.away)
  
  return(team.data)
  
}


FetchDataTeamForSeasons <- function(team, seasons = c()) {
  
  team.data <- LoadDataForTeam(teams = c(team))
  data <- LoadDataForSeasons(reference.data = team.data, seasons = seasons)
  
  return(data)
    
}
