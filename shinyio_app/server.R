#
# This is the server logic of a Shiny web application that displays
# a bar graph of the number of fatalities and/or injuries due to weather events
# for each of nine climate regions of the contiguous United States during a 
# specified span of years.
#

library(plyr)
library(dplyr)
library(data.table)
library(stringr)
library(ggplot2)
library(shiny)
set.seed(5678)

# Read the data (created by processing and cleaning the NOAA dataset)
regionsums<-read.table("StormDatabyRegionNotEvents")
regionorder<-c("South","Ohio Valley","Southeast","Northeast","Upper Midwest","Northern Rockies and Plains","Southwest","West","Northwest")

# Set defaults to be all years and to include both fatalities and injuries.
beginY<-1950
endY<-2011
show_fatalities<-TRUE
show_injuries<-TRUE

# Define server logic required to draw the bar graph
shinyServer(function(input, output) {
      
      output$plot1 <- renderPlot({
            set.seed(5678)
            beginY <- input$sliderY[1]
            endY <- input$sliderY[2]
            show_fatalities <- input$show_fatalities
            show_injuries <- input$show_injuries

            # Plot total fatalities and injuries for each event type.
            if(show_fatalities & show_injuries){
                  region.m<-data.table()
                  region.m = melt(regionsums[regionsums$YEAR<endY+1 & regionsums$YEAR>beginY-1,c(2,3,4)],id.vars='REGION')
                  colnames(region.m)<-c("Region","Type","Number")
                  
                  ggplot(region.m,aes(Region,Number,fill=Type)) +
                        scale_x_discrete(limits = regionorder) +
                        theme(axis.text.x = element_text(hjust=1, angle=70),
                              plot.title = element_text(hjust = 0.5)) +
                        ggtitle("Fatalities and Injuries Caused by Severe Weather Events") +
                        ylab('Fatalities/Injuries') + 
                        xlab('Region of the Contiguous United States
                             \n South: AR, KS, LA, MS, OK, TX        Ohio Valley: IL, IN, KY, MO, OH, TN, WV \n Southeast: AL, FL, GA, NC, SC, VA, DC    Northeast: CT, DE, ME, MD, MA, NH, NJ, NY, PA, RI, VT\n Upper Midwest: IA, MI, MN, WI        Northern Rockies and Plains: MT, NE, ND, SD, WY\n Southwest: AZ, CO, NM, UT       West: CA, NV      Northwest: ID, OR, WA') +
                        geom_bar(stat="identity") +
                        scale_fill_manual(values=c("#FF6666","#33CCCC"))
            }
            else if(show_fatalities){
                  region.m<-data.table()
                  region.m = melt(regionsums[regionsums$YEAR<endY+1 & regionsums$YEAR>beginY-1,c(2,3)],id.vars='REGION')
                  colnames(region.m)<-c("Region","Type","Number")
                  
                  ggplot(region.m,aes(Region,Number,fill=Type)) +
                        scale_x_discrete(limits = regionorder) +
                        theme(axis.text.x = element_text(hjust=1, angle=70),
                              plot.title = element_text(hjust = 0.5)) +
                        ggtitle("Fatalities and Injuries Caused by Severe Weather Events") +
                        ylab('Fatalities/Injuries') + 
                        xlab('Region of the Contiguous United States
                             \n South: AR, KS, LA, MS, OK, TX        Ohio Valley: IL, IN, KY, MO, OH, TN, WV \n Southeast: AL, FL, GA, NC, SC, VA, DC    Northeast: CT, DE, ME, MD, MA, NH, NJ, NY, PA, RI, VT\n Upper Midwest: IA, MI, MN, WI        Northern Rockies and Plains: MT, NE, ND, SD, WY\n Southwest: AZ, CO, NM, UT       West: CA, NV      Northwest: ID, OR, WA') +
                        geom_bar(stat="identity") +
                        scale_fill_manual(values=c("#FF6666"))
            }
            else if(show_injuries){
                  region.m<-data.table()
                  region.m = melt(regionsums[regionsums$YEAR<endY+1 & regionsums$YEAR>beginY-1,c(2,4)],id.vars='REGION')
                  colnames(region.m)<-c("Region","Type","Number")
                  
                  ggplot(region.m,aes(Region,Number,fill=Type)) +
                        scale_x_discrete(limits = regionorder) +
                        theme(axis.text.x = element_text(hjust=1, angle=70),
                              plot.title = element_text(hjust = 0.5)) +
                        ggtitle("Fatalities and Injuries Caused by Severe Weather Events") +
                        ylab('Fatalities/Injuries') + 
                        xlab('Region of the Contiguous United States
                             \n South: AR, KS, LA, MS, OK, TX        Ohio Valley: IL, IN, KY, MO, OH, TN, WV \n Southeast: AL, FL, GA, NC, SC, VA, DC    Northeast: CT, DE, ME, MD, MA, NH, NJ, NY, PA, RI, VT\n Upper Midwest: IA, MI, MN, WI        Northern Rockies and Plains: MT, NE, ND, SD, WY\n Southwest: AZ, CO, NM, UT       West: CA, NV      Northwest: ID, OR, WA') +
                        geom_bar(stat="identity")+
                        scale_fill_manual(values=c("#33CCCC"))
            }
            else {
                  region.m <- data.frame(Region=unique(regionsums$REGION)[1:9],Type=c(rep("FATALITIES",4),rep("INJURIES",5)),Number=rep(0,9))
                  colnames(region.m)<-c("Region","Type","Number")
                  
                  ggplot(region.m,aes(Region,Number,fill=Type)) +
                        scale_x_discrete(limits = regionorder) +
                        theme(axis.text.x = element_text(hjust=1, angle=70),
                              plot.title = element_text(hjust = 0.5)) +
                        ggtitle("Fatalities and Injuries Caused by Severe Weather Events") +
                        ylab('Fatalities/Injuries') + 
                        xlab('Region of the Contiguous U.S.
                             \n South: AR, KS, LA, MS, OK, TX        Ohio Valley: IL, IN, KY, MO, OH, TN, WV \n Southeast: AL, FL, GA, NC, SC, VA    Northeast: CT, DE, ME, MD, MA, NH, NJ, NY, PA, RI, VT\n Upper Midwest: IA, MI, MN, WI        Northern Rockies and Plains: MT, NE, ND, SD, WY\n Southwest: AZ, CO, NM, UT         West: CA, NV       Northwest: ID,OR,WA') +
                        geom_bar(stat="identity") +
                        scale_fill_manual(values=c("#FF6666","#33CCCC"))
            }

      })
})