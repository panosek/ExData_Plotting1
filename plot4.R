rm("reqddata")
rawtable <-read.table("./household_power_consumption.txt",header=T,sep = ";", colClasses = c(rep("character",2),rep("numeric",7)),na.strings="?", stringsAsFactors = F)

rawtable <- within(rawtable, Datetime <- as.POSIXlt(paste(Date, Time),
                                                    format = "%d/%m/%Y %H:%M:%S"))

reqddata <- subset(rawtable, (rawtable$Date=='1/2/2007') | (rawtable$Date == '2/2/2007'))

rm("rawtable")
png("plot4.png")
par(mfrow=c(2,2))

with(reqddata,plot(Datetime,Global_active_power,type="l",ylab = "Global active power (kilowatts)"))

with(reqddata,plot(Datetime,Voltage,type="l", xlab = "datetime", ylab = "Voltage"))

with (reqddata, 
      {
        plot(Datetime,Sub_metering_1,type="l",col="black",xlab = "", ylab="Energy sub metering")
        lines(Datetime,Sub_metering_2,col="red")
        lines(Datetime,Sub_metering_3,col="blue")
        legend("topright", lty=c(1,1),col= c("black", "red", "blue"),legend=c("sub_metering_1", "sub_metering_2", "submetering_3"),bty="n", cex=0.5,y.intersp=0.5)
      }
)


with(reqddata,plot(Datetime,Global_reactive_power,type="l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()