library(ggplot2)

# Read in data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")


png(filename = "plot5.png", width = 480, height = 480)

# Baltimore's fips number
baltimore <- 24510
# get Baltimore data
baltimore_nei <- nei[nei$fips==baltimore,]

# Get sum of emissions for each year
# get the scc numbers of vehicle sources then extract nei data with matching scc numbers
scc_num <- scc$SCC[grep("Vehicle", scc$EI.Sector)]
nei_vehicle <- baltimore_nei[baltimore_nei$SCC %in% scc_num,]
yearly_vehicle_sum <- aggregate(Emissions ~ year, nei_vehicle, sum)

ggplot(yearly_vehicle_sum, aes(x=year,y=Emissions)) + geom_line() + geom_point() + scale_x_continuous(breaks=yearly_vehicle_sum$year) + ylab("PM2.5 Level") + xlab("Year") + ggtitle("Baltimore Vehicle PM2.5 Emissions")

dev.off()