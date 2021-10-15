library(shiny)
library(shinydashboard)
library(readxl)
library(ggplot2)
library(dplyr)
library(GlobalArchive)
library(tidyr)
library(stringr)

# need to rerun with round 23 ----
# read in data in a loop-
all.rounds <- read_excel("data/2021_scores.xlsx")
temp.data <- read_excel("data/2021_scores.xlsx",sheet = 1)%>% # format round 1 to bind others together
  ga.clean.names()%>%
  rename(rd.1.rank = rank)%>%
  dplyr::select(-c(avg.rnd, total.tips, total.margin))

teams <- read.csv("data/team.names.csv")%>%
  dplyr::rename(tipper=name)

final.ranks <- read_excel("data/2021_scores.xlsx",sheet = 23)%>%
  ga.clean.names()%>%
  left_join(teams)%>%
  dplyr::select(rank, tipper)

data <- data.frame() # create blank data frame
for (i in 1:23) {

  rank.name <- paste("rd",i,"rank",sep=".")
  temp.round <- read_excel("data/2021_scores.xlsx",sheet = i)%>%
    ga.clean.names()%>%
    glimpse()

  temp.ranks <- temp.round$rank

  ranks <- data.frame(i,temp.ranks)

  tidy.round <- temp.round%>%
    dplyr::select(-c(rank, avg.rnd, total.tips, total.margin))

  temp.data <- left_join(temp.data, tidy.round)

}

all.rounds <- temp.data
names(all.rounds)


# create a data frame with just tips ----
tips <- all.rounds%>%
  select(team.tipster,
         rd.1.tips,
         rd.2.tips,
         rd.3.tips,
         rd.4.tips,
         rd.5.tips,
         rd.6.tips,
         rd.7.tips,
         rd.8.tips,
         rd.9.tips,
         rd.10.tips,
         rd.11.tips,
         rd.12.tips,
         rd.13.tips,
         rd.14.tips,
         rd.15.tips,
         rd.16.tips,
         rd.17.tips,
         rd.18.tips,
         rd.19.tips,
         rd.20.tips,
         rd.21.tips,
         rd.22.tips,
         rd.23.tips
         )%>%
  left_join(teams)



margin <- all.rounds%>%
  select(team.tipster,
         rd.1.margin,
         rd.2.margin,
         rd.3.margin,
         rd.4.margin,
         rd.5.margin,
         rd.6.margin,
         rd.7.margin,
         rd.8.margin,
         rd.9.margin,
         rd.10.margin,
         rd.11.margin,
         rd.12.margin,
         rd.13.margin,
         rd.14.margin,
         rd.15.margin,
         rd.16.margin,
         rd.17.margin,
         rd.18.margin,
         rd.19.margin,
         rd.20.margin,
         rd.21.margin,
         rd.22.margin,
         rd.23.margin
         )%>%
  left_join(teams)

margin.long <- pivot_longer(margin, 2:23,names_to = "round",values_to = "margin") %>%
  mutate(round=str_replace_all(.$round,c(".margin"="","rd."="")))


tips.long <- pivot_longer(tips, 2:23,names_to = "round",values_to = "tips") %>%
  mutate(round=str_replace_all(.$round,c(".tips"="","rd."="")))

#### Create one data set ####

all.data <- left_join(tips.long,margin.long)

setwd("Y:/AFLtipping/data")
write.csv(all.data, "tips.margin.long.csv",row.names = FALSE)

top.marks <- all.data%>%
  group_by(round)%>%
  summarise(max.tips=max(tips),
            min.tips=min(tips), 
            min.margin=min(margin),
            max.margin=max(margin))

names(all.data)
names(top.marks)

all.top <- all.data%>%
  left_join(.,top.marks)%>%
  mutate(top.tipper = if_else(tips==max.tips,1,0))%>%
  mutate(worst.tipper = if_else(tips==min.tips,1,0))%>%
  mutate(top.margin = if_else(margin==min.margin,1,0))%>%
  mutate(worst.margin = if_else(margin==max.margin,1,0))

top.sum <- all.top%>%
  group_by(tipper)%>%
  summarise(top.tipper.no = sum(top.tipper),
            worst.tipper.no = sum(worst.tipper),
            top.margin.no = sum(top.margin),
            worst.margin.no = sum(top.margin))
write.csv(top.sum, "top.tippers.and.margins.csv",row.names = FALSE)


# Create a total number of tips ----
tips.total <- tips%>%
  select(tipper,team.tipster,institute, level, everything())%>%
  mutate(total.tips=rowSums(.[,5:(ncol(.))],na.rm = TRUE ))%>% #Add in Totals
  select(tipper,total.tips)

names(tips.total)

write.csv(tips.total,"total.tips.csv")

# bar plot of total tips
ggplot(tips.total, aes(x=reorder(tipper,total.tips), y=total.tips)) +   
    geom_bar(stat="identity",position=position_dodge())+
    coord_flip()+
    xlab("Tippers")+
    ylab(expression("Total number of tips"))+
    # Theme1+
    theme(axis.text.y = element_text(face="italic"))+
    # theme_collapse+
    scale_y_continuous(expand = expand_scale(mult = c(0, .1)))


unique(tips.long$tipper)


temp.data <- data.frame() # create blank data frame
tips.cum.sum <- data.frame()

for (i in unique(tips.long$tipper)) {
  
  temp <- tips.long%>%
    filter(tipper == i)
  
  
  tips.cum.sum <- temp %>%
    mutate(tips.sum = cumsum(tips))
  
  temp.data <- bind_rows(temp.data, tips.cum.sum)
  
}

# rename data

tips.sum <- temp.data

write.csv(tips.sum, "tips.sum.csv",row.names = FALSE)

plot(tips.sum$round, tips.sum$tips.sum,type="s",col=tips.sum$tipper)


write.csv(final.ranks,"final.ranks.csv")

ggplot(tips.sum, aes(x=as.numeric(round), y=tips.sum,col=tipper,group))+
  geom_line()+
  geom_point()


