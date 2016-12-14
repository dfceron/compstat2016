require(MASS)

T1_server<- function(input, output, session) {

  FuncInv<-function(n,lambda){
    u <- runif(n)
    x <- -(1/lambda)*log(1-u)
    return(x)
  }  
 
  simulaciones <- reactive({
    x<-FuncInv(input$slider,input$slider2)
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    list(xestim=x, clases=bins)
  })
  
  prueba <- reactive({
    ajuste <- fitdistr(simulaciones()$xestim,"exponential")
    Ks<- ks.test(simulaciones()$xestim, "pexp", ajuste$estimate)
    list(p=Ks$p.value, lambda=ajuste$estimate[1])
  })

  output$plot1 <- renderPlot({
    x<-simulaciones()$xestim
    h<-hist(x,  breaks = simulaciones()$clases, main="")
    xfit<-seq(min(x),max(x),length=50)
    yfit<-dexp(xfit,input$slider2)
    yfit <- yfit*diff(h$mids[1:2])*length(x)
    lines(xfit, yfit, col="blue")
  })
  
  output$wideTable <- DT::renderDataTable({
    table <- as.data.frame(simulaciones()$xestim)
    colnames(table) <- c("Simulacion")
    DT:: datatable({table})
    
  })
  
  output$downloadData<-downloadHandler(
    filename = "Datos.csv",
    content=function(file) {
        write.csv(simulaciones()$xestim, file)
      }
  )

    output$text <- renderText({
      paste("Valor p = ", prueba()$p)
    })
    output$text2 <- renderText({
      paste("Lambda=",prueba()$lambda)
    })
  
  
}