#creating the data directory:

if (!file.exists('Project_1')){
    dir.create('Project_1')
}

url1 = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# downloading/unzipping:

if (!file.exists("./Project_1/dataset.zip")){
    download.file(url1, destfile = "./Project_1/dataset.zip", mode = "wb")
}

if(!file.exists('./Project_1/household_power_consumption.txt')){ 
    unzip("./Project_1/dataset.zip", exdir = "./Project_1") 
}


# reading the dataset:

data <- read.table('./Project_1/household_power_consumption.txt', header = TRUE, sep = ';', na.strings= "?")

# getting the summary on the NA values:

sapply(data, function(x) sum(is.na(x))) # colSums(is.na(data)) will do the same

# introducing variables for the dates of interest: 

day1 <- as.Date("2007-02-01")
day2 <- as.Date("2007-02-02")

# adding the Date.Tim column to the data frame containing the 
# date and time variables converted to the R date/time format:

data$Date.Time = strptime(paste(data$Date, data$Time), "%d/%m/%Y%H:%M:%S")

# subseting the data for the dates of interest

days <- subset(data, ((as.Date(data$Date.Time) == day1)|(as.Date(data$Date.Time) == day2)))

# plotting the histogram for the "Global Active Power" column data 
# (the output is sent to "./Project_1/plot4.png"):

png(file = "./Project_1/plot4.png") # note that it is not necessary to specify
                                    # the size because 480 px by 480 px is the 
                                    # default size. This can be adjusted using the
                                    # the width, height, and units options of png.
par(mfrow = c(2, 2))

# first graph:

plot(days$Date.Time, days$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# second graph:

plot(days$Date.Time, days$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# third graph:

plot(days$Date.Time, days$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(days$Date.Time, days$Sub_metering_2, col = "red")
lines(days$Date.Time, days$Sub_metering_3, col = "blue")
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n" )



# forth graph:

plot(days$Date.Time, days$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()