# BxPresents v0.01 ####
# Vincent Looten
# Date de création : 2020-03-19
# Date de dernière modification : 2020-03-20
# Text encoding : UTF-8

# Define UI for application that draws a histogram
ui <- dashboardPage(
  
  dashboardHeader(title = "Beaux-Présents"),
  
  dashboardSidebar(id="", 
                   sidebarMenu(
                     menuItem("Parametres", tabName = "parametres", icon = icon("dashboard")),
                     menuItem("Dictionnaire", tabName = "dico", icon = icon("dashboard"))
                   )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "parametres",
              h1("Constitution d'un dictionnaire restreint pour beaux-présents - Vincent Looten"),
              textInput("motgen", "Mot générateur (accent non pris en compte et non sensible à la case", ""),
              radioButtons("optionbxp","Mode :",choices = c("Beau présent","Belle absente"), selected = "Beau présent"),
              actionButton("btn", "Générer le dictionnaire")
              
      ),
      tabItem(tabName = "dico",
              h1("Résultats de la requête - Vincent Looten"),
              htmlOutput("nbr_mot"),
              fluidRow(
                box(title = "Noms", width = 6,
                    htmlOutput("nbr_nom"),
                    div(DT::dataTableOutput("nom"),style = "font-size: 75%; width: 50%" ) ),
                box(title = "Adjectifs", width = 6,
                    htmlOutput("nbr_adj"),
                    div(DT::dataTableOutput("adj"),style = "font-size: 75%; width: 50%" ) ),
                box(title = "Adverbes", width = 6,
                    htmlOutput("nbr_adv"),
                    div(DT::dataTableOutput("adv"),style = "font-size: 75%; width: 50%" ) ),
                box(title = "Préposition", width = 6,
                    htmlOutput("nbr_prep"),
                    div(DT::dataTableOutput("prep"),style = "font-size: 75%; width: 50%" ) ),
                box(title = "Conjonctions", width = 6,
                    htmlOutput("nbr_cjco"),
                    div(DT::dataTableOutput("cjco"),style = "font-size: 75%; width: 50%" ) ),
                box(title = "Verbes 0", width = 6,
                    htmlOutput("nbr_v0"),
                    div(DT::dataTableOutput("v0"),style = "font-size: 75%; width: 50%" ) ),
                box(title = "Verbes 1", width = 6,
                    htmlOutput("nbr_v1"),
                    div(DT::dataTableOutput("v1"),style = "font-size: 75%; width: 50%" ) ),
                box(title = "Verbes 2", width = 6,
                    htmlOutput("nbr_v2"),
                    div(DT::dataTableOutput("v2"),style = "font-size: 75%; width: 50%" ) ),
                box(title = "Verbes 3", width = 6,
                    htmlOutput("nbr_v3"),
                    div(DT::dataTableOutput("v3"),style = "font-size: 75%; width: 50%" ) ),
                box(title = "Noms propres", width = 6,
                    htmlOutput("nbr_prn"),
                    div(DT::dataTableOutput("prn"),style = "font-size: 75%; width: 50%" ) ),
                box(title = "Mg", width = 6,
                    htmlOutput("nbr_mg"),
                    div(DT::dataTableOutput("mg"),style = "font-size: 75%; width: 50%" ) )
              )
      )
    )
  )
)

