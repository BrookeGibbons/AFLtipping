library(shiny)
library(shinydashboard)
library(readxl)
library(ggplot2)
library(dplyr)

setwd("C:/GitHub/AFLtipping/data")

all.rounds<-read_excel("2021_scores.xlsx")
