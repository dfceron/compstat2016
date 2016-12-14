# Tarea2 UI function
T2_ui <- function(id) {
  ns <- NS(id)
  tagList(
    box(title="Parametros", status="success", height=365, width = 4, solidHeader = TRUE,    
        textInput(inputId=ns("Fx"), label="Escribe una Funcion", value="function(x) x^2"),
        sliderInput(ns("alfa"), "Nivel de Confianza:", 0.001, 0.15, 0.05),
        numericInput(inputId = ns("sup"), label = "Limite Superior de la Integral", value = "10"),
        numericInput(inputId = ns("inf"), label = "Limite Inferior de la Integral", value = "0")
    ),
    box(title="Integral Trapecio, MonteCarlo e Intervalos MC", status="success", height=365, width = 8, solidHeader = TRUE,    
        tableOutput(ns("table"))
    ),
    box(title="Simulacion", status="warning", width = 12, solidHeader = TRUE,    
        plotOutput(ns("grafica"))
    )
  )
}
