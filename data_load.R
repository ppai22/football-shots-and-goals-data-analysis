library(tidyverse)

source('D:/R/WORKING/football/constants.R')

LoadData <- function() {
  
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
