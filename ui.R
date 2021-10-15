f7Page(
    title = "MEG Footy Tipping App",
    tags$head(tags$link(rel = "shortcut icon", href = "favicon.ico")),
    f7TabLayout(
        navbar = f7Navbar(
            title = "MEG Footy Tipping App",
            hairline = FALSE,
            shadow = TRUE),
        f7Tabs(
            id = "tabs",
            swipeable = FALSE,
            animated = TRUE,
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
                              choices = c("AIMS",  
                                          "Curtin",
                                          "DBCA",
                                          "Foreign",
                                          "UWA"),
                              selected = NULL),
                          
                          br(),
                          br(),
                          
                          plotOutput("all.tips"),
                          
                          br(),
                          
                          selectInput(inputId = "worm.player",
                              label = "Plot a player(s) progress:",
                              choices = c("Lucy A",
                                          "Brae P",
                                          "Todd B",
                                          "Brooke G",
                                          "Charlotte A",
                                          "Matt F",
                                          "Matt B",
                                          "Rachel A",
                                          "Emily L",
                                          "Michael B",
                                          "Miles P",
                                          "Mason S",
                                          "Mike T",
                                          "Jon-Paul E",
                                          "Damon D",
                                          "Jordan G",
                                          "Shannon D",
                                          "Ellen D",
                                          "Tom H",
                                          "Lauren P",
                                          "Anita G",
                                          "Jess K",
                                          "Sahira B",
                                          "Blair B",
                                          "Dianne M",
                                          "Jane P",
                                          "Nicole R",
                                          "Renae H",
                                          "Matt N",
                                          "Chris D",
                                          "Kye A"),
                              selected = "Lucy A",
                              multiple = TRUE
                          ),
                          
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
                          f7Table(tips.table, card = FALSE)
                      )
                  )
            )

        )
    )
)