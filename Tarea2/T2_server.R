require(plyr)
library(dplyr)
require(ggplot2)

T2_server <- function(input, output, session) {
  
  funcion <- reactive({
    Ftexto <- paste("aux <- ", input$Fx)
    eval(parse(text = Ftexto))
    aux
  })
  
  MC <- function(F, N, aleatorios = runif, alfa) {
    Simulaciones <- lapply(N, function(nsim) {
      X <- sapply(FUN = aleatorios, nsim)
      diff <- input$sup - input$inf
      FX <- sapply(X, F)

      #Montecarlo
      Int_MC <- mean(FX)
      #TRapecio
      long<-length(FX)
      Int_Trap<-diff/2*mean(FX[-long]+FX[-1])
      
      # Significancia
      conf <- qnorm(alfa / 2, lower.tail = FALSE)
      # Limites Intervalo de Confianza
      inferior <- Int_MC - sqrt(var(FX) / nsim) * conf
      superior <- Int_MC + sqrt(var(FX) / nsim) * conf
      return(data.frame(Simulaciones = as.integer(nsim),Trapecio= Int_Trap, MonteCarlo = diff * Int_MC, Lim_Inf = diff * inferior, Lim_Sup = diff * superior))
    })
    resultados <- ldply(Simulaciones)
    output$table <- renderTable({
      resultados
    })
    return(resultados)
  }
  
  output$grafica <- renderPlot({
    aleatorios <- function(nsim) runif(nsim, input$inf,input$sup)
    N <- c(10,100,1000,10000,100000)
    
    datos <- MC(F=funcion(), N=N, aleatorios=aleatorios, alfa=input$alfa)

    ggplot(datos, aes(x=log(Simulaciones,10)))+xlab("log_10(Simulaciones)")+ylab("Valor Integral")+ geom_ribbon(aes(ymin=Lim_Inf, ymax=Lim_Sup), 
    fill="lightblue") + geom_line(aes(y=MonteCarlo), colour="red4") + geom_line(aes(y=Trapecio), colour="black")+theme_bw()+ggtitle("MonteCarlo (Rojo) vs. Trapecio (Negro)")
  })
  
}