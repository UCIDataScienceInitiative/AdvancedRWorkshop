---
title       : RStan
subtitle    : UCI Data Science Initiative
author      : Sepehr Akhavan
job         : Dept. of Statistics
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : mathjax            # {mathjax, quiz, bootstrap}
logo     : logo.png
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
github:
  user: UCIDataScienceInitiative
  repo: AdvancedRWorkshop
---

## Agenda


+ Brief introduction to Bayesian Analysis
+ Available software for Bayesian Analysis
+ Bayesian Analysis using RStan
+ Examples

---

## Bayesian Analysis

Baye's Theorem:

$$ P(\theta|Y) = \frac{P(Y | \theta) P(\theta)}{P(Y)}$$

Where:
+ $\theta$ : unknown parameter(s)
+ $Y$ : observed data

We can write the formula above as:
$$ P(\theta|Y) \propto P(Y | \theta) P(\theta) = P(\theta, Y)$$

__Goal__ : To characterize the posterior distribution $P(\theta|Y)$

---

## Bayesian Analysis

Posterior distribution $P(\theta|Y)$ :
  + 1) may have a closed form (ex. conjugate prior)
  + 2) USUALLY doesn't have a closed form and is not analytically tractable! 
  
if (2), How to generate samples from $P(\theta|Y)$ ?

  + solution 1) MCMC: a class of algorithms for sampling from a probability distribution based on constructing a Markov chain that has the desired distribution as its equilibrium distribution. 
    + ref:[An Introduction to MCMC for Machine Learning](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.13.7133&rep=rep1&type=pdf)
  
  + solution 2) Variational Bayes: Approximate the posterior with a simpler distribution.

---

## Bayesian Analysis

Some examples of MCMC methods:

  + Metropolis–Hastings algorithm
  + Gibbs sampling
  + Slice sampling
  + Reversible-jump
  + Hamiltonian Monte Carlo
    + [MCMC Using Hamiltonian Dynamics] (http://www.mcmchandbook.net/HandbookChapter5.pdf)

---

## Some Bayesian Analysis Packages:

1) WinBUGS/OpenBUGS:
  + http://www.mrc-bsu.cam.ac.uk/software/bugs/


2) JAGS:
  + http://mcmc-jags.sourceforge.net


3) Stan:
  + http://mc-stan.org

---

## What is Stan?

+ "a modeling language in which statisticians could write their models in familiar notation that could be transformed to efficient C++ code and then compiled into an efficient executable program."

+ Stan uses HMC method for sampling as opposed to Gibbs sampling.

+ Stan automatically adapt the number of steps during HMC sampling using No-U-Turn (NUTS) sampler:
  + ref: Hoffman and Gelman, 2011, 2014

+ Stan's interfaces include: RStan, PyStan, CmdStan, ...

+ to install stan, please check:
  + https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started

---

## Where to get help?

1) Stan User's Guide & Reference Manual:
  + Current version: 2.8.0
  + You can access it [here] (https://github.com/stan-dev/stan/releases/download/v2.8.0/stan-reference-2.8.0.pdf)

2)  Stan User's group:
  + https://groups.google.com/forum/#!forum/stan-users

---

## Simple Posterior Example

+ Consider an example of flipping a coin N times where $P(head) = \theta$:
$$P(Y | \theta) \propto \theta^Y (1 - \theta)^{(N - Y)}$$

+ Now, suppose $\theta$ (probability of head) is unknown. We can assume a prior of the form:
$$\theta \sim Beta(\alpha, \beta)$$

+ Under this setting, posterior of $\theta$ would be of the form:
$$P(\theta|Y) \propto P(Y | \theta) P(\theta)$$

+ It's then easy to show:
$$P(\theta|Y) \propto \theta^{(\alpha + Y - 1)} (1 - \theta)^{(\beta + (N - Y) - 1)}$$
$$P(\theta|Y) \propto Beta\big(\alpha + Y, \beta + (N - Y) \big)$$

---

## Simple Posterior Example

+ Life is easy when posterior distribution is tractable :)


```r
N <- 200
theta.true <- 0.4
Y <- rbinom(1, size=N, prob = 0.4)
alpha <- 2
beta <- 2

PostSample <- rbeta(10000, shape1 = alpha + Y,  shape2 = beta + (N - Y))

# Posterior Mean:
mean(PostSample)
```

```
## [1] 0.3778661
```

```r
# 95% CR:
quantile(PostSample, probs = c(0.025, 0.975))
```

```
##      2.5%     97.5% 
## 0.3131006 0.4442364
```

---

## Simple Posterior Example in Stan

There are 3 steps needed to implement this model in Stan:

1) Writing the model in Stan

2) Initializing the data for the model

3) Running the model

---

## Simple Posterior Example in Stan (Stan Model)


```r
data {
  int<lower = 1> N;
  int<lower = 0, upper = N> Y;
  real<lower = 0> alpha;
  real<lower = 0> beta;
}
parameters {
  real<lower = 0, upper = 1> theta;
}
model {
  theta ~ beta(alpha, beta);
  Y ~ binomial(N, theta);
}
```

+ Good practice to save your stan model as a .txt or .stan into a file.

---

## Simple Posterior Example in Stan


```r
# We already have N, Y,alpha, and beta
data = list(N = N, Y = Y, alpha = alpha, beta = beta)
fit <- stan("SimpleCoinEx.stan", data = data, chains = 1, iter = 1000, warmup = 200)
summary(fit)
```


---

## Bayesian Modeling with Stan (R section)

+ stan(): does all of the work of fitting a Stan model and returning the results. It includes:
  + 1) translating the Stan model to C++ code
  + 2) Then, the C++ code is compiled into a binary shared object, which is loaded into the current R session 
  + 3) Finally, samples are drawn and wrapped in an object
  
  
+ stan(): can also be used to sample again from a fitted model under different settings (e.g., different iter).
  + To do so, fit argument should be provided


---

## Bayesian Modeling with Stan (R section)

Useful functions to try on an stan fit:

  + summary()
  
  + print()
  
  + traceplot()
  
  + extract()
  
  + launch_shinystan{shinystan}


---

## Bayesian Modeling with Stan (Stan Model)

The rest of the workshop will be on details of writing stan models. In particular, we will learn more on:

+ Stan's Program Blocks

+ Data Types, Variable Declaration, and Statements

+ Operators & Built-In Functions:

+ User-Defined Functions

+ Reparameterization and Change of Variables

+ Truncated Data

+ Censored Data

+ Examples 

---

## Stan's Program Blocks 


```r
functions{
}
data {
}
transformed data {
}
parameters {
}
transformed parameters {
}
model {
}
generated quantities{ 
}
```

---

### function block:

+ This optional block contains user-defined functions (if there is any)

+ more on this later

---

### data Block

+ All variables that are read in as data are declared here

+ Data are read only once!

+ The data block does not allow statements

+ Input data should jibe with the declared data in this block:
  + within the same range
  + having the same size


---

### transformed data Block

+ Defining variables that are fixed when running the program

+ No reading from external sources

+ Variables defined earlier in the data block may be used here


---

### parameters Block

+ Variables defined in this block are sampled

+ Variables defined as parameters cannot be directly assigned


---

### transformed parameters Block

+ There is no need to perform a direct sampling for variables declared under this block

+ Variables that are defined in terms of data or transformed data only (fixed) should be defined in the transformed data block. Those variables are illegal under this block

+ Variables defined here will be written as part of the output

---

### model Block

+ likelihood (the model/distribution the data come from) is defined under this block

+ priors on the parameters are also defined in this block

---

### generated quantities Block

+ This block is executed only after a sample has been generated

+ Therefore, nothing in the generated quantities block affects the sampled parameter values

+ Some applications of this block are:
  
  + to calculate posterior expectations
  
  + transforming parameters for reporting
  
  + generating predictions for new data

---

## Data Types and Variable Declarations:

+ Variables should have a declared data type. Stan's data types include:

+ 1) Primitive Data Types:
  + 1.1) real
  + 1.2) int
  + 1.3) constrained by using lower or upper
  
+ 2) Compound Data Types:
  + 2.1) vector (of real values)
  + 2.2) row_vector (of real values)
  + 2.3) matrix (of real values)
  + 2.4) constrained include: simplex, unit_vector, ordered, positive_ordered, corr_matrix, cov_matrix, cholesky_factor_cov, cholesky_factor_cor



--- 

## Data Types and Variable Declarations:

+ 3) Arrays:
  + 3.1) three-dimensional arrays of integers
  + 3.2) four-dimensional arrays of row_vectors


---

## Data Types and Variable Declarations:


```r
# primitive:
int<lower = 1> N;
real<lower = 0, upper = 1> theta;

# vector:
vector[3] myVec;
vector<lower = 0>[3] myConsVec;
simplex[5] theta;

# matrix:
matrix[3,3] A;
corr_matrix[3] Sigma;
cholesky_factor_corr[5] L;

# array:
int n[5]; // n is an array of 5 integers
real a[3,4];
vector[7] mu[3]; // 3-dimensional array of vectors of length 7
```


---

## Statements:

+ Assignment Statements

+ Sampling Statement

+ Log Probability Increment Statement

+ For Loops

+ Conditional Statements

+ Print

---

### Assignment Statements:

```r
n <- 1;
Sigma[1,1] <- 1;
```

### Sampling Statements:

```r
y ~ normal(mu, sigma);
```

### Log Probability Increment Statement:
The statement above is equivalent to:

```r
increment_log_prob(normal_log(y, mu, sigma))
```

---

### For Loops:

+ Suppose N is an integer and y is a an array of real values of length N:


```r
for (n in 1:N){
  y[n] ~ normal(mu, sigma);
}
```

+ alternatively, we can use vectorized operations in stan and write:

```r
y ~ normal(mu, sigma)
```

---

### Conditional Statements:

+ Stan supports if-then-else syntax as in C++:


```r
if (condition1)
  statement1
else if (condition2)
  statement2
//...
else if (conditionN)
  statementN
else
  elseStatement
```

---

### Print:

+ Stan does not have a stepwise debugger

+ Instead, we can use the traditional debug-by-printt method !

+ For instance, to print the value of variables y and z, use:

```r
print("y=", y, " z=", z);
```

+ Print statements may be used anywhere other statements may be used

+ frequency depends on how often the block they are in is evaluated

---

### Print:


```r
transformed data {
  matrix[2,2] u;
  u[1,1] <- 1.0;  u[1,2] <- 4.0;
  u[2,1] <- 9.0;  u[2,2] <- 16.0;
  for (n in 1:2)
    print("u[", n, "] = ", u[n]);
}
```


---

## Operators:

+ Logical Operators:
    + ||, &&, ==, !=, <, <=, >, >=
    
+ Arithmatic Operators:
    + .*, ./: element-wise matrix operators
    + ': to get transpose of a matrix
    + For a complete list of operators, please visit the User's manual
        + Page 306 - User's Manual 2.8.0 !

---

## Built-In Functions:

+ Stan includes many built-in functions. Some examples are:

  + determinant(): determinant of a matrix
  + inverse(): inverse of a matrix
  + inverse_spd(): The inverse of A where A is symmetric, positive definite.
  + eigenvalues_sym(): returns the vector of eigenvalues of a symmetric matrix A in ascending order
  
  + For more info, please read "Built-in Functions" in the User's Manual 2.8.0.

---

## User-Defined Functions:

+ Stan allows users to define their own functions

+ User defined functions appear in the function block and before all other blocks

+ function definition has C++ style where the type of the output as well as arguments should be explicitely mentioned:


```r
real myFunc(real arg1, real arg2){
  // ... statements
}
```

+ functions with no output have type "void":

```r
void myFunc(real arg1, real arg2){
  // ... statements
}
```

+ You can learn more about functions in section 26.1 (page 282) of the [user manual] (https://github.com/stan-dev/stan/releases/download/v2.8.0/stan-reference-2.8.0.pdf)

---

## Reparameterization and Change of Variables:

+ Stan supports a direct encoding of reparameterizations.

+ Stan also supports changes of variables. To do so:
  + We should directly increment the log probability accumulator with the log Jacobian of the transform
  
+ Why we care about reparameterization?
  + different parameterizations sometime have different computational performances
  

---

### Reparameterization:

+ This can be best understood with an example below (Stan user's manual):

+ Conisder Beta distribution with two different parameterizations:
  + 1) $Beta(\alpha, \beta)$: $\alpha$ and $\beta$ are shape parameters
  + 2) $Beta(\phi, \lambda)$: 
      + 2.1) $\phi = \alpha/(\alpha + \beta)$ (mean)
      + 2.2) $\lambda = \alpha + \beta$

+ Under this section, we specify y's (data) from the same $Beta(\alpha, \beta)$ under both reparameterization (no need for Jacobian!). 

+ However, in (1), we directly sample $\alpha$ and $\beta$, where in (2), we first sample $\phi$ and $\lambda$ and we compute $\alpha$ and $\beta$ accordingly
  

---

### Reparameterization (1st Parameterization):


```r
data {
  vector<lower = 0, upper = 1>[N] theta;
}
parameters {
  real<lower = 0> alpha;
  real<lower = 0> beta;
  ...
}
model {
  alpha ~ ... ; // our prior for alpha
  beta ~ ... ; // our prior for beta
  theta ~ beta(alpha, beta); 
}
```
  

---

### Reparameterization (2nd Parameterization):


```r
parameters {
  real <lower = 0, upper = 1> phi;
  real <lower = 0> lambda;
  ...
}
transformed parameters{
  real<lower = 0> alpha;
  real<lower = 0> beta;
  alpha <- lambda*phi;
  beta <- lambda*(1 - phi);
}
model {
  phi ~ ... ; // prior for phi
  lambda ~ ...; // prior for lambda
  y ~ beta(alpha, beta); // transformed param used. No Jacobian Needed!
}
```
  

---

### Change of Variables:

+ Consider the distribution of variable $\theta > 0$ where it's log is normally distributed:

$$log(\theta) \sim N(\mu, \sigma)$$

+ Then we know $\theta$ is distributed as:
$$P(\theta) = N(log(\theta) | \mu, \sigma) \times |\frac{d}{d\theta} log(\theta)|$$
$$P(\theta) = N(log(\theta) | \mu, \sigma) 1/\theta$$

+ Stan works with log probability, so:
$$log(P(\theta)) = log \big(Normal(log(\theta) | \mu, \sigma)\big) - log(\theta)$$

+ so we need to incremenet the likelihood by:
  + log absolute derivative (ex. $log (|\frac{d}{d\theta} log(\theta)|)$)

---

### Change of Variables:

+ We can then easily implement the model as:


```r
parameters {
  real<lower = 0> theta;
}
model{
  log(theta) ~ normal(mu, sigma);
  increment_log_prob(-log(theta));
  ...
}
```

---

### The distinction between Reparam. vs. Change of Var?

+ Reparam.: We first sample a parameter and then we transform it.

+ Change of Var: We first transform a variable, and then we sample it!

+ only the latter needs Jacobian!

---

## Truncated Data:

+ Trucated data: measurements are only reported if they fall with a boundary

+ Truncation in Stan is restricted to:
    + univariate distributions
    + with available log cumulative distribution

+ To understand truncation better, you can consider a detector which only is activated if the signals it detects are above a certain limit. 

+ There may be lots of weak incoming signals, but we can never tell using this detector.

---

## Truncated Data:


```r
data {
  int<lower=0> N;
  real U;
  real<upper=U> y[N];
}
parameters {
  real mu;
  real<lower=0> sigma;
}
model {
  for (n in 1:N)
    y[n] ~ normal(mu,sigma) T[,U];
}
```


---

## Censored Data:

  + Under censoring, some observations may be censored, meaning that we only know that they are below (or above) some bound but we don't know their actual values.
  
  + Unlike with truncated data, the number of data points that were censored is known.
  
  + It's wrong to ignore censored data!
  
  + One way to model censored data is to treat the censored data as missing data that is constrained to fall in the censored range of values. 

  + Note that Stan does not allow unknown values in its arrays or matrices
  
  + So we can treat censored data as unknown parameters!
  
  + In that case, censored data will be sampled like other parameters

---

## Censored Data:


```r
data {
  int<lower=0> N_obs;
  int<lower=0> N_cens;
  real y_obs[N_obs];
  real<lower=max(y_obs)> U;
}
parameters {
  real<lower=U> y_cens[N_cens];
  real mu;
  real<lower=0> sigma;
} 
model {
  y_obs ~ normal(mu,sigma);
  y_cens ~ normal(mu,sigma);
}
```


---

## Censored Data - Likelihood Approach:

  + it is not necessary to impute values.
  
  + Instead, the values can be integrated out:

  + Each censored data point has a probability of:
$$Pr[Y > U] = \int_{U}^{\infty} P(Y| ...) dY = 1 - cdf(U)$$

  + the complementary CDF above in Stan is of the form:
    + distName_ccdf_log


---

## Censored Data - Likelihood Approach:


```r
data {
  int<lower=0> N_obs;
  int<lower=0> N_cens;
  real y_obs[N_obs];
  real<lower=max(y_obs)> U;
}
parameters {
  real mu;
  real<lower=0> sigma;
}
model {
  y_obs ~ normal(mu,sigma);
  increment_log_prob(N_cens * normal_ccdf_log(U,mu,sigma));
}
```


---

## Exercise1 - Revisiting the Coin Flip example:

### Borrowed from Daniel Lee (@djsyclik)


```r
data {
  int N;
  int Y[N];
}
parameters {
  real<lower=0, upper=1> theta;
} 
model {
  Y ~ bernoulli(theta);
}
```


---

## Exercise1 - Revisiting the Coin Flip example:

+ Alternatively, we can specify the model using the log likelihood approach:


```r
...
model {
  for (n in 1:N) 
    increment_log_prob(bernoulli_log(Y[n], theta));
}
```

+ Instead of using bernoulli_log() function in Stan, you can explicitely specify the log likelihood as:

```r
...
model {
  for (n in 1:N) 
    increment_log_prob(log(if_else(y[n] == 1, theta, 1-theta)));
}
```


---

## Exercise1 - Revisiting the Coin Flip example:

  + Finally, you can use vectorized operations so you can get rid of loops:

```r
...
model {
  increment_log_prob(bernoulli_log(Y, theta));
}
```

---

## Exercise2 - Zero-Inflated Poisson
  + source: User's Manual - Page 108
  
  + Consider a zero-inflated poisson distribution where:
    + with probability $\theta$, we draw a zero
    + with probability $1 - \theta$, we draw from $Poisson(\lambda)$
    + this means:
    $$p(y_n | \theta, \lambda) = \begin{cases}
\theta + (1 - \theta) \times Poisson(0|\lambda) & \text{if }y_n = 0\\
(1 - \theta) \times Poisson(y_n|\lambda) & \text{if }y_n \ne 0\\
\end{cases}$$

    + How to implement this in stan?
    

---

## Exercise2 - Zero-Inflated Poisson (Solution)    

```r
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
  lambda ~ cauchy(0, 5);
  
  for (n in 1:N) {
    if (Y[n] == 0)
      increment_log_prob(log_sum_exp(bernoulli_log(1, theta),
                                     bernoulli_log(0, theta)
                                     + poisson_log(Y[n], lambda) ));
    else
      increment_log_prob(bernoulli_log(0, theta)
                         + poisson_log(Y[n], lambda) );
  }
}
```

---

## Exercise3: Simple Linear Regression

+ Consider a model of the form:
$$y_i = \alpha + \beta x_i + \epsilon_i$$

+ step 1) simulate some data for the model above

+ step 2) fit a linear regression in R (frequentist model)

+ step 3) fit a Bayesian linear regression using Stan

---

## Exercise4: Finite Mixtures

+ Suppose Y belongs to a finite mixture of distributions.

+ This means eahc outcome $Y_i$ is drawn from one those distributions

+ In paticular, suppose Y belongs to a mixture of K normal distributions. 

+ Consider $\theta$ as a K-simplex. 

+ Per each $Y_i$, there is a corresponding latent variable $z_i \in \{ 1, 2, \dots, K\}$

+ We can then write:
$$Z_i \sim Categorical(\theta)$$
$$y_i \sim Normal(\mu_{z_i}, \sigma)$$


---

## Exercise4: Finite Mixtures

+ By summing over the latent $Z_i$'s, we get:
$$P_Y(y | \theta, \mu, \sigma) = \sum_{k = 1}^{K} \theta_k Normal(\mu_k, \sigma)$$

+ Consider a mixutre of two Normal distributions: N(-2.5, 1), N(2.5, 1)

+ Consider mixing proportion as: $\theta = (0.4, 0.6)$

+ For this problem:
    + step1) simulate data

    + step2) run a Bayesian model using stan



