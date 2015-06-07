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
png(file = "plot3.png")
##generate plot
with(data, {plot(Sub_metering_1 ~ Datetime, type = "l", 
                 ylab = "Energy sub metering", xlab = "")
            lines(Sub_metering_2 ~ Datetime, col = 'Red')
            lines(Sub_metering_3 ~ Datetime, col = 'Blue')}
)
##add legend to plot
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
##close device
dev.off() 
