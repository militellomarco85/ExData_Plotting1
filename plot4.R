# plot4.R script
# Language Difference
# The name of the days are reported in Italian (the default language of my PC)!


# 01 Download Data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile= "exdata_data_household_power_consumption.zip")

# 01 Unzip Data
unzip("exdata_data_household_power_consumption.zip")
file.remove("exdata_data_household_power_consumption.zip")

# Load Only rows starting with the right date or the column names.
tmp <- grep(pattern = '^1/2/2007|^2/2/2007|^Date', value = TRUE,  readLines("household_power_consumption.txt"))

# Write temp data on a temporary file
write(x = tmp, file = "household_power_consumption_subset.txt")

#load right data
data <- read.table("household_power_consumption_subset.txt",  na.strings = "?", header = TRUE, sep=";")

# Remove temporary files and data
rm(tmp)
file.remove("./household_power_consumption.txt")
file.remove("./household_power_consumption_subset.txt")

#Plot4
data <- data.frame(data, datetime = strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S"))
#Set parameter to show 4 graphs
par(mfrow = c(2, 2))

plot(data$datetime, data$Global_active_power, type = "l", xlab = "", ylab="Global Active Power")

plot(data$datetime, data$Voltage, type = "l", xlab = "datetime", ylab="Voltage")


with(data, plot(datetime, Sub_metering_1, type ="l", xlab = "", ylab="Energy sub metering"), legend(c("Sub_metering_1" , "Sub_metering_2", "Sub_metering_3")))
with(data, lines(datetime, Sub_metering_2, type ="l", col="red"))
with(data, lines(datetime, Sub_metering_3, type ="l", col="blue"))
legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1" , "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), cex= 0.7, y.intersp = 0.3, bty = "n")
plot(data$datetime, data$Global_reactive_power, type="h", xlab = "datetime", ylab="Global_reactive_power")

number <- dev.copy(png, file = "plot4.png", width = 480, height = 480 )
dev.off(number)