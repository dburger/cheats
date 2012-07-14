# how to find and install a package, first search for what you are
# looking for on rseek.org - (here looking for skew and kurtosis)
# then install:
> intsall.packages("moments")
# then you can load and use the library
> load("moments")
> skewness(c(1, 2, 3, 4, 5))
[1] 0
> kurtosis(c(1, 2, 3, 4, 5))
[1] 1.7

# entering a frequency distribution, say you have:
# value || count
#     0 ||     2
#     1 ||     5
#     2 ||     9
#     3 ||     4
#     4 ||     1
# can put in a vector with:
> v <- c(rep(0,2), rep(1,5), rep(2,9), rep(3,4), rep(4,1))
# or
> v <- rep(c(0,1,2,3,4), c(2,5,9,4,1))

# but say you have the data in a file, ways to roll values
# with dice for example dice.txt:
2 1
3 2
4 3
5 4
6 5
7 6
8 5
9 4
10 3
11 2
12 1
# read the data and make the vector of values
> data <- read.table("dice.txt")
> v <- rep(data$V1, data$V2)
> sd(v)
[1] 2.449490

# say you have the data in some kind of separated values file
1,2,3,4
4,3,2,1
9,9,9,9
# read the data, no header, comma separator
> data <- read.csv(file="xamp.csv",head=FALSE,sep=",")
> data
  V1 V2 V3 V4
1  1  2  3  4
2  4  3  2  1
3  9  9  9  9
# and then address a specific column
> mean(data$V1)
[1] 4.666667

# and of course if the data has headers
height,weight,speed,distance
1,2,3,4
4,3,2,1
9,9,9,9
# then when you read you can use those as column identifiers
> data <- read.csv(file="xamp.csv",head=TRUE,sep=",")
> data
  height weight speed distance
1      1      2     3        4
2      4      3     2        1
3      9      9     9        9
> data$height
[1] 1 4 9

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

# birthday paradox function in three versions, from worst to
# best, with R's built in birthday functions demoed below.

# birthday paradox function, full, does not handle large values
# (won't handle 365 days for example)
birthday <- function(n, r) {
  return (1 - factorial(n) / (factorial(n - r) * n^r));
}

# birthday paradox function, simplified, but still can't handle
# really large values
birthday <- function(n, r) {
  return (1 - prod((n - r + 1):n) / n^r);
}

# birthday paradox function, move the calculation of n^r into the
# prod, this should handle much larger numbers
birthday <- function(n, r) {
  return (1 - prod(((n - r + 1):n) / n));
}

# note that R's birthday functions use approximations

# using built in, what is probablity of 2 or more conflicts for
# birthdays with 23 people
> pbirthday(23)
[1] 0.5009262

# more complex usage, if there are 100 different classes and you
# want to know the the likelihood of 5 or more collisions when
# selecting 30
> pbirthday(30, classes=100, coincident=5)
[1] 0.001577866

# how many people does there need to be to have a 70 percent
# chance of a birthday collision?
> qbirthday(prob=.7)
[1] 31

# more complex usage, how many selections does there need to be
# to have a 12 percent change of 3 or more collisions from a
# selection out of 100 classes?
> qbirthday(prob=.12, classes=100, coincident=3)
[1] 21

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

# covariance and correlation coefficent
> x <- c(1, 2, 3, 4, 5, 6)
> y <- 2 * x
> y
[1]  2  4  6  8 10 12
> cov(x, y)
[1] 7
> cor(x, y)
[1] 1
> y <- x^2
> y
[1]  1  4  9 16 25 36
> cov(x, y)
[1] 24.5
> cor(x, y)
[1] 0.9789173

# compute an empirical cumulative distribution function
> ecdf(c(1, 2, 3, 4))
# compute an ecdf from 20 random samples from a normal distribution
> ecdf(rnorm(20))
# plot the ecdf of 1000 random samples from a normal distribution
> plot(ecdf(rnorm(1000)))

# from two minute tutorials
$ option(digits = 22)
$ x <- c(1, 2, 3)
$ 10:20
$ length(v)
$ class(v)
$ is.numeric(x)
$ v[2]
$ y <- v[4:8]
$ df <- data.frame(
    names = c("x", "y", "z"),
    parties = c(1, 2, 3))
$ v[2,]
$ v[1:2,]
$ install.packages("name")
$ library(name)
$ ?func
$ seq(from = 0, to = 10, by = 2)
$ df <- read.csv("...")
$ getwd()
$ setwd("...")
$ head(df)
$ tail(df)
$ T, F
$ !
$ if, else
$ for (i in 1:3)
$ gsub, paste(sep = " ")
$ as.character(x)
$ as.numeric(x)
$ as.logical(x)
r-help, r-bloggers web sites
$ data(mtcars)
$ mtcars[,"cyl"]
$ mtcars[(mtcars[,"cyl"] == 6),]
$ ifelse(x, "true", "false")
$ mtcars[,"newcol"] <- ifelse (conditional, true, false)
$ paste("hi", v)
$ paste("hi", v, collapse = "")
$ paste("hi", "there", sep = ":")
$ outer(v1, v2, FUN = f, sep = ":")
$ mean, median, mode, quantile
$ summary
$ quantile(v, prob = .9)
$ quantile(v, type = 3)
$ sum
$ try(x, silent = T)
$ try({...}, silent = T)
$ e <- try(...
$ if (class(e) == "try-error")
$ table(mtcars$cyl)
$ ftable(...)
$ fix(mtcars)
$ mtcars <- transform(mtcars, newcol = 2 * oldcol)
$ sort(u), sort(u, decreasing = T)
$ mtcars[order(mtcars$wt),]
$ x <- sqldf("select ...")
$ merge(df1, df2, by = "column")
right and left join by all parameter
$ cbind = join tables
$ rbind = stacks tables
$ tapply(mtcars$mpg, mtcars$gear, mean) # groups by 2nd
$ tapply(mtcars$hp, mtcars$cyl, quantile, prob = .8)
$ aggregate(mtcars$mpg, by = list(mtcars$gear), mean)
$ na.rm = T
$ is.na(x)
$ z[is.na(z$rc), "rc"] <- 0
$ %in%, ?"%in%"
$ names(mtcars)
$ names(mtcars)[1] <- "dog"
$ rownames(mtcars)
$ write.csv(x, "names.csv")
$ round(u)
$ round(u, 2), round(u, digits = 2)
$ floor, ceiling, excel_round
$ plot(v1, v2, xlim = c(0, 10), ylim = c(0, 10),
    xlab = "label", ylab = "label", main = "main")
$ lines(xc, yc)
$ lines(xc, yc, col = "red")
$ lines(xc, yc, col = "red", lwd = 2)
$ points(xc, yc, pch = 17, col = "blue")
$ source(script)
$ read.csv("...")$elgibles
$ z[(z$rum == 3),]
$ z[(z$rum %in% 3),] # handles NA
$ z[!(z$run %in% 3),]
$ transform(df, col = ...)
$ df[test, newcol] <- something
$ ls(), rm(mtcars)
ways to address data frames
[,]
[,c("one", "two")]
[,c(1, 10, 11)]
[,c(-1, -2)]
[,!(names(mtcars) %in% DropCols]
$ rownames(df)
$ nchar(v)
$ for (in in 1:nrow(mtcars))
$ merge(p, q, all = T)
              all = F
              all.x = T
              all.y = T
$ boxplot(mtcars$mpg)
$ boxplot(mpg ~ cyl, data = mtcars)
$ hist(mtcars$mpg)
$ barplot(mtcars$mpg)
$ pie(x, c(0, 5, 10, 15), c("lab1", "lab2", ...))
$ sample(v, 5)
$ sample(v, 5, replace = T)
$ sample(v, 5, prob = c(.8, .1, .1))
$ subset(mtcars, hp > 100)
$ mtcars[mtcars$hp > 100,]
$ subset(v, hp > 100, select = keepcols)
cannot assign into subset
$ grep("hi", CharVector)
$ grep1("hi", CharVector)
$ sub(pattern = "hi", replacement = "hello", x)
$ gsub
$ str_trim(x)
$ str_trim(x, side = "left")
