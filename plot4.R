# PLOT 4
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

# create file for plot 4
png(file = 'plot4.png', width = 480, height = 480)

# set up graph parameters (2 x 2 grid)
par(mfrow = c(2,2), mar = c(4,4,1,1))

# make plots

# plot 1
with(dt, plot(datetime, Global_active_power, type = 'l',xlab = '', ylab = 'Global Active Power'))

# plot 2
with(dt, plot(datetime, Voltage, type = 'l',xlab = '', ylab = 'Voltage'))

# plot 3
plot(dt$datetime, dt$Sub_metering_1, type = 'l',xlab = '', ylab = 'Energy sub metering')
lines(dt$datetime,dt$Sub_metering_2, col = 'red')
lines(dt$datetime,dt$Sub_metering_3, col = 'blue')
legend('topright', legend = c(paste0('Sub_metering_',1:3)), lty = 1, col = c('black', 'red','blue'), cex = 0.75, box.col = 'transparent', inset = .01)

# plot 4
with(dt, plot(datetime, Global_reactive_power, type = 'l'))

# close graphics device
dev.off()
