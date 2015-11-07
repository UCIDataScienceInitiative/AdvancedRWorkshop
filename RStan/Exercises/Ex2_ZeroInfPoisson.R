# Exercise 2:
setwd("/Users/sepehrakhavan/Documents/Statistics/Stat Courses/DataScience_Dr.PadhraicSmyth/Advanced R/AdvancedRWorkshop/RStan/Exercises")
library(rstan)

set.seed(1245)
N <- 50
theta.true <- 0.4
lambda <- 6
Y <- NULL

for (i in 1:N){
  if (runif(1) < 0.4)
    Y <- c(Y, 0)
  else
    Y <- c(Y, rpois(1, lambda = lambda))
}

data <- list(N = N, Y = Y)

fit <- stan(file = "Ex2_ZeroInfPoisson.stan", data = data, iter = 1000, warmup = 200,
           chains = 4)

# traceplot:
print(fit)
plot(fit)
rstan::traceplot(fit)
