# Exercise 4:
setwd("/Users/sepehrakhavan/Documents/Statistics/Stat Courses/DataScience_Dr.PadhraicSmyth/Advanced R/AdvancedRWorkshop/RStan/Exercises")
library(rstan)

set.seed(1236)
N <- 200
K <- 2
theta.true <- c(0.4, 0.6)
mu.true <- c(-2.5, 2.5)
sigma.true <- 1

# simulating some y:
y <- NULL

for (i in 1:N){
  if (runif(1) < theta.true[1])
    y <- c(y, rnorm(1, mean = mu.true[1], sd = sigma.true))
  else
    y <- c(y, rnorm(1, mean = mu.true[2], sd = sigma.true))
}

data <- list(N = N, K = K, y = y)

# Bayesian:
fitBayes <- stan(file = "Ex4_FiniteMixtureModel.stan", data = data, iter = 10000, warmup = 2000,
           chains = 1)

# traceplot:
print(fitBayes)
plot(fitBayes)
rstan::traceplot(fitBayes)
