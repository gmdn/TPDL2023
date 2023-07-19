fluidPage(
  
  #Application title
  titlePanel("Digital Onomastic Repertoire "),
  
  fixedRow(
    column(4, 
           fluidRow(column(3, h4("Scan")),
                    column(3, selectInput("pages", NULL, choices = 1:pdf_pages)),
                    column(3, selectInput("side", NULL, choices = c("left", "right")))
                    ),
           
           imageOutput("scan")
    ),
    column(4, 
           fluidRow(column(3, h4("OCR")),
                    column(3, actionButton("do_save", label = "save"))
           ),
           fluidRow(
             column(9, div(textInput("title", label = NULL, placeholder = "title"), style = "font-size:75%")),
             column(3, div(textInput("page", label = NULL, placeholder = "page"), style = "font-size:75%")),
             column(12, textAreaInput("verses", label = NULL, rows = 20, width = "100%", placeholder = "verses")),
             column(12, textAreaInput("notes", label = NULL, rows = 10, width = "100%", placeholder = "notes"))
           )
    ),
    column(4,
           fluidRow(column(3, h4("Data")),
                    column(3, actionButton("do_load", label = "load"))
           ),
           fluidRow(
             column(9, div(shiny::textOutput(outputId = "title_load"), style = "font-size:75%")),
             column(3, div(shiny::textOutput(outputId = "page_load"), style = "font-size:75%"))
           ),
           fluidRow(
             column(12, div(shiny::verbatimTextOutput(outputId = "verses_load"), style = "font-size:75%"))
           ),
           fluidRow(
             column(12, div(shiny::verbatimTextOutput(outputId = "notes_load"), style = "font-size:75%"))
           )
    ) 
  )
  


)
