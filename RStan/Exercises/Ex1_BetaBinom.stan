data {
    int<lower=0> N ;
    int Y[N] ; 
}
parameters {
 real<lower=0,upper=1> theta ;
}
model {
 theta ~ beta(1,1) ;
 Y ~ bernoulli(theta) ; 
}