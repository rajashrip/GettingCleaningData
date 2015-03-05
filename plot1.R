require(sqldf)        			
# set your working directory to the folder where you have the raw data file stored
# If you don't have the file,get it from here https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

file <- c("household_power_consumption.txt")				
a1 <- read.csv.sql(file, header = T, sep=";", sql = "select * from file where (Date == '1/2/2007' OR Date == '2/2/2007')" )				

#save the file in png format
png("plot1.png",width = 480,height = 480,units = "px",bg = "transparent",pointsize = 12)

#plot the graph using hist
hist(a1$Global_active_power,col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")
#close the device
dev.off()
