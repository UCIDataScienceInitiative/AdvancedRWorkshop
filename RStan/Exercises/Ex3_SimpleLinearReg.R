# Exercise 3:
setwd("/Users/sepehrakhavan/Documents/Statistics/Stat Courses/DataScience_Dr.PadhraicSmyth/Advanced R/AdvancedRWorkshop/RStan/Exercises")
library(rstan)

set.seed(1245)
N <- 50
beta0 <- -1
beta1 <- 1.5
sigma <- 0.3
x <- rnorm(N, mean = 5, sd = 2)
y <- rnorm(N, mean = beta0 + beta1*x, sd = sigma)
data <- list(y = y, x = x, N = N)

# Freq. Linear Reg:
fitFreq <- lm(y ~ x)
fitFreq
summary(fitFreq)$sigma


# Bayesian:
fitBayes <- stan(file = "Ex3_SimpleLinearReg.stan", data = data, iter = 1000, warmup = 200,
           chains = 4)

# traceplot:
print(fitBayes)
plot(fitBayes)
rstan::traceplot(fitBayes)
