function(input, output) {
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
            arrange(-total.tips)%>%
            slice_max(total.tips, n = input$notippers)
        
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
            theme_minimal(base_size=14, base_family="Roboto")+ theme(legend.position = "none")+
            # scale_fill_hue(l = 40)+
            scale_fill_brewer(palette="Paired")
        #theme(axis.text.x = element_text(angle = 90, hjust = 1))
    })
    
    output$tips.worm <- renderPlot({
        
        players.cropped <- tips.total%>%
            slice_max(total.tips, n = input$notippers)%>%
            distinct(tipper)
        
        worm.cropped <- semi_join(tips.sum,players.cropped)
        
        ggplot(worm.cropped, aes(x=as.numeric(round), y=tips.sum,col=tipper,group))+
            geom_line()+
            geom_point()+
            theme_minimal(base_size=14, base_family="Roboto")
        
        
    })
    
    output$data <- renderTable({
        mtcars[, c("mpg", input$variable), drop = FALSE]
    }, rownames = TRUE)
}

