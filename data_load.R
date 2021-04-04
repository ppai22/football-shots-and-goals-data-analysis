library(tidyverse)

LoadData <- function() {
  
  kPath <- "D:/R/WORKING/football/data"
  
  kSeasons <- c("2011-12", "2012-13", "2013-14", "2014-15", "2015-16", "2016-17", "2017-18", "2018-19")
  
  kCols <- c("Date", "HomeTeam", "AwayTeam", "FTHG", "FTAG", "FTR", "Referee", "HS", "AS", "HST", "AST", "HY", "AY", "HR", "AR")
  
  
  full.data <- data.frame(matrix(ncol=length(kCols), nrow=0))
  
  colnames(full.data) <- kCols
  
  for (season in kSeasons) {
    
    year <- paste(season, ".csv", sep="")
    
    file_path <- file.path(kPath, year)
    
    data <- read.csv(file_path)
    
    
    data.refined <- data[, kCols]
    
    year.col <- rep(c(season), times=nrow(data.refined))
    
    data.refined$Season <- year.col
    
    full.data <- rbind(full.data, data.refined)
    
    full.data <- na.omit(full.data)
    
  }
  
  return(full.data)
  
}
