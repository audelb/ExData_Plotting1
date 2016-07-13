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
with(dataset, plot(datetime,Global_active_power,type = "l",main = "",xlab = "",ylab = "Global Active Power (kilowatts)"))

#delete png file if it exists
if (file.exists("./plot2.png")) {
  file.remove("./plot2.png")
}  

#copy it in png file
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px") 
dev.off() 