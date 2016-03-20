# plot2.R script

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

#Plot2 
data <- data.frame(data, datetime = strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S"))
plot(data$datetime, data$Global_active_power, type = "l", xlab = "", ylab="Global Active Power (kilowatts)")
number <- dev.copy(png, file = "plot2.png", width = 480, height = 480 )
dev.off(number)