library(tidyverse)
library(foreign)
library(data.table)

# obtaining dataset
dataset_url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = dataset_url, destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip")
datacp1 <- fread("household_power_consumption.txt")

# subsetting to dates of interest: 
datacp1$Time <- paste(datacp1$Date, datacp1$Time, sep = " ")
datacp1$Date <- as.Date(datacp1$Date, "%d/%m/%Y")
datacp1 <- filter(datacp1, Date >= "2007-02-01", Date <= "2007-02-02")

# reclassifying variables:
datacp1$Time <- strptime(datacp1$Time, format = "%d/%m/%Y %H:%M:%S")
datacp1$Global_active_power <- as.numeric(datacp1$Global_active_power)
datacp1$Global_reactive_power <- as.numeric(datacp1$Global_reactive_power)
datacp1$Voltage <- as.numeric(datacp1$Voltage)
datacp1$Global_intensity <- as.numeric(datacp1$Global_intensity)
datacp1$Sub_metering_1 <- as.numeric(datacp1$Sub_metering_1)
datacp1$Sub_metering_2 <- as.numeric(datacp1$Sub_metering_2)
datacp1$Sub_metering_3 <- as.numeric(datacp1$Sub_metering_3)


# plot 4:
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

with(datacp1, plot(Time, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l"))

with(datacp1, plot(Time, Voltage, ylab = "Voltage", xlab = "datetime", type = "l"))

with(datacp1, plot(Time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(datacp1, points(Time, Sub_metering_2, type = "l", col = "red"))
with(datacp1, points(Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = c(1, 1), col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(datacp1, plot(Time, Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l"))

dev.off()
