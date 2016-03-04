library(ggplot2)

# Read in data
nei <- readRDS("summarySCC_PM25.rds")

png(filename = "plot3.png", width = 480, height = 480)

# Get sum of emissions for each year
# Baltimore's fips number
baltimore <- 24510
baltimore_data <- nei[nei$fips==baltimore,]
baltimore_type <- aggregate(baltimore_data$Emissions, list(year=baltimore_data$year, type=baltimore_data$type), sum)

ggplot(baltimore_type, aes(x=year, y=x, group=type, color=type)) + geom_line() + geom_point() + ylab("PM2.5 Emissions") + ggtitle("Baltimore PM2.5 Emissions")
dev.off()