plot4<-function(){
  #read data (assumes data is in default directory)
  power_consumption <- read.table("~/Data Analysis Project/household_power_consumption.txt", header=TRUE, sep=";")
  
  #subset data
  consumption_select<-subset(power_consumption, power_consumption$Date=="1/2/2007" | power_consumption$Date=="2/2/2007")
  
  #adjust Date and Time formats
  consumption_select$Date <- as.Date(consumption_select$Date, format="%d/%m/%Y")
  consumption_select$Time <- strptime(consumption_select$Time, format="%H:%M:%S")
  consumption_select[1:1440, "Time"]<- format(consumption_select[1:1440,"Time"], "2007-02-01 %H:%M:%S")
  consumption_select[1441:2880, "Time"]<-format(consumption_select[1441:2880, "Time"], "2007-02-02 %H:%M:%S")
  
  #initialize png
  png("plot4.png", width=480, height=480)
  
  #create composite plot
  par(mfrow=c(2,2))
  
  #plot function to create 4 plots
  with(consumption_select, {
    plot(consumption_select$Time, as.numeric(as.character(consumption_select$Global_active_power)), type="l", xlab="", ylab="Global Active Power")
    plot(consumption_select$Time, as.numeric(as.character(consumption_select$Voltage)), type="l", xlab="datetime", ylab="Voltage")
    plot(consumption_select$Time, consumption_select$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
    with(consumption_select, lines(Time,as.numeric(as.character(Sub_metering_1))))
    with(consumption_select, lines(Time, as.numeric(as.character(Sub_metering_2)), col="red"))
    with(consumption_select, lines(Time, as.numeric(as.character(Sub_metering_3)), col="blue"))
    legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8, bty="n")
    plot(consumption_select$Time, as.numeric(as.character(consumption_select$Global_reactive_power)), type="l",xlab="datetime",ylab="Global_reactive_power")
  })
  dev.off()
}