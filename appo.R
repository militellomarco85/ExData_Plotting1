# Download Data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile= "./data/exdata_data_household_power_consumption.zip.zip")

#Unzip Data
unzip("data/exdata_data_household_power_consumption.zip")

#Load Data
data <- read.table("household_power_consumption.txt",  na.strings = "?", header = TRUE, sep=";", )
tmp <- grep(pattern = '^1/2/2007|^2/2/2007|^Date', value = TRUE,  readLines("household_power_consumption.txt"))
write(x = tmp, file = "household_power_consumption_subset.txt")
data <- read.table("household_power_consumption_subset.txt",  na.strings = "?", header = TRUE, sep=";")


#Plot1 Data
hist(data$Global_active_power, col = "red", main = "Global Active Power", ylab = "Frequency", xlab="Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480 )
# dev.set(3)
dev.off() ## Don't forget to close the PNG device!


#Plot2 
data <- data.frame(data, datetime = strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S"))
plot(data$datetime, data$Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480 )
# dev.set(3)
dev.off() ## Don't forget to close the PNG device!


#Plot3
data <- data.frame(data, datetime = strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S"))
with(data, plot(datime, Sub_metering_1, type ="l", xlab = "", ylab="Energy by sub metering"))
with(data, lines(datetime, Sub_metering_2, type ="l", col="red"))
with(data, lines(datime, Sub_metering_3, type ="l", col="blue"))

legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1" , "Sub_metering_2", "Sub_metering_3"), lty=c(1,1))

#Plot4
data <- data.frame(data, datetime = strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S"))
par(mfrow = c(2, 2))

plot(data$datetime, data$Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts)")

plot(data$datetime, data$Voltage, type = "l", xlab = "datetime", ylab="Voltage")


with(data, plot(datetime, Sub_metering_1, type ="l", xlab = "", ylab="Energy by sub metering"), legend(c("Sub_metering_1" , "Sub_metering_2", "Sub_metering_3")))
with(data, lines(datetime, Sub_metering_2, type ="l", col="red"))
with(data, lines(datetime, Sub_metering_3, type ="l", col="blue"))
legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1" , "Sub_metering_2", "Sub_metering_3"), lty=c(1,1))

plot(data$datetime, data$Global_reactive_power, type="h", xlab = "datetime", ylab="Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png", width = 480, height = 480 )
