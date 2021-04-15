source('constants.R')


sidebar_content <- sidebarPanel(
  selectInput(
    "Season",
    label = "Select Premier League season",
    choices = kSeasons,
    selected = '2018-19'
  )
)

main_content <- mainPanel(
  plotOutput("plot")
)

visualization_panel <- tabPanel(
  "Plots",
  titlePanel("Percentage Goals, Saved Shots on Target and Shots Off Target"),
  p("Select season"),
  sidebarLayout(
    sidebar_content, main_content
  )
)

ui <- navbarPage(
  "Premier League Football Data Viz",
  visualization_panel
)
