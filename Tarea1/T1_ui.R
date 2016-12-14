T1_ui <- function(id) {
  ns <- NS(id)
  tagList(
    box(title="Parametros", status="success", height=365, solidHeader = TRUE,
      sliderInput(ns("slider"), "Elegir numero de simulaciones:", 100, 10000, 500,step=1000),
      sliderInput(ns("slider2"), "Elegir Lambda:", 0.0001, 5, 0.5, step = .009),
      sliderInput(ns("bins"), "Elegir cantidad de clases:", 2, 100, 20, step=5)
        ),
    box(title="Histograma de x", status="success", height=365, solidHeader = TRUE,collapsible = TRUE,
        plotOutput(ns("plot1"), height = 300)
        ),
    box(title="Simulaciones x ~ Exp(Lambda)", status="success", solidHeader = TRUE,collapsible = TRUE, 
        DT::dataTableOutput(ns("wideTable")), 
        downloadButton(ns("downloadData"),"Descargar")
        ),
    box(title="Prueba de Bondad de ajuste", status="warning", solidHeader = TRUE,collapsible = TRUE,
        h4("Kolmogorov Smirnov"), 
        h4("Ho: x~Exp(Lambda)"),
        textOutput(ns("text")),
        h4("El resultado de la prueba estadistica esta por encima del nivel de no rechazo de la hipotesis nula, por lo que podemos decir que nuestra muestra se distribuye exponencial con parametro"),
        textOutput(ns("text2"))
    )
    
    
  )
}