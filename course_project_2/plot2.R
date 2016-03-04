# Read in data
nei <- readRDS("summarySCC_PM25.rds")

png(filename = "plot2.png", width = 480, height = 480)

# Get sum of emissions for each year
# Baltimore's fips number
baltimore <- 24510
baltimore_data <- nei[nei$fips==baltimore,]
yearly_sum <- aggregate(Emissions ~ year, baltimore_data, sum)
colnames(yearly_sum)[2] <- "PM2.5 Levels"
plot(yearly_sum, type="o", axes=FALSE)
title(main="Baltimore PM2.5 Output")
axis(1, at=yearly_sum$year)
axis(2)
box()
dev.off()