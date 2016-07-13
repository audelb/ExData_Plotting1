# download sources
if (!file.exists("./dataset.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./dataset.zip")
}
if (!file.exists("./household_power_consumption.txt")) {
  unzip("./dataset.zip")
}

#read file
dataset <- read.table("./household_power_consumption.txt",sep = ";", header = TRUE, na.strings = "?",colClasses = c(rep("character",2),rep("numeric",7)))

#convert in Date format the Date and time Columns
dataset$datetime <- strptime(paste(dataset$Date, dataset$Time), "%d/%m/%Y %H:%M:%S")

#filter datas on Date value
dataset <- dataset[as.Date(dataset$datetime) %in% as.Date("2007-02-01"):as.Date("2007-02-02"),]

#build the graph
par(mfrow = c(2, 2), mar = c(5, 4, 2, 2))
with(dataset, plot(datetime,Global_active_power,type = "l",main = "",xlab = "",ylab = "Global Active Power (kilowatts)"))
with(dataset, plot(datetime,Voltage,type = "l",main = "",xlab = "datetime",ylab = "Voltage"))
with(dataset, plot(datetime,Sub_metering_1,type = "l",main = "",xlab = "",ylab = "Energy sub metering"))
with(dataset, lines(datetime, Sub_metering_2, col = "red"))
with(dataset, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, bty = "n",pt.cex = 1, cex = 0.75, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(dataset, plot(datetime,Global_reactive_power,type = "l",main = "",xlab = "datetime",ylab = "Global_Reactive_Power"))

#delete png file if it exists
if (file.exists("./plot4.png")) {
  file.remove("./plot4.png")
}  

#copy it in png file
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px") 
dev.off() 