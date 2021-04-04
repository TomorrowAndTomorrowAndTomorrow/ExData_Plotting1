library(readr)
library(dplyr)

setwd("D:/Data science/My R learnings/Coursera/04 Explanatory Data Anal/Week 1 assignment/ExData_Plotting1")

temp <- paste(getwd(),"household_power_consumption.zip",sep="/")
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile = temp)

unzipped_file <- unz(temp,"household_power_consumption.txt")

household_power_consumption <- read_delim(unzipped_file,
                                          ";", escape_double = FALSE,
                                          trim_ws = TRUE,
                                          col_types = "ccddddddd",
                                          na = "?",
                                          n_max = 49*24*60) %>% # import up to 02 Feb 2007
        filter(Date %in% c("1/2/2007", "2/2/2007")) %>%
        mutate(date_time = strptime(paste(Date, Time, sep = " "),
                                    format="%d/%m/%Y %H:%M:%S"))

unlink(temp)

par(mfrow = c(2,2))

par(cex=0.5)

with(household_power_consumption, {
        
        # Top-left graph
        plot(date_time, Global_active_power,
             main = "", xlab = "", ylab = "Global Active Power", type = "l")
        
        # Top-right graph
        plot(date_time, Voltage,
             main = "", xlab = "datetime", ylab = "Voltage", type = "l")
        
        # Bottom-left graph       
        with(household_power_consumption,
             plot(date_time, Sub_metering_1,
                  col = "black",
                  type = "l",
                  xlab = "",
                  ylab = "Energy sub metering",
                  main = "",
                  lwd = 1))
        
        with(household_power_consumption,
             lines(date_time, Sub_metering_2,
                   col = "red",
                   lwd = 1,
                   type = "l"))
        
        with(household_power_consumption,
             lines(date_time, Sub_metering_3,
                   col = "blue",
                   lwd = 1,
                   type = "l"))
        
        legend("topright",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col = c("black", "red", "blue"),
               lwd = c(1,1,1))
        
        # Bottom-right graph
        plot(date_time, Global_reactive_power,
             main = "", xlab = "datetime", ylab = "Global_reactive_power", type = "l")
        
})

dev.copy(png,"plot4.png",
         width = 480, height = 480, units = "px")

dev.off()

