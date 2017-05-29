###TESTYOURSELF2

#1.a
firstWeek <- c(8, 10, 9, 11, 8, 7, 9, 10, 9, 9)
secondWeek <- c(5, 7, 5, 6, 7, 5, 4, 6, 5, 6)

t.test(firstWeek, secondWeek, alternative = "greater", paired = TRUE)

#1.d
t.test(firstWeek, secondWeek, alternative = "greater", paired = TRUE, conf.level = 0.99)


#1.e
t.test(firstWeek)
t.test(secondWeek)

#2
notCoffee <- c(8, 10, 9, 11, 8, 7, 9, 10, 9, 9)
coffee <- c(5, 7, 5, 6, 7, 5, 4, 6, 5, 6)

var.test(notCoffee, coffee) #sigma 1 sigma 2 ye e?it mi diye test ettim(ortalama de?il variance a bakt?k)

t.test(notCoffee, coffee, alternative = "greater", var.equal = TRUE) #H0 = reject

t.test(notCoffee, coffee, alternative = "greater", var.equal = TRUE, conf.level = 0.99)

t.test(notCoffee, coffee, alternative = "two.sided", var.equal = TRUE)#kafein t?ketirsek 2.39 la 4.4 aras?nda uyku kayb?na sebep olur

#3
stCoffee <- c(6, 7, 5, 5, 7, 5, 3, 6, 6, 6)
ss
data <- c(notCoffee, coffee, stCoffee) #verileri birle?tirmek i?in
group <- c(rep(1,10), rep(2,10), rep(3,10)) #veri k?melerinin 10 eleman?n? se?mek i?in

result <- aov(data ~ as.factor(group))
summary(result) #Pr(>F) p value'ya e?ittir. at leaast one of the groups is different than others
TukeyHSD(result)

#4
x <- runif(100, 0, 10)
y <- 2 + 3*x + rnorm(100)

cor.test(x,y)

model <- lm(y~x)
summary(model)

#katsay?lar?n sonunda y?ld?z varsa, o katsay?lar modelde bulunmal? demek
