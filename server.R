source('data_presentation.R')


server <- function(input, output) {
  output$plot <- renderPlot({
    season <- input$Season
    PlotPercentageShotsAndGoals(season = season)
  })
}
