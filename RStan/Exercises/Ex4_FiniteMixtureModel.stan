data {
  int<lower = 1> K;
  int<lower = 1> N;
  real y[N];
}
parameters {
  simplex[K] theta;
  real mu[K];
  real<lower = 0> sigma;
}
model{
  real ps[K]; // place-holder for log component densities
  sigma ~ uniform(0.5, 1.5);
  mu ~ normal(0, 10);
  for (n in 1:N){
    for (k in 1:K) {
      ps[k] <- log(theta[k]) + normal_log(y[n], mu[k], sigma);
    }
    increment_log_prob(log_sum_exp(ps)); // log_sum_exp(lp1,lp2) = log(exp(lp1) + exp(lp2))
  }
}