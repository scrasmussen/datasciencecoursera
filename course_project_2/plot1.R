# Read in data
nei <- readRDS("summarySCC_PM25.rds")

png(filename = "plot1.png", width = 480, height = 480)

# Get sum of emissions for each year
yearly_sum <- aggregate(Emissions ~ year, nei, sum)
colnames(yearly_sum)[2] <- "Total Emissions Per Year"
plot(yearly_sum, type="o", axes=FALSE)
title(main="PM2.5 Output")
axis(1, at=yearly_sum$year)
axis(2)
box()
dev.off()