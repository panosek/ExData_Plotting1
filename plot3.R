rm("reqddata")
rawtable <-read.table("./household_power_consumption.txt",header=T,sep = ";", colClasses = c(rep("character",2),rep("numeric",7)),na.strings="?", stringsAsFactors = F)

rawtable <- within(rawtable, Datetime <- as.POSIXlt(paste(Date, Time),
                                                    format = "%d/%m/%Y %H:%M:%S"))

reqddata <- subset(rawtable, (rawtable$Date=='1/2/2007') | (rawtable$Date == '2/2/2007'))
rm("rawtable")

png("plot3.png")
with (reqddata, 
      {
        plot(Datetime,Sub_metering_1,type="l",col="black",xlab = "", ylab="Energy sub metering")
        lines(Datetime,Sub_metering_2,col="red")
        lines(Datetime,Sub_metering_3,col="blue")
        legend("topright",lty=c(1,1),col= c("black", "red", "blue"),legend=c("sub_metering_1", "sub_metering_2", "submetering_3"))
      }
)
dev.off()
