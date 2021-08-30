dashboardPage(
    dashboardHeader(title = "MEG fish tipping"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Leaderboard", tabName = "dashboard", icon = icon("dashboard")),
            menuItem("Widgets", tabName = "widgets", icon = icon("th"))
        )),
    dashboardBody(
        
        tabItems(
            # First tab content
            tabItem(tabName = "dashboard",
                    fluidRow(
                            valueBox("31", "Tippers", icon = icon("question"), color ="green", width = 4),
                            valueBox(total.tips.correct, "Tips correct", icon = icon("question"), color ="aqua", width = 4),
                            valueBox(average.per.round, "Average correct per round", icon = icon("question"), color ="yellow", width = 4),
                            
                        
                        box(width=10,height = 500, 
                            plotOutput("all.tips", height = 500)),
                        
                        
                        box(width = 2,
                            title = "Controls",
                            numericInput("no.tippers", "Number of tippers:", min=1, max =31, value = 31),
                            checkboxGroupInput("organisation.input", "Filter organisations", choices = c("AIMS (dogs)",  
                                                                                                         "Curtin (dogs)",
                                                                                                         "DBCA (dogs)",
                                                                                                         "Foreign",
                                                                                                         "UWA")),
                        checkboxGroupInput("level.input", "Filter levels", choices = c("Big wigs",  
                                                                                                     "Medium wigs",
                                                                                                     "Small wigs",
                                                                                                     "Students (plebs)"))),
                        box(width=10,height = 500,
                            plotOutput("tips.worm", height = 500))
                    )
            ),
            
            # Second tab content
            tabItem(tabName = "widgets",
                    h2("Widgets tab content")
            )
        )
            )
        )