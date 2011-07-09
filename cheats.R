# definiting a simple function
# (of course you don't need to do this, use choose(n, k) built in)
combinations <- function(n, r) {
  return (factorial(n) / (factorial(r) * factorial(n - r)));
}

# and you can't show combinations without permutations
# (I'm not sure what the built in is for this)
permutations <- function(n, r) {
  return (factorial(n) / factorial(n - r));
}

# probability distributions have a unique name with a prefix indicating
# (d) density
# (p) distribution
# (q) quantile
# (r) random

# some of the common distribution functions are
# (binom) binomial distribution
# (pois) poisson distribution
# (norm) normal distribution

# for example the binomial distribution name is binom calculate the probability
# of an 80% free throw shooter hitting 5 out of 10 shots
> dbinom(5, 10, .8)
[1] 0.02642412

# calculate the probability of an 80% free throw shooter making 5 or less of 10
# shots
> pbinom(5, 10, .8)
[1] 0.0327935

# calculate the probability of an 80% free throw shooter making more than 5 of
# 10 shots
> pbinom(5, 10, .8, lower=FALSE)
[1] 0.9672065

# the poisson distribution (pois) calculates distributions for rates,
# for example, if 200 cars pass this intersection per hour, on average, what
# is the probability that 175 or fewer cars pass in an hour
> ppois(190, lambda=200)
[1] 0.2529326

# if a group of students averaged 80.0 on a test with a standard deviation
# of 8, what is the likely percentage of students that scored between 75.0
# and 80.0 if we assume a normal distribution
> pnorm(85, 80, 8) - pnorm(75, 80, 8)
[1] 0.4680289

# and what percentage of students are expected to score below 40.0
> pnorm(40, 80, 8)
[1] 2.866516e-07

# if the mean of heights for a set of boys is 143.5 cm and standard
# deviation of 7.1 cm what is the probability that a randomly chosen
# boy is taller than 157.7 cm if we assume a normal distribution
> 1 - pnorm(157.7, 143.5, 7.1)
[1] 0.02275013

# create a sequence from 1 to 10
# sample 5000 values from the sequence
# separate the samples into 10 rows (500 cols)
# create a vector of the means of each column
# draw a histogram of the means
# show the variance and standard deviation of the means
> v <- seq(1, 10)
> draws <- sample(v, size=10*500, replace=TRUE)
> draws <- matrix(draws, 10)
> means <- apply(draws, 2, mean)
> hist(means)
> var(means)
> sd(means)

# average man drinks 2L of water in day with standard deviation of
# .7L.  If you are planning a trip for 50 men and bringing 110L of
# water, what is the change you will run out?
# Sampling distribution produces a normal distribution for these
# values and the standard deviation
# = population standard deviation / square root # of samples
> samplesd <- .7 / sqrt(50)
> 1 - pnorm(2.2, 2, samplesd)
[1] 0.02167588
