library(shiny)
library(ggplot2)
library(reactable)

ui <- fluidPage(
  
  titlePanel("Applicazione Esempio"),
  
  fluidRow(
    
    shiny::hr(),
    
    column(
      width = 2,
      
      
      
      radioButtons(
        inputId = "output_radio",
        label = "Tipologia Output:",
        choices = c(
          "Tabella" = "tab",
          "Grafico" = "plot"
        ),
        inline = FALSE
      )
      
    ),
    
    column(
      width = 10,
      
      uiOutput("elemento_ui_esempio")
      
    )
    
  )
  
) # / UI

server <- function(input,output) {
  
  output$elemento_ui_esempio <- renderUI({
    req(input$output_radio)
    if(input$output_radio == "tab"){
      reactableOutput("react1")
    } else if(input$output_radio == "plot"){
      plotOutput("plot1", height = "500px")
    } else return(invisible())
  })
  
  output$plot1 <- renderPlot({
    ggplot(data = iris, aes(x = Petal.Length, y = Petal.Width)) +
      geom_point(aes(color = Species), size = 2.5) +
      theme_light()
  })
  
  output$react1 <- renderReactable({
    reactable(
      data = iris,
      bordered = TRUE,
      compact = TRUE,
      striped = TRUE,
      showPageSizeOptions = TRUE,
      columns = list(
        Species = colDef(filterable = TRUE)
      )
    )
  })
  
}

shinyApp(ui, server)
