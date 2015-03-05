require(sqldf)  

# set your working directory to the folder where you have the raw data file stored
# If you don't have the file,get it from here https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#assuming the file is already in your working folder. Read the file
file <- c("household_power_consumption.txt")        			
a2 <- read.csv.sql(file, header = T, sep=";", sql = "select * from file where (Date == '1/2/2007' OR Date == '2/2/2007')" )				

#combining the Date and Time variables to create one datetime variable of class character
a2$datetime <- paste(a2$Date,a2$Time,sep = " ")

#convert the character class datetime variable into 
a2$datetime <- as.POSIXct(strptime(a2$datetime,"%d/%m/%Y %H:%M:%S"))

#Open the file device using png()
png("plot4.png",width = 480,height = 480,units = "px",bg = "transparent",pointsize = 12)

#windows() --use this to test, send to your screen

##This allows for the graphs to be created on the same screen, 2 columns and 2 rows
par(mfrow = c(2,2))

#Plot the file
#1st
plot(a2$datetime,a2$Global_active_power,type = "l",ylab = "Global Active Power (kilowatts)",xlab = "")

#2nd
plot(a2$datetime,a2$Voltage,type = "l",ylab = "Voltage",xlab = "datetime")

#3rd
plot(a2$datetime,a2$Sub_metering_1,col= "black",type = "l",ylab = "Energy Sub Metering",xlab = "")
lines(a2$datetime,a2$Sub_metering_2,type = "l",col = "red")
lines(a2$datetime,a2$Sub_metering_3,type = "l",col= "blue")
legend("topright",legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty = 1)

#4th
plot(a2$datetime,a2$Global_reactive_power,type = "l",ylab = "Global Reactive Power (kilowatts)",xlab = "datetime")

dev.off()