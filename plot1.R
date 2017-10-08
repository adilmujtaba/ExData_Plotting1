##The following scripts creates a histogram for Global Active Power. 
##I have used the package lubridate to for parsing the date column.

##Load Lubridate package

library(lubridate)

## Read data from workspace, Please set the workspace accordingly

household<-read.table("household_power_consumption.txt",sep=";",header=TRUE,stringsAsFactors = FALSE)

## Subsetting the data for only 1st and 2nd Februaury.

household_subset<-subset(na.exclude(household),dmy(Date)>="2007-02-01" & dmy(Date) <="2007-02-02")

## Open PDF device "plot1.pdf" in working directory

png("plot1.png")

## Creating a histogram,
hist(as.numeric(as.character(household_subset[[3]])),col="Red",breaks=16,xlim =c(0,6),xlab="Global Active Power (kilowatts)",main="Global Active Power",axes = FALSE)

axis(2)

axis(1, at=seq(0,6,by=2))

## Closing the connection to PDF to move back to default graphic device.
dev.off()

