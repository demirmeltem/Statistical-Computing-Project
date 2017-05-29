library(ggplot2)

# Firstly, I read the airAccs.csv
air.crash <- read.csv("/home/demirmeltem/Desktop/statictical-rapor1/airAccs.csv")

# ---------------------------------------------------------------------------------------------
# To show the first six row, I use this command
head(air.crash)

# ---------------------------------------------------------------------------------------------
# I changed the column names as I understand
colnames(air.crash) <- c("Number" ,"Accident.Date", "Accident.Location", "Aircraft.Operator", "Aircraft.Type", "Number.of.Dead", "Number.Aboard", "Deaths.on.Ground")

# I converted the variables into the correct format (numeric, integer, character, factor, ...) 

air.crash[, 2] <- as.Date(air.crash[,2], format = "%Y-%m-%d")
air.crash[, 3] <- as.character(air.crash[, 3])
air.crash[, 4] <- as.character(air.crash[, 4])
air.crash[, 5] <- as.character(air.crash[, 5])

# I removed the unnecessary rows and columns in air.crash data frame
air.crash <- air.crash[!is.na(air.crash[,2:8]),]

# I created a new data.frame which is air.crash.private. It is according to Operator types. I subset the private operator. 
air.crash.private <- subset(air.crash, air.crash$Aircraft.Operator == "Private")

# I drawn a histogram to show number of deads in private operators.
ggplot(air.crash.private, aes(x=Number.of.Dead)) + geom_histogram()

# I drawn a scatter plot to show number of deads according to years.
ggplot(air.crash, aes(x=Accident.Date, y=Number.of.Dead)) + geom_point()
ggplot(air.crash, aes(x=Accident.Date, y=Number.Aboard)) + geom_point()

# I drawn a scatter plot to show number of deads according to aircraft type
ggplot(air.crash.private, aes(y=Aircraft.Type, x=Number.of.Dead)) + geom_point()
