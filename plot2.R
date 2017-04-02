# PLOT 2
# ** to run: data must be saved in current directory

# load data
dt = read.table(file = 'household_power_consumption.txt', sep = ';', header = TRUE, stringsAsFactors = FALSE)

# check that data loaded correctly
str(dt)

# change date to date format
dt$Date <- strptime(dt$Date,'%d/%m/%Y' )

# subset the days we want to plot
dt2 = subset(dt, Date == '2007-02-01' | Date == '2007-02-02')

# remove the original dataset, free up some memory
rm(dt)
gc()

# create datetime var with both of these
dt2$datetime <- strptime(paste(dt2$Date,dt2$Time), format = '%Y-%m-%d %H:%M:%S')

# change other vars to numeric format
dt3 <- apply(dt2[,3:9],2,as.numeric)

# combine datetime var and numeric values into single data.frame
dt <- data.frame(datetime = dt2$datetime,dt3)

# create file for plot 2
png(file = 'plot2.png', width = 480, height = 480)

# make line plot
with(dt, plot(datetime, Global_active_power, type = 'l',xlab = '', ylab = 'Global Active Power (kilowatts)'))

# close graphics device
dev.off()
