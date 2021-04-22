library(shiny)

ui <- fluidPage(
  titlePanel("Speed Calculator"),
  sidebarLayout(
    sidebarPanel(
      numericInput("distance", label = strong("Distance (KM)"), 1600, min = 1, max = 3000000,), 
      br(),
      numericInput("time", label = strong("Time (Hour)"), 20, min = 0.01, max = 3000,),
      br(),
      actionButton("submit", label = "Submit")),
    
    mainPanel(
                 h3("Your Speed is:"),
                 h2(textOutput("speed_result")), 
                 h3("You are:"),
                 h2(textOutput("indicator_show")),
      ))
)

server <- function(input, output) {
  values <- reactiveValues()
  observe({
    input$submit
    values$speed <- isolate({
      input$distance/input$time
    })
  })
  
  output$indicator_show <- renderText({
    if(input$submit == 0) "" else {
      if (values$speed < 81){
        values$indicator_show = "Driving at a safe speed"
      }
      else if (values$speed < 121){
        values$indicator_show ="Driving at a moderate speed. Be safe!"
      }
      else{
        values$indicator_show ="Driving fast. Please SLOW DOWN!"
      }
      paste("", values$indicator_show)
    }
  })
  output$speed_result <- renderText({
    if(input$submit == 0) "" else
      paste("", values$speed, "km/hr")
  })
}

shinyApp(ui = ui, server = server)