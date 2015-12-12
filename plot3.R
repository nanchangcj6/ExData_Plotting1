# Exploratory Data Analysis course project one
# Recreating four plots based on a data subset of household energy use
# for 2 days in 2007

# The dataset must be read, subsetted and character dates/times changed
# into POSIXct datetime values and the plots are drawn.  
# The data subsetting code is common to each R file so that any one can be run
# in isolation.

# The source data must be extraced from the zip file and saved at the location
# specified by the "file" variable

# This R script creates plot 3

# Use the sqldf library to subset a large file without having to read it all
# into memory and then subset
library(sqldf)

# source data file
file <- "~/datasciencecoursera/household_power_consumption.txt"

# Read and subset the data using sql type syntax from sqldf
df_data_subset <- read.csv.sql(file, 
                sql = "select * from file 
                where Date = '1/2/2007' 
                or Date = '2/2/2007'", 
                header = TRUE, 
                sep=";")

# tidy up to avoid warnings
closeAllConnections()

# Combine the charactacter Date and Time fields into a new POSIXct column
df_data_subset$DateTime <- as.POSIXct(
        paste(df_data_subset$Date, df_data_subset$Time), 
        format = "%d/%m/%Y %H:%M:%S")

# set the png graphics device with appropriate settings
png("~/datasciencecoursera/exploratory analysis/project_1/plot3.png", 
    width = 480, 
    height = 480, 
    units = 'px')

# Now draw the plot
plot(df_data_subset$DateTime,
     df_data_subset$Sub_metering_1, 
     type = "l",
     col = "black",
     ylab = "Energy sub metering", 
     xlab = " "
        )

# add the second variable to the y axis
lines(df_data_subset$DateTime,
      df_data_subset$Sub_metering_2, 
      type = "l",
      col = "red"
        )

# and the third
lines(df_data_subset$DateTime,
      df_data_subset$Sub_metering_3, 
      type = "l",
      col = "blue"
        )

# lastly the legend
legend("topright", 
       lwd = "1", 
       col = c("black","red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        )

# and close the graphics device
dev.off()
