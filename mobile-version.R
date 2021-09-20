library(shiny)
library(shinyMobile)
  
shiny::shinyApp(
    ui = f7Page(
      title = "MEG Footy Tipping App",
      f7TabLayout(
        navbar = f7Navbar(
          title = "MEG Footy Tipping App",
          hairline = FALSE,
          shadow = TRUE),
        f7Tabs(
          id = "tabs",
          swipeable = TRUE,
          animated = FALSE,
          f7Tab(tabName = "Leaderboard",
                icon = f7Icon("person_3"),
                active = TRUE,
                f7Shadow(
                  intensity = 10,
                  hover = TRUE,
                  f7Card(
                    f7Slider(
                      inputId = "notippers",
                      label = "Number of tippers",
                      max = 31,
                      min = 0,
                      value = 31,
                      scale = FALSE,
                      scaleSubSteps = 1),
                    
                    f7Radio(
                      inputId = "organisation.input",
                      label = "Highlight an organiszation",
                      choices = c("AIMS (dogs)",  
                                  "Curtin (dogs)",
                                  "DBCA (dogs)",
                                  "Foreign",
                                  "UWA"),
                      selected = NULL),
                    
                    plotOutput("all.tips"),
                    plotOutput("distPlot")
                  )
                  )
                ),
          f7Tab(tabName = "Tab 2", "tab 2 text"),
          f7Tab(tabName = "Tab 3", "tab 3 text"),
          .items = f7TabLink(
            icon = f7Icon("bolt_fill"),
            label = "Toggle Sheet",
            `data-sheet` = "#sheet",
            class = "sheet-open"
          )
        )
      )
    ),
    server = function(input, output) {
      output$distPlot <- renderPlot({
        dist <- rnorm(input$obs1)
        hist(dist)
      })
      
      output$distPlot2 <- renderPlot({
        dist <- switch(
          input$obs2,
          norm = rnorm,
          unif = runif,
          lnorm = rlnorm,
          exp = rexp,
          rnorm
        )
        
        hist(dist(500))
      })
      
      output$all.tips <- renderPlot({
        
        tips.cropped<-tips.total%>%
          top_n(input$notippers)
        
        # print(length(unique(input$organisation.input)))
        # 
        # if (length(unique(input$organisation.input)) == 0) {
        #   cols <- "grey"
        # }
        # else{
        #   cols <- brewer.pal(length(unique(input$organisation.input)), "BrBG")
        # }
        
        ggplot(tips.cropped, aes(x=reorder(tipper,total.tips), y=total.tips, 
                   fill = ifelse(institute %in%c(input$organisation.input), "#8C510A","grey"))) +   
          geom_bar(stat="identity",position=position_dodge())+
          coord_flip()+
          xlab("Tippers")+
          ylab(expression("Total number of tips"))+
          # Theme1+
          theme(axis.text.y = element_text(face="italic"))+
          # theme_collapse+
          scale_y_continuous(expand = expand_scale(mult = c(0, .1)))+
          theme_minimal(base_size=12, base_family="Roboto")
        #theme(axis.text.x = element_text(angle = 90, hjust = 1))
      })
      
      output$data <- renderTable({
        mtcars[, c("mpg", input$variable), drop = FALSE]
      }, rownames = TRUE)
    }
  )

  