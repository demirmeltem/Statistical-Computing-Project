p1 <- c(8,10,9,11,8,7,9,10,9,9)
p2 <- c(5,7,5,6,7,5,4,6,5,6)

# a.Write down a hypothesis test if caffeine consumption affects sleep hours.
# H0 = O a esitlik durumu
# HA = 0 dan farkli olma durumu

# b.Write down a hypothesis test if caffeine consumption affects sleep hours negatively.
# d = before - after degerdi pozitif oldugu için greater a baktik
# H0 = farkin 0 a küçük esit olmasi (mü <= 0)
# HA = farkin 0 dan büyük olmasi


#independent two sample test 
# c. Test your hypothesis. (??=0.05)
t.test(p1,p2,alternative = "greater", paired = TRUE)
#  p-value = 6.797e-06 < alpha=0.05 HO reject,HA = farkin 0 dan büyük olmasi, YANI KAFEIN TÜKETIMI UYKU SÜRESINI NEGATIF OLARAK ETKILIYOR 



# d.Test your hypothesis for 99% confidence level.

t.test(p1,p2,alternative = "greater", paired = TRUE,conf.level = 0.99)
#  p-value = 6.797e-06 < alpha=0.01 reject 



# e. Find the confidence intervals of mean sleep hours for these two weeks and compare them.
(??=0.05)

t.test(p1)  # 8.173977 9.826023
t.test(p2)  # 4.9089 6.2911
# güven araliklari kesismiyo,farkli gruplar, güven araligi düsmüs demekki etki ediyo



########################################################################


# a. Write down a hypothesis testing if caffeine consumption affects sleep hours.
# kahve içen grup - kahve içmeyen grup olarak 2 bagimsiz grup var
# H0 = m1=m2 a esitlik durumu
# HA = m1=!m2 dan farkli olma durumu
var.test(p1,p2)   # p-value = 0.6037 > alpha=0.05 ho not reject, variance lar esit
t.test(p1,p2, var.equal = TRUE,alternative = "greater")  #p-value = 5.934e-07 < alpha=0.05 Ho rejected,kafein etkili

# b. Write down a hypothesis testing if caffeine consumption affects sleep hours negatively.
# H0 =  küçük esit olmasi (m1 <= m2)
# HA =  büyük olmasi(m1 > m2)




# e. Find the confidence intervals of mean difference between these two groups and evaluate it.
(??=0.05)

t.test(p1,p2, var.equal = TRUE,alternative = "two.sided")   # confidence interval:2.399761 4.400239  uyku bu aralikta azaliyor

################################################################################3

p3 <- c(6,7,5,5,7,5,3,6,6,6)

#??? anova
data1 <- c(p1,p2,p3)
group <- c(rep(1,10),rep(2,10),rep(3,10))
# data <- data.frame(data,group)

results <- aov(data1~as.factor(group))
results


# a. Complete the following ANOVA output and evaluate if these groups have equal means or not.(??=0.05)
summary(results) # tabloyu doldur

# a. Complete the following TukeyHSD output and compare the groups. (??=0.05)
TukeyHSD(results)




###################################################################################
# regression

x <- runif(100, 0, 10)
y <- 2 + 3*x + rnorm(100)


# a. Complete the following correlation output and evaluate the relationship and the significance of the correlation coefficient.
cor.test(x,y)  #cor=0.9931288(güçlü pozitif iliski) , t = 84.011, df = 98, p-value < 2.2e-16 (<alpha) , 0.9897870 - 0.9953797

# b. Complete the following regression output and evaluate the significance of the coefficients.
model <- lm(y~x)  
summary(model)


# c. Write down the regression model.
# y=b0+b1x  bo=intersept, b1=xslope 



###############################################################################






