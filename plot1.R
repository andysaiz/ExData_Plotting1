rm(list = ls())

#Read in data from the dates 2007-02-01 and 2007-02-02
unzip("household_power_consumption.zip")
library(data.table)
p1data <- fread("household_power_consumption.txt")

#Change date and time columns to the date class using as.Date
library(lubridate)
p1data$Date <- dmy(p1data$Date)
p1data$Time <- hms(p1data$Time)

#subset only the dates from 2007-02-01 and 2007-02-02
library(dplyr)
p1selection <- filter(p1data, p1data$Date == "2007-02-01" | p1data$Date == "2007-02-02")

#extract global active power column
gap <- unlist(p1selection %>% select(Global_active_power))
gap <- as.numeric(gap)

p1selection %>% mutate(Date = weekdays(Date))

#construct plot 1
#frequency vs global active power (kilowatts). Title = Global Active Power
hist(gap,
        col = "red",
        xlab = "Global Active Power (kilowatts)",
        ylab = "Frequency",
        main = "Global Active Power",
        breaks = 12
)

#Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#Name each of the plot files as plot1.png, plot2.png, etc.
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
