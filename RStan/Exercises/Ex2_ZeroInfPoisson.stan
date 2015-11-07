data {
  int<lower = 0> N;
  int<lower = 0> Y[N];
}
parameters {
  real<lower = 0, upper = 1> theta;
  real<lower = 0> lambda;
}
model {
  theta ~ beta(1, 1);
  lambda ~ uniform(3, 9);
  
  for (n in 1:N) { // log_sum_exp(a, b) = log(exp(a) + exp(b))
    if (Y[n] == 0) 
      increment_log_prob(log_sum_exp(bernoulli_log(1, theta),
                                     bernoulli_log(0, theta)
                                     + poisson_log(Y[n], lambda) ));
    else
      increment_log_prob(bernoulli_log(0, theta)
                         + poisson_log(Y[n], lambda) );
  }
}

// more info on log_sum_exp() - page 333