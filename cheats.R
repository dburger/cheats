# definiting a simple function
combinations <- function(n, r) {
  return (factorial(n) / (factorial(r) * factorial(n - r)));
}

# and you can't show combinations without permutations
permutations <- function(n, r) {
  return (factorial(n) / factorial(n - r));
}

# probability distributions have a unique name with a prefix indicating
# (d) density
# (p) distribution
# (q) quantile
# (r) random

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
