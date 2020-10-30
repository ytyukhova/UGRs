## UGRs 1.2 by Yulia Tyukhova
## October 30, 2020

library(shiny)
library(mathjaxr)

shinyUI(fluidPage(
    titlePanel("Discomfort Glare Predictions using UGRs in outdoor nighttime
               environments"),
            sidebarPanel(

            sliderInput("sliderLb","Background luminance, cd/m^2",
                        1,10,value=5,step=0.5),
            sliderInput("sliderI","Luminous Intensity of the source, cd",
                        100,50000,value=5000,step=100),
            sliderInput("sliderR","Distance from the observer to the center of
                        luminaire's luminous parts, m",
                        20,50,value=30),
            ## Delayed reactivity to slider inputs - add a "Calculate" button
            submitButton("Calculate")

        ),
       mainPanel(
            tabsetPanel(type="tabs",

            ## Tab 1 includes table and plot output.
            tabPanel("UGRs Prediction", br(),tableOutput("values"),
            plotOutput("plot")),

            ## Tab 2 includes the instructions with the equation and the image.
            tabPanel("Instructions",
            p("This is an app that allows one to calculate discomfort glare
(discomfort from bright light sources) in outdoor nighttime environments using a
glare index called UGR small source extension (CIE 146-147, 2002) using the
formula below.",
withMathJax(helpText('UGRs formula: $$8log\\left[\\frac{0.25}{L_b}\\sum\\frac{200I^2}{R^2p^2}\\right]$$')),

p(strong('INPUT VALUES:')),
p("- Lb is the background luminance, in cd/m^2"),
p("- I is the luminous intensity of the source, in cd"),
p("- R is the distance from the observer to the center of the light source, in m"),
p("- p is the Guth Position index for each light source. EQUALS to 1 - assuming
          looking directly at the light source"),

## File must be in a folder named www in the same directory as the ui.R script.
img(src = "UGRs.png", height = 300),
br(),
p("Reference: [CIE] Commission Internationale de l’Éclairage. 2002. CIE
collection on glare. Vienna (Austria): CIE. TC 3-01 Report 146, 147. 25 p."),
br(),
p("Created by Yulia Tyukhova 2020")))
            )
       )
))
