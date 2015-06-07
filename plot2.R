##read data
fh <- file("household_power_consumption.txt")
##clean data
data <- read.table(text = grep("^[1,2]/2/2007", readLines(fh), value = TRUE), 
                   col.names = c("Date", 
                                 "Time", 
                                 "Global_active_power",
                                 "Global_reactive_power",
                                 "Voltage", 
                                 "Global_intensity", 
                                 "Sub_metering_1", 
                                 "Sub_metering_2", 
                                 "Sub_metering_3"), 
                   sep = ";", header = TRUE)
##character string
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
##Data-Time conversion function
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)
##create device
png(file = "plot2.png") 
##generate plot
plot(data$Global_active_power ~ data$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
##close device
dev.off() 
