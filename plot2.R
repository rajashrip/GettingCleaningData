require(sqldf)                		
# set your working directory to the folder where you have the raw data file stored
# If you don't have the file,get it from here https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#read the file
file <- c("household_power_consumption.txt")				
a2 <- read.csv.sql(file, header = T, sep=";", sql = "select * from file where (Date == '1/2/2007' OR Date == '2/2/2007')" )				


#combining the Date and Time variables to create one datetime variable of class character
a2$datetime <- paste(a2$Date,a2$Time,sep = " ")

#convert the character class datetime variable into 
a2$datetime <- as.POSIXct(strptime(a2$datetime,"%d/%m/%Y %H:%M:%S"))

#head(a2)
#Open the file device using png()
png("plot2.png",width = 480,height = 480,units = "px",bg = "transparent",pointsize = 12)
 
#windows() --use this to test, send to your screen

#plot the graph using base plotting system and function plot()
plot(a2$datetime,a2$Global_active_power,type = "l",ylab = "Global Active Power (kilowatts)",xlab = "")

# close the device connection.
dev.off()

