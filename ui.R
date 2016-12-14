
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


library(shinydashboard)
library("vembedr")

source("Tarea1/T1_server.R")
source("Tarea1/T1_ui.R")
source("Tarea2/T2_server.R")
source("Tarea2/T2_ui.R")
source("Tarea3/T3_server.R")
source("Tarea3/T3_ui.R")

ui <- dashboardPage(skin = "green",
  
  dashboardHeader(titleWidth = 175, title = "TAREAS", 
      tags$li(class = "dropdown",
      tags$a(href="https://www.itam.mx/", target="_blank", 
      tags$img(height = "20px",src="https://www.itam.mx/sites/all/themes/coursat/itam.png")
                )
                )
                ),
  
  dashboardSidebar(
    
    width = 175,
    sidebarMenu(
      menuItem("Simulación de V.A.",icon = icon("bar-chart-o"), tabName = "T1"),
      menuItem("Integración Numérica",icon = icon("stats", lib = "glyphicon"), tabName = "T2"),
      menuItem("Regresión Bayesiana",icon = icon("line-chart"), tabName = "T3"),
      menuItem("Proyecto Final",icon = icon("facetime-video", lib = "glyphicon"), tabName = "T4")
      )
  ),
  
  dashboardBody(
    tags$head(tags$style(HTML('
      .main-header .logo {
        font-family: "Bradley Hand ITC", Times, "Times New Roman", serif;
        font-weight: bold;
        font-size: 30px;
                          }
            '))),
    tabItems(
      tabItem(tabName = 'T1',
              h2('Método de la Función Inversa'),
              tags$hr(color = "green"),
              T1_ui("T1_server")
      ),
      tabItem(tabName = 'T2',
              h2('Comparativo Montecarlo y Método del Trapecio'),
              T2_ui("T2_server")
      ),
      tabItem(tabName = 'T3',
              h2('Regresión Lineal Múltiple Bayesiana - MCMC'),
              h3('Ballesteros Mónica / Cerón Fabiola'),
              T3_ui("T3_server")
      ),
      tabItem(tabName = 'T4',
              h2('Cadenas de Markov en Minería de Texto'),
              tags$br(),
              embed_youtube(id = "z4tpO3j1S3o"),
              box(title="Integrantes", status = "warning", solidHeader = TRUE,
              h5('Paulina Lisett Salgado Figueroa'),
              h5('Gabriela Flores Bracamontes'),
              h5('Mónica Patricia Ballesteros Chávez'),
              h5('Ricardo Lastra Cuevas'),        
              h5('Guillermina Montanari'))
      )
    )
  )
)
