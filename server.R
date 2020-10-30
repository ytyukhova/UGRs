## UGRs 1.2 by Yulia Tyukhova
## October 30, 2020

library(shiny)

shinyServer(function(input, output) {

    sliderValues <- reactive({

        ## Rename the input sliders
        LbInput<-input$sliderLb
        IInput<-input$sliderI
        RInput<-input$sliderR

        ## Display the input values and the calculated result in the table
    data.frame(
        Name=c("Background luminance, cd/m^2",
               "Luminous intensity, cd",
               "Distance to the source, m",
               "Guth position index",
               "UGR small source extension"),
        Value=as.character(c(LbInput,
                             IInput,
                             RInput,
                             1,
                             as.numeric(round(8*log10(0.25/LbInput*(200*IInput^2/(RInput^2*1^2)))))),
                             stringsAsFactors=FALSE))
    })

    UGRspred<-reactive({

        ## Rename the input sliders
        LbInput<-input$sliderLb
        IInput<-input$sliderI
        RInput<-input$sliderR

        8*log10(0.25/LbInput*(200*IInput^2/(RInput^2*1^2)))

    })

    ## Table with slider values and the calculated result
    output$values <- renderTable({
        sliderValues()
    })

    ## Plot
    output$plot<-renderPlot({
        IInput<-input$sliderI
        plot(IInput,UGRspred(),xlab="Luminous intensity, cd",
             ylab="UGRs",main="Glare experienced by the observer", bty="n",pch=4,cex=1,
             xlim=c(100,50000),ylim=c(0,80))
        ## Label for UGRs
        text(IInput,UGRspred(),labels=round(UGRspred()),cex=1.5,pos=3)
        ## Lines with glare limits and labels
        abline(h=18,col="cyan",lwd=2)
        text(40000,21, "Noticable = 18", col = "cyan", adj = c(0, -.1))
        abline(h=35,col="blue",lwd=2)
        text(40000,38, "Disagreeble = 35", col = "blue", adj = c(0, -.1))
        abline(h=49,col="red",lwd=2)
        text(40000,52, "Intolerable = 49", col = "red", adj = c(0, -.1))
        })

})



