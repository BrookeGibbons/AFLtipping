library(shiny)
library(shinydashboard)
library(readxl)
library(ggplot2)
library(dplyr)
library(GlobalArchive)
library(tidyr)
library(stringr)
library(viridis)
library(shinyMobile)
library(forcats)

# read in data created in first script ----
final.ranks <- read.csv("data/final.ranks.csv")%>%select(-c(X))

tips.sum <- read.csv("data/tips.sum.csv")%>%
  dplyr::mutate(institute = str_replace_all(.$institute, c("dogs"="","[[:punct:]]"=""," "="")))

tips.sum<-left_join(final.ranks,tips.sum)

unique(tips.sum$institute)

factors <- left_join(final.ranks,tips.sum)%>%
  distinct(rank,team.tipster, tipper, institute, level)%>%
  mutate(tipper = forcats::fct_reorder(tipper, desc(rank)))

unique(factors$tipper)
  
tips.total <- read.csv("data/total.tips.csv")%>%
  arrange(-total.tips)%>%
  left_join(.,factors)%>%
  dplyr::select(-c(X,team.tipster))

tips.total<-left_join(final.ranks,tips.total)

unique(tips.total$tipper)

tips.table <- tips.total%>%
  dplyr::rename(Tipper = tipper, 'Total tips'=total.tips, Institute = institute, 'Academic level'=level)

tips.long <- read.csv("data/tips.margin.long.csv")%>%
  dplyr::mutate(institute = str_replace_all(.$institute, c("dogs"="","[[:punct:]]"="")))


total.tips.correct <- sum(tips.total$total.tips)
average.per.round <- round((total.tips.correct/31)/23)

# ifelse(input$organisation.input)
library(RColorBrewer)
brewer.pal(7, "BrBG")

theme_collapse <-theme(      ## the commented values are from theme_grey
  panel.grid.major=element_line(colour = "white"), ## element_line(colour = "white")
  panel.grid.minor=element_line(colour = "white", size = 0.25))

# Theme for plotting ----
Theme1 <-    theme_bw()+
  theme( # use theme_get() to see available options
    panel.grid = element_blank(), 
    panel.border = element_blank(), 
    axis.line = element_line(colour = "black"),
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), 
    legend.background = element_blank(),
    legend.key = element_blank(), # switch off the rectangle around symbols in the legend
    #legend.text = element_text(size=12),
    legend.title = element_blank(),
    #legend.position = "top",
    #text=element_text(size=12),
    #strip.text.y = element_text(size = 12,angle = 0),
    #axis.title.x=element_text(vjust=0.3, size=12),
    #axis.title.y=element_text(vjust=0.6, angle=90, size=12),
    #axis.text.y=element_text(size=12),
    #axis.text.x=element_text(size=12),
    axis.line.x=element_line(colour="black", size=0.5,linetype='solid'),
    axis.line.y=element_line(colour="black", size=0.5,linetype='solid'),
    strip.background = element_blank(),
    #plot.title = element_text(color="black", size=12, face="bold.italic")
    )

