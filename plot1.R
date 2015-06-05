library(dplyr)
library(lubridate)
working_dir<-getwd()
filename<-paste0(working_dir,'/exdata-data-household_power_consumption.zip')
newname<-paste0(working_dir,'/household_power_consumption.txt')
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,filename,method="curl")
household_power_consumption <- read.csv(unz(filename,'household_power_consumption.txt'), sep=";")
cleandata<-complete.cases(household_power_consumption)
data<-household_power_consumption[cleandata,]
data$Date<-parse_date_time(data$Date,"%d/%m/%y")
feb1<-parse_date_time("1/2/2007","%d/%m/%y")
feb2<-parse_date_time("2/2/2007","%d/%m/%y")
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))
idx<-data$Date>=feb1
feb12007<-data[idx,]
idx<-feb12007$Date<=feb2
feb1and2<-feb12007[idx,]
png(file="plot1.png",width=480, height=480, units="px")
hist(feb1and2$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()