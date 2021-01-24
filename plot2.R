rm(list = ls())

#Read in data from the dates 2007-02-01 and 2007-02-02
unzip("household_power_consumption.zip")
library(data.table)
p1data <- fread("household_power_consumption.txt")

#Change date and time columns to the date class using as.Date
p1data$Date <- as.Date(p1data$Date, format = "%d/%m/%Y")

#subset only the dates from 2007-02-01 and 2007-02-02
library(dplyr)
p1selection <- filter(p1data, p1data$Date == "2007-02-01" | p1data$Date == "2007-02-02")

#Convert dates and times
p1selection$Datetime <- as.POSIXct(paste(p1selection$Date, p1selection$Time), format = "%Y-%m-%d %H:%M:%S")

#Plot 2 needs Global Active Power vs Weekday (only Thursday, Friday, and Saturday)
#Generate line plot
plot(p1selection$Global_active_power ~ p1selection$Datetime, 
     type = "l",
     ylab = "Global Active Power (kilowatts)", 
     xlab = ""
     )

#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#Name each of the plot files as plot1.png, plot2.png, etc.
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()