function(input, output, session) {
  
  pages_png <- reactive({

    left_page <- image_read(path = paste0("./", volume, "/png/left/", input$pages, "left.txt"))
    right_page <- image_read(path = paste0("./", volume, "/png/right/", input$pages, "right.txt"))

    list(left = left_page, right = right_page)

  })

  output$scan <- renderImage({

    id <- showNotification("Reading page...", duration = NULL, closeButton = FALSE)
    on.exit(removeNotification(id), add = TRUE)

    list(
      src = paste0("./", volume, "/png/", input$side, "/", input$pages, input$side, ".png"),
      contentType = "image/png",
      width = "100%"
    )
  }, deleteFile = FALSE)




  observe({


    tibble_half <- tibble(lines = readLines(con = paste0("./", volume, "/png/", input$side, "/", input$pages, input$side, ".txt")))

    updateTextAreaInput(inputId = "verses",
                        value = str_flatten(tibble_half$lines,
                                            collapse = "\n"))

    #showNotification(ui = "...done", duration = 2)

  })


  observeEvent(input$do_save, {

    showNotification(ui = "save data...", duration = 10, type = "warning")

    page_data <- list(title = input$title,
                        page = input$page,
                        verses = input$verses,
                        notes = input$notes)

    saveRDS(page_data, file = paste0("./", volume, "/data/", input$pages, input$side, ".rds"))

  })

  load_table <- eventReactive(input$do_load, {

    path <- paste0("./", volume, "/data/", input$pages, input$side, ".rds")

    if (file.exists(path)) {
      readRDS(path)
    } else {
      list(title = "not found",
           page = "not found",
           verses = "file not found",
           notes = "file note found"
           )
    }


  })

  output$title_load <- renderText({

    paste("title:", load_table()$title)

  })

  output$page_load <- renderText({

    paste("page:", load_table()$page)

  })

  output$verses_load <- renderText({

    load_table()$verses

  })

  output$notes_load <- renderText({

    load_table()$notes

  })

}
