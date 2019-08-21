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


# plot 2:

png("plot2.png", width=480, height=480)
with(datacp1, plot(Time, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l"))
dev.off()
