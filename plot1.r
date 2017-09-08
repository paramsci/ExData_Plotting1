library(dplyr)
library(lattice)
library(data.table)
library(lubridate)
library(RCurl)
library(utils)
setwd("C:\\Users\\Parikshit\\Documents\\Coursera_Data_Scientist_Spec\\course_4")
filename <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (url.exists(filename)) {
  download.file(filename,"housedata.zip")
  
}

# unzip the file
unzip("housedata.zip", exdir = "C:\\Users\\Parikshit\\Documents\\Coursera_Data_Scientist_Spec\\course_4\\prog_assgnmnt_1")
setwd("C:\\Users\\Parikshit\\Documents\\Coursera_Data_Scientist_Spec\\course_4\\prog_assgnmnt_1")

tab5rows <- read.table("household_power_consumption.txt", header = TRUE, nrows = 5 , sep = ";" ,na.strings = "?")

# tab5rows[,1] <- as.Date(tab5rows[,1], format = "%Y/%m/%d")
classes1 <- sapply(tab5rows,class)

tempdates <- fread("household_power_consumption.txt", select = 1)

tempdates <- as.Date(tempdates$Date, format = "%d/%m/%Y")

taball <- read.table("household_power_consumption.txt", header = TRUE, colClasses = classes1 , sep = ";" ,na.strings = "?")

taball[,1] <- as.Date(taball[,1], format = "%d/%m/%Y" )

temp3 <- subset(taball, tempdates %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))
png(filename = "plot1.png")
hist(temp3$Global_active_power,
     col = "red",
     main = "Global Active Power", xlab = "Global Active Power(kilowatts)" )
dev.off()

