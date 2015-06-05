library(dplyr)
library(lubridate)
working_dir<-getwd()
filename<-paste0(working_dir,'/exdata-data-household_power_consumption.zip')
newname<-paste0(working_dir,'/household_power_consumption.txt')
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,filename,method="curl")
household_power_consumption <- read.csv(unz(filename,'household_power_consumption.txt'), sep=";")
cleandata<-complete.cases(household_power_consumption)
data1<-household_power_consumption[cleandata,]
data1$Date<-parse_date_time(data1$Date,"%d/%m/%y")
feb1<-parse_date_time("1/2/2007","%d/%m/%y")
feb2<-parse_date_time("2/2/2007","%d/%m/%y")
data1$Sub_metering_1<-as.numeric(as.character(data1$Sub_metering_1))
data1$Sub_metering_2<-as.numeric(as.character(data1$Sub_metering_2))
data1$Sub_metering_3<-as.numeric(data1$Sub_metering_3)
idx<-data1$Date>=feb1
feb12007<-data1[idx,]
idx<-feb12007$Date<=feb2
feb1and2<-feb12007[idx,]
png(file="plot3.png",width=480, height=480, units="px")
plot(feb1and2$Sub_metering_1,type="l",ylab="Energy sub metering",xaxt="n",col="black",xlab="")
points(feb1and2$Sub_metering_2,type="l",xaxt="n",col="red")
points(feb1and2$Sub_metering_3,type="l",xaxt="n",col="blue")
axis(1, at=seq(0,2880,by=1440), labels=c("Thu","Fri","Sat"))
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=colnames(data1[7:9]))
dev.off()