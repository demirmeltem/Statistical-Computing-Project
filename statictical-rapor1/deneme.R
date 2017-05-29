büyük <- subset(air.crash, Accident.Year>2000, select = c(Number.of.Dead, Accident.Year))
büyük <- aggregate(data = büyük, Number.of.Dead ~ Accident.Year, FUN=sum)

kücük <- subset(air.crash, Accident.Year<2000, select = c(Number.of.Dead, Accident.Year))
kücük <- aggregate(data = kücük, Number.of.Dead ~ Accident.Year, FUN=sum)
kücük <- tail(kücük, 9)
