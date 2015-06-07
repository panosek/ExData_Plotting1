#This script assumes that the household_power_consumption.txt file has already been 
#downloaded from the web to the working directory. Each script will recreate the 
#dataframe from the text file and will not assume that it has been previously created.


# read all the data to a dataframe
rawtable <-read.table("./household_power_consumption.txt",header=T,sep = ";", colClasses = c(rep("character",2),rep("numeric",7)),na.strings="?", stringsAsFactors = F)

# add a new column 'datetime' with which is the date and time concatenated.
rawtable <- within(rawtable, Datetime <- as.POSIXlt(paste(Date, Time),
                                                    format = "%d/%m/%Y %H:%M:%S"))

#pick out the two days we are interested in and discard the rest of the data.
reqddata <- subset(rawtable, (rawtable$Date=='1/2/2007') | (rawtable$Date == '2/2/2007'))
rm("rawtable")


#plot graph to .png file.
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
