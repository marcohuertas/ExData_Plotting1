#
# Script to make plot 1 for assignment
#
# Script assumes that the file household_power_consumption.txt is in the working directory

# First get the names of the columns
x <- read.table("household_power_consumption.txt",header=T,sep=";",na.strings = "?",nrows = 2)
# Make all names lowercase and remove the underscore "_"
xnames <- tolower(gsub("_","",names(x)))

# Data starts on date 16/12/2006 at 17:24:00.
# Since data is collected at a rate of 1 per min. The number of minutes to finish the first
# day is: 37 min to get to 18:00:00 and 6 hours of 60 min each
jumptonextday <- 37+6*60

# This puts us on 17/12/2006. To finish the month we need 15 more days. Adding 31 days more
# will put us at the beginning of Feb. 2007. Each day contains 1440 min.
minsinday <- 1440

# The data we need for the plots is just from two days.
# Total number of lines to skip and total number of rows to read
nskiptot <- jumptonextday+(15+31)*minsinday
nrowstot <- 2*minsinday

x <- read.table("household_power_consumption.txt",header=F,sep=";",na.strings = "?",
                nrows = nrowstot,
                skip = nskiptot)

names(x) <- xnames

# Convert the Date and Time columns into a new column Date/Time
x$datetime <- strptime(paste(x$date,x$time),"%d/%m/%Y %H:%M:%S")

png("plot1.png")
hist(x$globalactivepower,col = "red",xlab = "Global Active Power (kilowats)",
     ylab = "Frequency", main = "Global Active Power")
dev.off()










