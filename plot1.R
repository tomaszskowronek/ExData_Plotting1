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
png(file="plot1.png")

## Create a plot (historgram)
with(dataTable, hist(Global_active_power,
                     main = "", 
                     xlab ="", 
                     ylab = "",
                     col = "red"))

## Add main label
title(main = "Global Active Power")

## Add x-axis lable
title (xlab = "Global Active Power (kilowatts)")

## Add y-axis lable
title (ylab = "Frequency")

## closes the PNG file device
dev.off()