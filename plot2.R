# This file reads the power consumption data from a file,
# and writes to a PNG file a plot of the Global Active Power

# This function reads the data from the file, subsets to desired dates,
# fixes all variables, and returns the data frame
getData <- function (){
    setwd("C:/Users/user/Code/r/Exploratory Data Analysis/Project 1")
    filename <- "household_power_consumption.txt"
    
    # read all columns a characters (for better performance)
    data <- read.table(filename, sep=";",header=TRUE, na.string = "?",
                       colClasses="character")
    
    # subset to desired dates
    data <- subset(data, Date =="1/2/2007" | Date =="2/2/2007")
    
    # fix the date/time variables
    data$DateTime<-strptime(paste(data$Date, data$Time, sep = " "),
                            "%d/%m/%Y %H:%M:%S")    
    data$Date <- as.Date(data$Date, "%d/%m/%Y")
    
    # coerce all other variables to numeric
    s<-c("Global_active_power","Global_reactive_power","Voltage",
         "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
    data[s]<-lapply(data[s],as.numeric)
    
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