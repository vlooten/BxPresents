# BxPresents v0.01 ####
# Vincent Looten
# Date de création : 2020-03-19
# Date de dernière modification : 2020-03-20
# Text encoding : UTF-8

library("shiny")
library("shinydashboard")
library("DT")
library("stringr")

# lexique <- readRDS("lexique.RDS")

source('ui.R', encoding = 'UTF-8')
source('server.R', encoding = 'UTF-8')

# Run the application 
shinyApp(ui = ui, server = server)
