# load the data and subset it
filename <- "household_power_consumption.txt"
dflarge <- read.table(filename, sep=";", header=T)
df.1 <- dflarge[dflarge$Date == '1/2/2007',]
df.2 <- dflarge[dflarge$Date == '2/2/2007',]
df <- rbind(df.1,df.2)
rm(dflarge)

# convert Date strings to Date objects
# convert Time column to a timestamp column (TS)
datetimes <- paste(df$Date,df$Time)
names(df)[2] <- "TS"
df$TS <- as.POSIXct(strptime(datetimes,format="%d/%m/%Y %H:%M:%S"))
df$Date <- as.Date(df$TS)

# make data columns numeric
for (i in 3:9) {
	df[,i] <- as.numeric(as.character(df[,i]))
}

# plot 2
ylabel <- "Global Active Power (kilowatts)"
png("plot2.png",width=480,height=480)
plot(df[,3] ~ df$TS, type="n",main="",xlab="",ylab=ylabel)
lines(cbind(as.vector(df$TS),as.vector(df[,3])))
dev.off()

