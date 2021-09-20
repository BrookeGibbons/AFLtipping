library(shiny)
library(shinydashboard)
library(readxl)
library(ggplot2)
library(dplyr)
library(GlobalArchive)
library(tidyr)
library(stringr)
library(viridis)

# read in data created in first script ----
tips.sum <- read.csv("data/tips.sum.csv")

factors <- tips.sum%>%
  distinct(team.tipster, tipper, institute, level)
  
tips.total <- read.csv("data/total.tips.csv")%>%
  arrange(-total.tips)%>%
  left_join(.,factors)%>%
  dplyr::select(-c(X))

tips.long <- read.csv("data/tips.margin.long.csv")


total.tips.correct <- sum(tips.total$total.tips)
average.per.round <- round((total.tips.correct/31)/23)

# ifelse(input$organisation.input)
library(RColorBrewer)
brewer.pal(7, "BrBG")
