> # how to find and install a package, first search for what you are
> # looking for on rseek.org - (here looking for skew and kurtosis)
> # then install:
> intsall.packages("moments")
> # then you can load and use the library
> load("moments")
> skewness(c(1, 2, 3, 4, 5))
[1] 0
> kurtosis(c(1, 2, 3, 4, 5))
[1] 1.7

> # entering a frequency distribution, say you have:
> # value || count
> #     0 ||     2
> #     1 ||     5
> #     2 ||     9
> #     3 ||     4
> #     4 ||     1
> # can put in a vector with:
> v <- c(rep(0,2), rep(1,5), rep(2,9), rep(3,4), rep(4,1))
> # or
> v <- rep(c(0,1,2,3,4), c(2,5,9,4,1))

> # but say you have the data in a file, ways to roll values
> # with dice for example dice.txt:
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
> # read the data and make the vector of values
> data <- read.table("dice.txt")
> v <- rep(data$V1, data$V2)
> sd(v)
[1] 2.449490

> # say you have the data in some kind of separated values file
1,2,3,4
4,3,2,1
9,9,9,9
> # read the data, no header, comma separator
> data <- read.csv(file="xamp.csv",head=FALSE,sep=",")
> data
  V1 V2 V3 V4
1  1  2  3  4
2  4  3  2  1
3  9  9  9  9
> # and then address a specific column
> mean(data$V1)
[1] 4.666667

> # and of course if the data has headers
height,weight,speed,distance
1,2,3,4
4,3,2,1
9,9,9,9
> # then when you read you can use those as column identifiers
> data <- read.csv(file="xamp.csv",head=TRUE,sep=",")
> data
  height weight speed distance
1      1      2     3        4
2      4      3     2        1
3      9      9     9        9
> data$height
[1] 1 4 9

> # definiting a simple function
> # (of course you don't need to do this, use choose(n, k) built in)
combinations <- function(n, r) {
  return (factorial(n) / (factorial(r) * factorial(n - r)));
}

> # and you can't show combinations without permutations
> # (I'm not sure what the built in is for this)
permutations <- function(n, r) {
  return (factorial(n) / factorial(n - r));
}

> # birthday paradox function in three versions, from worst to
> # best, with R's built in birthday functions demoed below.

> # birthday paradox function, full, does not handle large values
> # (won't handle 365 days for example)
birthday <- function(n, r) {
  return (1 - factorial(n) / (factorial(n - r) * n^r));
}

> # birthday paradox function, simplified, but still can't handle
> # really large values
birthday <- function(n, r) {
  return (1 - prod((n - r + 1):n) / n^r);
}

> # birthday paradox function, move the calculation of n^r into the
> # prod, this should handle much larger numbers
birthday <- function(n, r) {
  return (1 - prod(((n - r + 1):n) / n));
}

> # note that R's birthday functions use approximations

> # using built in, what is probablity of 2 or more conflicts for
> # birthdays with 23 people
> pbirthday(23)
[1] 0.5009262

> # more complex usage, if there are 100 different classes and you
> # want to know the the likelihood of 5 or more collisions when
> # selecting 30
> pbirthday(30, classes=100, coincident=5)
[1] 0.001577866

> # how many people does there need to be to have a 70 percent
> # chance of a birthday collision?
> qbirthday(prob=.7)
[1] 31

> # more complex usage, how many selections does there need to be
> # to have a 12 percent change of 3 or more collisions from a
> # selection out of 100 classes?
> qbirthday(prob=.12, classes=100, coincident=3)
[1] 21

> # probability distributions have a unique name with a prefix indicating
> # (d) density
> # (p) distribution
> # (q) quantile
> # (r) random

> # some of the common distribution functions are
> # (binom) binomial distribution
> # (pois) poisson distribution
> # (exp) exponential distribution
> # (norm) normal distribution

> # for example the binomial distribution name is binom calculate the probability
> # of an 80% free throw shooter hitting 5 out of 10 shots
> dbinom(5, 10, .8)
[1] 0.02642412

> # calculate the probability of an 80% free throw shooter making 5 or less of 10
> # shots
> pbinom(5, 10, .8)
[1] 0.0327935

> # calculate the probability of an 80% free throw shooter making more than 5 of
> # 10 shots
> pbinom(5, 10, .8, lower=FALSE)
[1] 0.9672065

> # the poisson distribution (pois) calculates distributions for rates,
> # for example, if 200 cars pass this intersection per hour, on average, what
> # is the probability that 175 or fewer cars pass in an hour
> ppois(190, lambda=200)
[1] 0.2529326

> # if a group of students averaged 80.0 on a test with a standard deviation
> # of 8, what is the likely percentage of students that scored between 75.0
> # and 80.0 if we assume a normal distribution
> pnorm(85, 80, 8) - pnorm(75, 80, 8)
[1] 0.4680289

> # and what percentage of students are expected to score below 40.0
> pnorm(40, 80, 8)
[1] 2.866516e-07

> # if the mean of heights for a set of boys is 143.5 cm and standard
> # deviation of 7.1 cm what is the probability that a randomly chosen
> # boy is taller than 157.7 cm if we assume a normal distribution
> 1 - pnorm(157.7, 143.5, 7.1)
[1] 0.02275013

> # Apply an arbitrary function to any dimension of an array, matrix,
> # or data frame with the apply function. For a matrix or data frame
> # 1 indicates by row and 2 indicates by column. The example here is
> # by row:
> apply(df, 1, myfunc)

> # You can also use sapply to do the same thing, it will operate on
> # the columns of the data frame:
> sapply(df, myfunc)

> # create a sequence from 1 to 10
> # sample 5000 values from the sequence
> # separate the samples into 10 rows (500 cols)
> # create a vector of the means of each column
> # draw a histogram of the means
> # show the variance and standard deviation of the means
> v <- seq(1, 10)
> draws <- sample(v, size=10*500, replace=TRUE)
> draws <- matrix(draws, 10)
> means <- apply(draws, 2, mean)
> hist(means)
> var(means)
> sd(means)

> # average man drinks 2L of water in day with standard deviation of
> # .7L.  If you are planning a trip for 50 men and bringing 110L of
> # water, what is the change you will run out?
> # Sampling distribution produces a normal distribution for these
> # values and the standard deviation
> # = population standard deviation / square root # of samples
> samplesd <- .7 / sqrt(50)
> 1 - pnorm(2.2, 2, samplesd)
[1] 0.02167588

> # Covariance and correlation coefficent:
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

> # Covariance and correlation functions can work on the columns
> # of a data frame:
> states <- state.x77[,1:6]
> cov(states)
> cor(states)
> cor(states, method="spearman")
> # And for non square select out the columns you want:
> x <- states[,c("Population", "Income")]
> y <- states[,c("Life Exp")]
> cor(x, y)

> # Testing a correlation for significance:
> cor.test(mtcars$mpg, mtcars$cyl)

> # Testing if means are equal using a t test, first limit
> # to two levels, then test:
> df <- mtcars[mtcars$cyl == 6 | mtcars$cyl == 8,]
> t.test(mpg ~ cyl, data=df)

> # Testing to see if samples come from same probability
> # distribution, nonparametric:
> df <- mtcars[mtcars$cyl == 6 | mtcars$cyl == 8,]
> wilcox.test(mpg ~ cyl, data=df)

> # Comparing more than two groups, here 4, 6, and 8
> # cylinders:
> kruskal.test(mpg ~ cyl, mtcars)

> # compute an empirical cumulative distribution function
> ecdf(c(1, 2, 3, 4))
> # compute an ecdf from 20 random samples from a normal distribution
> ecdf(rnorm(20))
> # plot the ecdf of 1000 random samples from a normal distribution
> plot(ecdf(rnorm(1000)))

> # From two minute tutorials
> # Change the number of digits displayed:
> option(digits = 22)
> # but then you probably don't want to change that globally, many
> # functions allow yout to specify the digits, especially this one
> print(x, digits=12)

> # Make a vector:
> x <- c(1, 2, 3)
> # Powerful vector element selection:
> y <- x[x > mean(x)]

> # A literal sequence:
> 10:20

> # Some functions that work on vectors, plus addressing:
> length(v)
> class(v)
> is.numeric(x)
> v[2]

> # Taking a slice:
> y <- v[4:8]

> # Constructing a data frame from scratch:
> df <- data.frame(
+    col1 = c("x", "y", "z"),
+    col2 = c(1, 2, 3),
+    row.names = c("bob", "james", "harry"))

> # Addressing a data frame, only the second row, all cols:
> df[2,]
> # Addressing a data frame, only the first two rows, all cols:
> df[1:2,]
> # A way to loop on a data frame:
> for (i in 1:nrow(mtcars)) {
+   print(mtcars[i,])
+ }

> # Installing and using a package:
> install.packages("name")
> library(name)

> # Invoking the help system:
> ?func
> # searches for text in the documentation
> ??text
> help.search("pattern")
> start a local help browser to full documentation
> help.start()
> # specific help
> help(functionname)
> args(functionname)
> example(functionname)
> search the help

> # Sequence function for more complex sequences:
> seq(from = 0, to = 10, by = 2)

> # Reading a csv file:
> df <- read.csv("...")
> # More advanced:
> df <- read.csv("...", header=F, sep="\t")

> # Getting and setting the working directory:
> getwd()
> setwd("...")

> # Looking at part of a data frame:
> head(df)
> tail(df)
> head(df, n=20)

> # Some common literals, operators, functions:
> T, F
> !
> if, else
> ifelse(x, "true", "false")
> for (i in 1:3)
> 10 %% 3
<> while, break, next, repeat{}

> # Some common string manipulation functions:
> gsub, sub
> nchar
> grep("hi", CharVector)
> grep1("hi", CharVector)
> sub(pattern = "hi", replacement = "hello", x)
> gsub
> str_trim(x)
> str_trim(x, side = "left")

> # Conversion routines:
> as.character(x)
> as.numeric(x)
> as.logical(x)
> as.Date(x, "input format")

> # Loading a built in data frame:
> data(mtcars)
> # All the rows, only the "cyl" column:
> mtcars[,"cyl"]
> # Only the rows where cylinders is 6, all the columns:
> mtcars[(mtcars[,"cyl"] == 6),]
> # Assingnment into a new data frame column with conditional:
> mtcars[,"newcol"] <- ifelse (conditional, true, false)
> # Assignment into a new data frame column simplest way
> df$sum <- df$x1 + df$x2

> # recoding a value that is invalid
> df$age[df$age == 99] <- NA
> # adding a category from existing column values
> df$agecat[df$age > 60] <- "elderly"

> # Make a new vector concatenating first and second with separator:
> paste(c("dog", "cat", "man"), c("foo", "bar", "baz"), sep = "-")
[1] "dog-foo" "cat-bar" "man-baz"
> # If one is scalar and other is vector, re-uses the scalar:
> paste("hi", v)
> # Merge the individual results all togther with string separator:
> paste("hi", v, collapse = "")
> paste("hi", "there", sep = ":")

> # Some basic descriptive stats functions:
> mean, median, mode, quantile
> summary
> quantile(v, prob = .9)
> quantile(v, type = 3)
> sum

> # Can do a cross product between two vectors with outer:
> v1 <- c(1, 2, 3)
> v2 <- c(4, 5, 6)
> outer(v1, v2, FUN=paste)
> # and flatten to a vector:
> as.character(outer(v1, v2, FUN=paste))

> # Handling errors without blowing up the script:
> try(x, silent = T)
> try({...}, silent = T)
> e <- try(...
> # Branching on the error:
> if (class(e) == "try-error")

> # Used to create tabular counts:
> table(mtcars$cyl)
> # Cross tabulation of two dimensions, first is
> # row variable, second is column variable:
> t <- table(mtcars$cyl, mtcars$gear)
> # Turn a counts table into a proportions table:
> p <- prop.table(t)
> # And of course turn it into a percent:
> prot.table(t) * 100
> # Flattened versions for higher dimensions:
> ftable(mtcars[,c("cyl", "gear", "carb")])

> # Given a table t, generate marginal frequencies,
> # by row:
> margin.table(t, 1)
> # by column:
> margin.table(t, 2)
> # Likewise generate marginal proportions,
> # by row:
> prop.table(t, 1)
> # by column:
> prop.table(t, 2)
> # and cell proportions leave off the second argument:
> prop.table(t)

> # Add marginal sums to a table:
> addmargins(t)

> # Open up a spread sheet like UI to edit a data frame:
> fix(mtcars)

> # transform is another way to transform / add to a
> # data frame. Of course the regular
> # df[] <- addressing can be used to similar effect
> # and may be more flexible.
> # Here add a new column to the data frame:
> mtcars <- transform(mtcars, newcol = 2 * oldcol)

> # With data frame addressing, we can basically do
> # something like a transform but to a subset of
> # some columns:
> df[test, "newcol"] <- something

> # Sorting a vector:
> sort(u), sort(u, decreasing = T)

> # Sorting a data frame, here the order is set to the order
> # coming from a sort on the wt column:
> mtcars[order(mtcars$wt),]
> # reversing:
> mtcars[order(mtcars$wt, decreasing=TRUE),]
> # or reversing per ordering field using -:
> mtcars[order(-mtcars$wt, -mtcars$cyl),]

> # A sqldf package exists that will let you work with data
> # frames using familiar SQL:
> x <- sqldf("select ...")

> # Merge two data frames together by a column:
> merge(df1, df2, by.x = "column1", by.y = "column2")
> # If the columns have the same name only need to specify once:
> merge(df1, df2, by = "column")
> # And of course you can get fancy here, simulating left
> # and right joins and stuff with the proper parameters:
> merge(p, q, all = T)
> # Also, all = F, all.x = T, all.y = T

> # If two tables have the same number of rows, can put them
> # together "horizontally" with:
> cbind(df1, df2)
> # If the tables have the same columns then rbind will
> # "stack" them into one data frame:
> rbind(df1, df2)

> # tapply produces a vector output from data frame data,
> # here we get the mean of mpg grouped by gear:
> tapply(mtcars$mpg, mtcars$gear, mean)
> # and here we get the 80th quantile of horse power
> # grouped by cylinder:
> tapply(mtcars$hp, mtcars$cyl, quantile, prob = .8)

> # Aggregation of a data frame, here grouped by the number
> # of gears, and producing the mean of the miles per
> # gallon in a data frame output:
> aggregate(mtcars$mpg, by = list(mtcars$gear), mean)
> # alternative tilda syntax:
> aggregate(mpg ~ geat, mtcars, mean)
> # Example with multiple column grouping:
> aggregate(list(Count=aggs$Count), by=list(Service=aggs$Service, SnippetHash=aggs$SnippetHash), sum)
> # and in the alternative, shorter syntax:
> aggregate(Count ~ Service * SnippetHash, aggs, sum)
> # and with more than one aggregate column:
> aggregate(list(Count=aggs$Count, Critical=aggs$Critical), by=list(Service=aggs$Service, SnippetHash=aggs$SnippetHash), sum)

> # To do an aggregate with more than one statistic on the aggregate
> # column the by function can be used:
> myfunc <- function(x) (c(mean=mean(x), sd=sd(x)))
> by(mtcars[vars], mtcars$am, myfunc)

> # Many of the functions take a na.rm parameter which can
> # be used to instruct the function to remove values when
> # the value is NA:
> na.rm=TRUE
> # For example:
> y <- sum(x, na.rm=TRUE)

> # Scale values to produce a vector with a mean of 0
> # and a standard deviation of one:
> y <- scale(x)
> # Scale values to produce a vector with a mean of
> # M and and standard deviation of SD
> y <- scale(x) * SD + M

> # Also can ignore rows that have any NA values:
> df <- na.omit(df)

> # The is.na function can be used to operate on whether
> # or not the value is NA. Likewise the in operator can
> # be used to work around NA problems:
> is.na(x)
> z[is.na(z$rc), "rc"] <- 0
> # or maybe
> z$rc[is.na(z$rc)] <- 0
> %in%, ?"%in%"

> # Show the column names, change a column name:
> names(mtcars)
> names(mtcars)[1] <- "dog"
> # Show the row names:
> rownames(mtcars)

> # Writing out your data is similar to using the
> # read.csv function.
> # Here we write data frame x out in csv format
> # into a file called names.csv:
> write.csv(x, "names.csv")

> # Some ways to round:
> round(u)
> round(u, 2), round(u, digits = 2)
> floor, ceiling, excel_round

> # Scatter plot, scatter plot, xcoords in v1,
> # ycoords in v2:
> plot(v1, v2, xlim = c(0, 10), ylim = c(0, 10),
+    xlab = "label", ylab = "label", main = "main")
> # Now add a line:
> lines(xc, yc)
> # How about a red line:
> lines(xc, yc, col = "red")
> # And now with a width of 2:
> lines(xc, yc, col = "red", lwd = 2)
> # And finally throw on some points:
> points(xc, yc, pch = 17, col = "blue")

> # Some addressing of data frame examples.
> # Include rows where rum == 3, all columns:
> z[(z$rum == 3),]
> # Include rows where rum == 3, all columns, handles
> # NA probably the way you want it:
> z[(z$rum %in% 3),] # handles NA
> # And similar to the last with a negation:
> z[!(z$run %in% 3),]

> # Listing the objecs in memory and remove them:
> ls(), objects(), rm(mtcars)

> # Some ways to address data frames:
[,]
[,c("one", "two")]
[,c(1, 10, 11)]
[,c(-1, -2)]
[,!(names(mtcars) %in% DropCols]

> # Draw a boxplot of the miles per gallon:
> boxplot(mtcars$mpg)
> # Draw a series of miles per gallon box plots grouped
> # into cylinder groups:
> boxplot(mpg ~ cyl, data = mtcars)
> # Or same thing:
> boxplot(mtcars$mpg ~ mtcars$cyl)
> # Or if you just want the stats that comprise a boxplot:
> boxplot.stats(mtcars$mpg)

> # How to make a histogram:
> hist(mtcars$mpg)

> # How to make a bar chart:
> barplot(mtcars$mpg)

> # How to make a pie chart:
> pie(x, c(0, 5, 10, 15), c("lab1", "lab2", ...))

> # Sample 5 elements from the vector:
> sample(v, 5)
> # and now with replacement:
> sample(v, 5, replace = T)
> # and now with the given probablity of choosing each
> # element:
> sample(v, 5, prob = c(.8, .1, .1))
> # a typical usage is to sample rows from a data frame,
> # here sampling 5 rows from the data frame:
> df[sample(nrow(df), 5),]

> # subset is another way to slice and dice a data frame,
> # but data frame addressing is still probably the way
> # to go as you cannot assign into a subset.
> subset(mtcars, hp > 100)
> subset(v, hp > 100, select = keepcols)
> mtcars[mtcars$hp > 100,keepcols]

> # Generate 1 random number between 0 and 1, that is
> # a random from a UNIForm distribution:
> runif(n = 1, min = 0, max = 1)

> # How to use round and runif to get the same thing as
> # a single sample:
> sample(0:100, size = 1)
> round(runif(n = 1, min = 0, max = 100))

> # Generate a random number from a statistical distribution.
> # First generate 1000 random numbers from the uniform
> # distribution between 0 and 10:
> x <- runif(n = 1000, min = 0, max = 10)
> hist(x, breaks = 10)
> # Now generate 1000 random numbers from the standard
> # normal distribution that is mean = 0, sd = 1:
> y <- rnorm(n = 1000)
> hist(y)

> # Setting the seed controls random number generation.
> # That will, for example, effect random uniform
> # distribution generation.
> set.seed(1)
> runif(5)

> # Fancier plot:
> plot(1:30, 2^(1:30), xlab = "generations back",
+     ylab = "number of ancestors",
+     main = "number of ancestors in each generation")
> # If you do a plot with axes = F then you get no axes but then
> # you can control them more granularly such as doing:
> axes( side = 3, at = c(2, 4, 8), labels = c("two", "FOUR", "8"))
> # Similarly can add text at a point:
> text(9, 7, "(nine,seven)")
> # Can also do that with multiple coordinates in one go:
> text(x.coord, y.coord, c("one", "two", "three"), pos = 1)

> # Instead of <- can use assign to dynamically make variable
> # names:
> assign("varname", 10)
> # Then can do things in loop that makes variables for example
> # by pasting together a variable name:
> varname <- paste("pos", i, sep=".")
> assign(varname, computation)
> get("name")

> # Examine the history of commands, save history:
> history(max.show = 50)
> history(max.show = Inf)
> savehistory(file = "/home/dburger/script.R")

> # Working with lists, heterogeneous.
> y <- list(10:12, c("1", "2", "3"), mtcars)
> y[[1]]
> y[[2]][3]
> y[[3]]

> # Normalizing some data, first the data:
> x <- c(4, 5, 6, 12, 22, -1)
> mean(x)
> var(x)
> sd(x)
> # Now make a normalized version of the vector:
> y <- (x - mean(x)) / sd(x)
> mean(y)
> var(y)
> sd(y)

> # Source a script, and source with echo on:
> source(script)
> source(script, echo = T)

> # Grab a time object representing the current time:
> now <- Sys.time()
> now <- Sys.Date()

> # Outputting formatted date values:
> format(x, format="a date time format string")

> # Some data arithmetic:
> difftime(x, y, units="weeks")

> # Start with an empty data frame and add to it:
> x <- data.frame()
> # How to add to it?

> # Make a matrix:
> x <- matrix(NA, nrow = 3, ncol = 3)

> # ifelse of course works vectorized:
> x <- c(TRUE, FALSE, TRUE)
> y <- ifelse(c >= 2, "yes", "no")

> # Calculating correlation coefficients:
> data(mtcars)
> cor(mtcars$hp, mtcars$mpg)
> cor(mtcars$hp, mtcars$mpg, method = "pearson")
> cor(mtcars$hp, mtcars$mpg, method = "kendall")
> cor(mtcars$hp, mtcars$mpg, method = "spearman")

> # Create a linear regression model of mpg against
> # horse power plus weight for the mtcars data.
> x <- lm(mpg ~ hp + wt, data = mtcars)
> # Or do it with explict column vectors:
> x <- lm( mtcars$mpg, mtcars$hp + mtcars$wt)
> # Of course could just do mpg versus hp:
> x <- lm(mpg ~ hp, data = mtcars)
> # Look at a summary of the model:
> summary(x)
> # And the residuals for each data point, here that
> # would be how far a particular cars mpg was off
> # from what is predicted by the model:
> residuals(x)
> # The x$coefficients contains the slope, intercept.
> # The x$sigma contains the root mean squared error,
> # which gives you the expected offset from the
> # regression line.
> # To look at this data with the regression line:
> plot(mtcars$mpg, mtcars$hp)
> abline(x)
> # boxplot the residuals to see how far each is off:
> boxplot(residuals(x))
> # Scatter plot each cars mpg against its residual:
> plot(mtars$mpg, residuals(x))
> Cycle through several different plots:
> plot(x)
> # Of course R makes it easy to do different linear
> # models over different ranges of the data, for example:
> a <- lm(received[requested > 10]~requested[requested > 10],
+     data=employees)
> b <- lm(received[requested <= 10]~requested[requested <= 10],
+     data=employees)

> # Simple linear model example of built in dataset women,
> # first create the linear model:
> model <- lm(weight ~ height, data=women)
> summary(model)
> fitted(model)
> residuals(model)
> plot(women$height, women$weight, xlab="height", ylab="weight")
> abline(model)

> # Lowess fits can be added with two different functions,
> # lowess() and loess(), example:
> lines(lowess(mtcars$wt, mtcars$mpg), col="red", lwd=2, lty=19)

> # The previous model looks like a pretty good fit, however,
> # it appears to have a possible polynomial fit, here we see
> # how this looks with a model against a second degree
> # polynomial:
fit <- lm(weight ~ height + I(height^2), data=women)
> plot(women$weight, women$height)
> lines(women$height, fitted(fit))
> # The summary call will show you the coefficents of the
> # equation.

> # The confint function will give you the confidence intervals
> # on your coefficients of your fitted models. It defaults to
> # a 95% confidence interval but that can be changed with the
> # level parameter:
> confint(fit, level=0.99)

> # Generate random binomial distributions, here coin flip,
> # 1000 flips with 50% chance heads
> x < rbinom(n = 1000, size = 1, prob = 1/2)

> # Saving a plot, can do bmp, jpeg, png, tiff, svg,
> # and probably others:
> png("output.png")
> plot(...)
> dev.off()

> # split, can take regular expressions for split:
> parts <- strsplit("hello world", split = " ")

> # Setting options, reading options, dumping options:
> options(digits = 10)
> getOption("digits")
> options()

> # Actual date class that can do date math:
> birthday <- strptime("02.06.1969", format = "%m.%d.%Y")
> # 10000 day on earth
> birthday + 10000 * 60 * 60 * 24

> # When lots of data points in a scatter plot are going
> # to overlap the jitter function will make them offset
> # a bit.
> # Plots Sales versus Articles from dataframe dispatch
> plot(Sales~jitter(Articles), data=dispatch)

> # Very nice visualization of plots grouped by a value.
> # Makes a hits versus comments plot by author:
> libray(lattice)
> xyplot(hits~comments|name, data=articles)

> # Cleaning data, looks like you can just reassign right
> # back to the column.
> df$job <- sub("scrubber", "polisher", df$job)
> # or possibly
> df[,"job"] <- sub("scrubber", "polisher", df$job)
> # or add a new column
> df[,"new_column"] <- sub("scrubber", "polisher", df$job)

> # Returns a subset of the columns of a data frame, here
> # we assign it back to the same variable.
> # All the rows, but only the name and age columns:
> df <- df[,c("name", "age")]

> # Removing a single column can also be done with a
> # NULL assignment:
> df$column_name <- NULL

> # Change a data frame's column names:
> names(df) <- c("your", "new", "names")
> # Or change one at a time:
> names(df)[2] <- "whatever"

> # some output functions
> print(x)
> cat("This and", x, "and also that")
> # and cat can right to a file
> cat("This and", x, file="filename")
> # or to a file handle
> f = file("filename", "w")
> cat("This and", x, file=f)
> close(f)

> # quick trick to get the percent of a vector that
> # matches a criteria, the boolean comparison makes
> # a TRUE / FALSE vector and then the mean function
> # changes that to TRUE = 1, FALSE = 0
> mean(x == "bob")

> # POSIXct and POSIXlt are a couple of date types, they have
> # the regular old as converters
> as.POSIXct("string")
> as.POSIXlt("string")
> # POSIXct is seconds since the epoch
> # POSIXlt is broken out year, month, ..., second

> # Good old recycling rules and diff can make for some consise
> # distribution range calculations. For example, what is the
> # likelihood from 3 to 7 successes out of 10
> diff(pbinom(c(3, 7), 10, prob=0.5)

> # POS:154 something is off here
> observed <- c(59, 316, 596, 633, 320, 76)
> expected <- c(62.5, 312.5, 625, 625, 312.5, 62.5)
> # calculated X-squared matches
> sum((expected - observed)^2 / expected)
[1] 4.7792
> # but apparently that is not how you invoked it with chisq.test
> chisq.test(expected, observed)

  Pearson's Chi-squared test

data:  expected and observed
X-squared = 12, df = 10, p-value = 0.2851

Warning message:
In chisq.test(expected, observed) :
  Chi-squared approximation may be incorrect

> # Many of the tests of independence function on the rows
> # and columns of tables.
> chisq.test(t)
> fisher.test(t)
> mantelhaen.test(t)

> # The read functions currently are unable to read over SSL,
> # however the download.file function can be used. Here is
> # an example function that can hide the multiple steps to
> # using download.file to get data in a data frame:
> my.read <- function(url) {
+   f <- tempfile()
+   download.file(url, destfile=f, method="wget")
+   df <- read.csv(f)
+   unlink(f)
+   df
+ }

> # The hist function makes nice histograms but seems to require
> # the values to be a vector of individual values. If your data
> # is from a data frame and say you have df$size and df$count
> # you can use rep to explode the out into a vector, for example:
> hist(rep(df$size, df$count), breaks=0:12)

> # cut allows you to break up convert values into the range they
> # occupy as a factor. Something you might do with this is then
> # make a table of the count of values within each factor:
> table(cut(mtcars$mpg, breaks=seq(10.0, 35.0, by=5.0)))
(10,15] (15,20] (20,25] (25,30] (30,35]
      6      12       8       2       4

> # (some of the formula's here are in Bulmer's Ch. 4)
> # Computing mean, variance, and standard deviation from data
> # given with frequency counts. Say you have this:
> df <- data.frame(count=c(3, 4, 5), weight=c(9,10,11))
> df
  count weight
1     3      9
2     4     10
3     5     11
> # Of course you can just use rep to let R operate on the full
> # vectors:
> mean(rep(df$weight, df$count))
[1] 10.16667
> var(rep(df$weight, df$count))
[1] 0.6969697
> sd(rep(df$weight, df$count))
[1] 0.8348471
> # Getting the mean without using rep is easy:
> sum(df$count * df$weight) / sum(df$count)
[1] 10.16667
> # Calculating the sum of squares will allow you to easily
> # calculate variance and standard devation, from the counts
> # this can be done as follows, explicit way:
> sum(df$count * (df$size - (sum(df$count * df$size) / sum(df$count)))^2)
[1] 7.666667
> # or the shortcut (on paper anyway) formula way:
> sum(df$count * df$weight^2) - sum(df$count) * (sum(df$weight * df$count) / sum(df$count))^2
[1] 7.666667
> # now divide by n or n-1 to get sample or population variance.

> # (some of the formula's here are in Bulmer's Ch. 4)
> # Computing mean, variance, and standard deviation from data
> # given with frequency percentages. Take the data frame from
> # from the last section and do this:
> df[,"percent"] <- df$count / sum(df$count)
> df
  count weight   percent
1     3      9 0.2500000
2     4     10 0.3333333
3     5     11 0.4166667
> # Now we will use frequency percentages to calculate mean,
> # variance, and standard deviation. First the mean:
> sum(df$weight * df$percent)
[1] 10.16667
> # and the population variance (see the mean in there):
> sum((df$weight - sum(df$weight * df$percent))^2 * df$percent)
[1] 0.6388889
> # thus the population standard deviation need only take the
> # square root:
> sqrt(sum((df$weight - sum(df$weight * df$percent))^2 * df$percent))
[1] 0.7993053
> # And of course these can be adjusted to sample instead of
> # population computations with the appropriate adjustment:
> (previous result) * sum(df$count) / (sum(df$count) - 1)

> # cosine distance with R
> v1 <- c(1, 2, 3)
> v2 <- c(1, 2, 3)
> sum(v1 * v2) / (sqrt(sum(v1^2)) * sqrt(sum(v2^2)))
[1] 1


> # quantiles, with no argument gives quartiles
> quantile(v1)
   0%   25%   50%   75%  100%
 1.00  3.25  5.50  7.75 10.00
> # otherwise you can specify the quantile you want
> quantile(v1, .75)
 75%
7.75
> # and in R fashion can provide several
> quantile(v1, c(0.5, 0.95))
 50%  95%
5.50 9.55

> # convert a vector to Z-scores
> scale(v1)

> # Given a vector sample of a population, test the
> # possibility of a given mean
> t.test(v1, mu=6.8)
  One Sample t-test

data:  v1
t = -1.3578, df = 9, p-value = 0.2076
alternative hypothesis: true mean is not equal to 6.8
95 percent confidence interval:
 3.334149 7.665851
sample estimates:
mean of x
      5.5
> # a p-value of 0.2076 does not rule out the possibility
> # that 6.8 could be the mean for the population.

> # you have a sample from a population, and you want a
> # confidence interval for the mean
> t.test(v1)
> # note that the output will include a 95 percent confidence
> # interval. You can also change the percent obviously.
> t.test(v1, conf.level=0.99)

> # Calculate a confidence interval for the median for a sample
> # from a population
> wilcox.test(v1, conf.int=TRUE)

> # Calculate the likelihood of a given success proportion from
> # a sample of a population
> prop.test(x, n, p)
> # where x is successes in the sample
> # n is the number of trials in the sample
> # p is the proportion you are testing likelihood of

> # Confidence interval on the proportion given that the sample
> # contains x successes in n trials
> prop.test(x, n)

> # Test if a data sample is likely from a normal distribution
> shapiro.test(v1)

> # Test if the samples from two different populations have the
> # same mean
> t.test(x, y)
> # or
> t.test(x, y, paired=TRUE)

> # Test correlation
> cor.test(x, y)

> # Testing groups for equal proportions
> # ns - vector number of successes
> # nt - vector number of trials
> prop.test(ns, nt)

> # Pairwise mean comparison uses parallel vectors
> # one for values and one for the identifying factor
> pairwise.t.test(v1, v2)

> # Test whether two samples were drawn from the same
> # distribution
> ks.test(x, y)

> # Plots for the related variables per factor
> coplot(x ~ y | f)

> # Getting the lower bounds of the confidence interval
> # in a vector
> lower <- tapply(Temp, Month,
    func(v) t.test(v)$conf.int[1])

> # Generating colors for charts
> gray(v)
> rainbow(v)

> # Adding vertical or horizontal lines
> abline(v=x)
> abline(h=x)

> # Adding a density curve to a histogram of a 500 random samples
> # from a gamma distribution.
> samp <- rgamma(500, 2, 2)
> hist(samp, 20, prob=TRUE)
> lines(density(samp))

> # Plotting curves
> curve(sin, -3, +3)

> # Set up plotting parameters to pause between each plot
> par(ask=TRUE)

> # Multiple plots on the some output window, first set up
> # the grid you will set the plots into
> par(mfrow=c(2, 2))
> # now each call to draw a plot will go into the next grid
> # location
> plot(x)

> # Saving a plot after generated
> savePlot(filename="filename", type="png")

> # Conditioning plot, plot y related to x per factor for
> # the data frame
> coplot(y ~ x | f, data=df)

> # Generate the lower bounds by month for temperature data
> lower <- tapply(Temp, Month, function(v) t.test(v)$conf.int[1])

> # Addition of horizontal and vertical lines
> abline(h=4)
> abline(v=-2)

> # Generate shades / colors for plots, for gray
> # must pass [0, 1], 0 == black, 1 == white
> gray(x)
> # rainbow takes a count to generate and then other parameters
> rainbow(x)

> # Compute row and column sums
> rowSums(x)
> colSums(x)
> # and tack them on say a data frame
> mtcars <- rbind(mtcars, colSums(mtcars))

> # Index of min and max elements
> which.min(v1)
> which.max(v1)

cut and match dammit
