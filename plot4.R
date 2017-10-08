##The following scripts creates the fourth graph in the assignments. 
##I have used the package lubridate,dplyr,ggplot2,gridExtra package to generate the graph

##Loading required packages

library(lubridate)
library(dplyr)
library(ggplot2)
library(gridExtra)
## Read data from workspace, Please set the workspace accordingly

household<-read.table("household_power_consumption.txt",sep=";",header=TRUE,stringsAsFactors = FALSE)

## Subsetting the data for only 1st and 2nd Februaury.

household_subset<-subset(na.exclude(household),dmy(Date)>="2007-02-01" & dmy(Date) <="2007-02-02")

## Using Mutate function to create one additonal column in data frame. 
## The created column is concatenation of Date and Time Column

household_subset<-mutate(household_subset,Date_Time=paste(Date,Time,sep=" "))

## Open PDF device "plot1.pdf" in working directory

png("plot4.png")

##PLotting 4 plot objects P1,P2,P3,P4 respectively
g<-ggplot(data = household_subset,aes(x=household_subset$Date_Time,y=as.numeric(as.character(household_subset[[3]])),group=1))+geom_line()+theme_bw()+labs(y="Global Active Power (Kilowatts)",x="")
p1<-g+scale_x_discrete(breaks=c("1/2/2007 00:00:00","2/2/2007 00:00:00","2/2/2007 23:59:00"),label=c("Thu","Fri","Sat"))

g<-ggplot(data=household_subset,aes(household_subset$Date_Time,group=1))+geom_line(aes(y=as.numeric(Sub_metering_1),colour="Sub_metering_1"))+geom_line(aes(y=as.numeric(Sub_metering_2),colour="Sub_metering_2"))+geom_line(aes(y=as.numeric(Sub_metering_3),colour="Sub_metering_3"))+theme_bw()+labs(y="Energy sub metering",x="")

p2<-g+scale_x_discrete(breaks=c("1/2/2007 00:00:00","2/2/2007 00:00:00","2/2/2007 23:59:00"),label=c("Thu","Fri","Sat"))+theme(legend.position = c(.90,.90),legend.title =element_blank())+scale_color_manual(values=c("black", "red","blue"))

g<-ggplot(data = household_subset,aes(x=household_subset$Date_Time,y=as.numeric(as.character(household_subset[[5]])),group=1))+geom_line()+theme_bw()+labs(y="Voltage",x="datetime")

p3<-g+scale_x_discrete(breaks=c("1/2/2007 00:00:00","2/2/2007 00:00:00","2/2/2007 23:59:00"),label=c("Thu","Fri","Sat"))

g<-ggplot(data = household_subset,aes(x=household_subset$Date_Time,y=as.numeric(as.character(household_subset[[4]])),group=1))+geom_line()+theme_bw()+labs(y="Global_reactive_power",x="datetime")

p4<-g+scale_x_discrete(breaks=c("1/2/2007 00:00:00","2/2/2007 00:00:00","2/2/2007 23:59:00"),label=c("Thu","Fri","Sat"))

##Using grid.arrnage to arrange plot objects
grid.arrange(p1,p2,p3,p4,nrow=2,ncol=2,as.table=FALSE)

## Closing the connection to PDF to move back to default graphic device.
dev.off()