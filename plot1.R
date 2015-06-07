rm("reqddata")
rawtable <-read.table("./household_power_consumption.txt",header=T,sep = ";", colClasses = c(rep("character",2),rep("numeric",7)),na.strings="?", stringsAsFactors = F)

rawtable <- within(rawtable, Datetime <- as.POSIXlt(paste(Date, Time),
                                                    format = "%d/%m/%Y %H:%M:%S"))

reqddata <- subset(rawtable, (rawtable$Date=='1/2/2007') | (rawtable$Date == '2/2/2007'))

rm("rawtable")
png("plot1.png")
hist(reqddata$Global_active_power,col="red",xlab="Global active power(kilowatts)", main="Global Active Power")
dev.off()
