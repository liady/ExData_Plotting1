# This file reads the power consumption data from a file,
# and writes to a PNG file a plot of the Global Active Power

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
power_consumption <- getData()

# open png file
png("plot2.png", 480, 480)

# write plot
plot(power_consumption$DateTime, power_consumption$Global_active_power,
     type="l", xlab="", ylab = "Global Active Power (kilowatts)")

#close file
dev.off()