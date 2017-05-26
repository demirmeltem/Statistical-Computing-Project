
air.crash <- read.csv("/home/demirmeltem/Desktop/statistical_final_report/airAccs.csv")
head(air.crash)

colnames(air.crash) <- c("Number" ,"Accident.Date", "Accident.Location", "Aircraft.Operator", "Aircraft.Type",
                         "Number.of.Dead", "Number.Aboard", "Deaths.on.Ground")

air.crash[, 2] <- as.Date(air.crash[,2], format = "%Y-%m-%d")
air.crash[, 3] <- as.character(air.crash[, 3])
air.crash[, 4] <- as.character(air.crash[, 4])
air.crash[, 5] <- as.character(air.crash[, 5])

#air.crash <- air.crash[!is.na(air.crash[,2:8]),]

air.crash.private <- subset(air.crash, air.crash$Aircraft.Operator == "Private")

