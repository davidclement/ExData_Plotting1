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

# plot 4


# open png device
png("plot4.png",width=480,height=480)

# set mfcol to 2 x 2, set margins, 
par(mfcol=c(2,2),mar=c(7,4,1,1))

# plot 4a (same as plot2)
ylabel <- "Global Active Power"
plot(df[,3] ~ df$TS, type="n",main="",xlab="",ylab=ylabel)
lines(cbind(as.vector(df$TS),as.vector(df[,3])))

# plot 4b (same as plot3)
maxvalue <- max(df[,7])
maxcol <- df[,7]
if (max(df[,8] > maxvalue)) {
	maxvalue <- max(df[,8])
	maxcol <- df[,8]
}
if (max(df[,9] > maxvalue)) {
	maxvalue <- max(df[,9])
	maxcol <- df[,9]
}
ylabel <- "Energy sub metering"
plot(maxcol ~ df$TS, type="n",main="",xlab="",ylab=ylabel)
lines(cbind(as.vector(df$TS),as.vector(df[,7])), col="black")
lines(cbind(as.vector(df$TS),as.vector(df[,8])), col="red")
lines(cbind(as.vector(df$TS),as.vector(df[,9])), col="blue")
legend("topright",
	legend=names(df)[7:9],
	lty=c(1,1,1),
	col=c('black','red','blue'),
	bty="n")

# plot 4c and 4d (they're the same except for column #)
for (i in c(5,4)) {
  ylabel <- names(df)[i]
  xlabel <- "datetime"
  plot(df[,i] ~ df$TS, type="n",main="",xlab=xlabel,ylab=ylabel)
  lines(cbind(as.vector(df$TS),as.vector(df[,i])))
}

# close the device
dev.off()

