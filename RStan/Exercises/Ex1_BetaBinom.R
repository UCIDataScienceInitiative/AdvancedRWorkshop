# Exercise 1:
setwd("/Users/sepehrakhavan/Documents/Statistics/Stat Courses/DataScience_Dr.PadhraicSmyth/Advanced R/AdvancedRWorkshop/RStan/Exercises")
library(rstan)

N <- 30
Y <- rbinom(N, size = 1, p = 0.4)
data <- list(N = N, Y = Y)

fit <- stan(file = "Ex1_BetaBinom.stan", data = data, iter = 1000, warmup = 200,
           chains = 4)

# traceplot:
print(fit)
plot(fit)
rstan::traceplot(fit)

# permuted = TRUE: Permuting chains or not !
listOfArrays <- rstan::extract(fit, permuted = TRUE) # return a list of arrays 

theta <- listOfArrays$theta


#--------------------------
# Sampling the Prior Only -
#--------------------------
MyPriorOnlyModel = "data {
  int<lower = 0> N;
  int Y[N];
}
parameters {
  real<lower = 0, upper = 1> theta;
}
model {
  theta ~ beta(1, 1);
}"

fitPriorOnly <- stan(model_code = MyPriorOnlyModel, data = data, iter = 1000)

thetaSamples <- rstan::extract(fitPriorOnly)
hist(thetaSamples$theta)
rstan::traceplot(fitPriorOnly)
