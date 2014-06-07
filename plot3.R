# This file reads the power consumption data from a file,
# and writes to a PNG file a plot of the 3 sub meterings

# This function reads the data from the file, subsets to desired dates,
# fixes all variables, and returns the data frame
getData <- function (){
    
    # read all columns as characters (for better performance)
    data <- read.table("household_power_consumption.txt", sep=";",
                       header=TRUE, na.string = "?", colClasses="character")
    
    # subset to desired dates
    data <- subset(data, Date =="1/2/2007" | Date =="2/2/2007")
    
    # set the datetime variable
    data$DateTime<-strptime(paste(data$Date, data$Time, sep = " "),
                            "%d/%m/%Y %H:%M:%S")
    
    # coerce all other variables to numeric
    data[3:9]<-lapply(data[3:9],as.numeric)
    
    # return data
    data
}

# get the data from file
pc <- getData()

# open png file
png("plot3.png", 480, 480)

# write a blank plot
plot(pc$DateTime, pc$Sub_metering_1, type="n",
     xlab="", ylab = "Energy sub metering")

# add black plot (sub_metering_1)
lines(pc$DateTime, pc$Sub_metering_1, type="l", col = "black")

# add red plot (sub_metering_2)
lines(pc$DateTime, pc$Sub_metering_2, type="l", col = "red")

# add blue plot (sub_metering_3)
lines(pc$DateTime, pc$Sub_metering_3, type="l", col = "blue")

# add legend
legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"), lty=1)

#close file
dev.off()