## Load required packages
library(data.table)
library(dplyr)
library(lubridate)

## Read the data from the household_power_consumption.txt file which should be 
## located in the working directory
dataFrame <- read.csv("household_power_consumption.txt", 
                      sep = ";",
                      na.strings = "?", 
                      colClasses = c("character", "character", rep("numeric", 7)),
                      stringsAsFactors = FALSE)

## Convert data frame to data table which offers much better performance
dataTable <- data.table(dataFrame)

## Subest the data only for 2007-0201 and 2007-02-02
dataTable <- subset(dataTable, Date == "1/2/2007" | Date == "2/2/2007")

## Remove all records with the NA values
dataTable <- na.omit(dataTable)

## Convert the Date variable from the character type to the date type
dataTable <- dataTable %>% mutate(Date_Time = dmy_hms(paste(Date, Time)))

## open a PNG file device
png(file="plot4.png")

## Four plots in two rows and two columns
par(mfrow = c(2, 2))

## Create first plot
with(dataTable, plot(Date_Time, Global_active_power,
                     type = "l",
                     main = "", 
                     xlab ="", 
                     ylab = ""))

## Add y-axis lable
title (ylab = "Global Active Power")

## Create second plot
with(dataTable, plot(Date_Time, Voltage,
                     type = "l",
                     main = "", 
                     xlab ="", 
                     ylab = ""))

## Add x-axis lable
title (xlab = "datetime")

## Add y-axis lable
title (ylab = "Voltage")

## Create third plot
with(dataTable, plot(Date_Time, Sub_metering_1,
                     type = "l",
                     main = "", 
                     xlab ="", 
                     ylab = "",
                     col = "black"))

with(dataTable, points(Date_Time, Sub_metering_2,
                       type = "l",
                       col = "red"))

with(dataTable, points(Date_Time, Sub_metering_3,
                       type = "l",
                       col = "blue"))

## Add y-axis lable
title (ylab = "Energy sub metering")

## Add legend in the top right corner
legend("topright",
       lwd = 1, 
       lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

## Create fourth plot
with(dataTable, plot(Date_Time, Global_reactive_power,
                     type = "l",
                     main = "", 
                     xlab ="", 
                     ylab = ""))

## Add x-axis lable
title (xlab = "datetime")

## Add y-axis lable
title (ylab = "Global_reactive_power")

## closes the PNG file device
dev.off()