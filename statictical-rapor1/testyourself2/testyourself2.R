library(BSDA)
first_week <- c(8, 10, 9, 11, 8, 7, 9, 10, 9, 9)
second_week <- c(5, 7, 5, 6, 7, 5, 4, 6, 5, 6)

#answer for 1, c
mean(first_week)
mean(second_week)

shapiro.test(first_week)
shapiro.test(second_week)

t.test(firstWeek, secondWeek, alternative = "greater", paired = TRUE)

#answer for 1, d
t.test(first_week, second_week, alternative = "greater", paired = TRUE, conf.level = 0.99)

#answer for 1, e

t.test(first_week)
t.test(second_week)


#answer for 2, a