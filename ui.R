f7Page(
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
                              label = "Highlight an organisation",
                              choices = c("AIMS (dogs)",  
                                          "Curtin (dogs)",
                                          "DBCA (dogs)",
                                          "Foreign",
                                          "UWA"),
                              selected = NULL),
                          
                          br(),
                          
                          plotOutput("all.tips"),
                          
                          br(),
                          
                          plotOutput("tips.worm")
                      )
                  )
            ),
            f7Tab(tabName = "Table",
                  icon = f7Icon("table"),
                  active = TRUE,
                  f7Shadow(
                      intensity = 10,
                      hover = TRUE,
                      f7Card(
                          f7Table(tips.total, card = FALSE)
                      )
                  )
            ),
            f7Tab(tabName = "Tab 3", "tab 3 text"),
            .items = f7TabLink(
                icon = f7Icon("bolt_fill"),
                label = "Toggle Sheet",
                `data-sheet` = "#sheet",
                class = "sheet-open"
            )
        )
    )
)