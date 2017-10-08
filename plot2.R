##The following scripts creates the second graph in the assignments. 
##I have used the package lubridate,dplyr and ggplot2 package to generate the graph

##Loading required packages

library(lubridate)
library(dplyr)
library(ggplot2)
## Read data from workspace, Please set the workspace accordingly

household<-read.table("household_power_consumption.txt",sep=";",header=TRUE,stringsAsFactors = FALSE)

## Subsetting the data for only 1st and 2nd Februaury.

household_subset<-subset(na.exclude(household),dmy(Date)>="2007-02-01" & dmy(Date) <="2007-02-02")

## Using Mutate function to create one additonal column in data frame. 
## The created column is concatenation of Date and Time Column

household_subset<-mutate(household_subset,Date_Time=paste(Date,Time,sep=" "))

## Open PDF device "plot1.pdf" in working directory

png("plot2.png")

##Using grammer of graphics to create plot in multiple steps.

g<-ggplot(data = household_subset,aes(x=household_subset$Date_Time,y=as.numeric(as.character(household_subset[[3]])),group=1))+geom_line()+theme_bw()+labs(y="Global Active Power (Kilowatts)",x="")
g<-g+scale_x_discrete(breaks=c("1/2/2007 00:00:00","2/2/2007 00:00:00","2/2/2007 23:59:00"),label=c("Thu","Fri","Sat"))

print(g)
## Closing the connection to PDF to move back to default graphic device.
dev.off()