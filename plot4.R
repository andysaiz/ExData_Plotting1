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

#extract global active power column
gap <- unlist(p1selection %>% select(Global_active_power))
gap <- as.numeric(gap)

#telling R how to position the four plots 
par(mfcol = c(2,2))
par(mar = c(4,3,3,2))
#Plot 2 needs Global Active Power vs Weekday (only Thursday, Friday, and Saturday)
#Generate line plot
plot(p1selection$Global_active_power ~ p1selection$Datetime, 
     type = "l",
     ylab = "Global Active Power (kilowatts)", 
     xlab = ""
)

#Plot 3 needs Energy Sub Metering (1, 2, and 3) vs weekday
#Three lines on one graph in three different colors
plot(p1selection$Sub_metering_1 ~ p1selection$Datetime,
     type = "l",
     ylab = "Energy sub metering", 
     xlab = "",
)
lines(p1selection$Datetime, p1selection$Sub_metering_2,
      col = "red"
)
lines(p1selection$Datetime, p1selection$Sub_metering_3,
      col = "blue")
legend("topright", 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_2"),
       lty=1,
       cex = 0.8
)

#Top right graph
plot(p1selection$Voltage ~ p1selection$Datetime, 
     type = "l",
     ylab = "Voltage", 
     xlab = "datetime"
     )

#bottom right graph
plot(p1selection$Global_reactive_power ~ p1selection$Datetime,
     type = "l",
     ylab = "Global_active_power",
     xlab = "datetime"
     )