plot1 <- function(){
  #read data (assumes data is downloaded and unzipped in the default directory)
  power_consumption <- read.table("~/household_power_consumption.txt", header=TRUE, sep=";")

  #subset data
  consumption_select<-subset(power_consumption, power_consumption$Date=="1/2/2007" | power_consumption$Date=="2/2/2007")
  
  #basic plot function to export as png
  png("plot1.png", width=480, height=480)
  hist(as.numeric(as.character(consumption_select$Global_active_power)), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
  dev.off()
}
