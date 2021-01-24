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

