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

with(household_power_consumption,
     
     plot(date_time,Global_active_power,
          type = "l",
          main = "",
          ylab = "Global Active Power (kilowatts)",
          xlab = ""))

dev.copy(png,"plot2.png",
         width = 480, height = 480, units = "px")

dev.off()