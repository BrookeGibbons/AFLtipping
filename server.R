
function(input, output) {
    
    # All tips ----
    output$all.tips <- renderPlot({
        
        tips.cropped<-tips.total%>%
            top_n(input$no.tippers)
        
        print(length(unique(input$organisation.input)))
        
        if (length(unique(input$organisation.input)) == 0) {
            cols <- "grey"
        }
        else{
            cols <- brewer.pal(length(unique(input$organisation.input)), "BrBG")
        }
        
        ggplot(tips.cropped, aes(x=reorder(tipper,total.tips), y=total.tips, fill = ifelse(institute %in%c(input$organisation.input), cols,"grey"))) +   
            geom_bar(stat="identity",position=position_dodge())+
            coord_flip()+
            xlab("Tippers")+
            ylab(expression("Total number of tips"))+
            # Theme1+
            theme(axis.text.y = element_text(face="italic"))+
            # theme_collapse+
            scale_y_continuous(expand = expand_scale(mult = c(0, .1)))
        #theme(axis.text.x = element_text(angle = 90, hjust = 1))
    })
    
    output$tips.worm <- renderPlot({
        
        players.cropped <- tips.total%>%
            top_n(input$no.tippers)%>%
            distinct(tipper)
        
        worm.cropped <- semi_join(tips.sum,players.cropped)
        
        ggplot(worm.cropped, aes(x=as.numeric(round), y=tips.sum,col=tipper,group))+
            geom_line()+
            geom_point()
        
        
    })
}