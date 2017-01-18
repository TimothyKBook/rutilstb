This is a package of various functions that I've made which I've found
useful while working on different projects. They fall into to two
categories:

1.  Functions I've found convenient while using Stata, and felt a need
    to port them into R.
2.  Functions I've needed for a specific, narrow purpose.

Functions Ported from Stata
---------------------------

### The `isid` Function

The `isid` function can be used to detect whether or not a variable (or
group of variables) has unique values. It has three uses:

#### Use \#1: Vectors

    a <- 1:5
    b <- c(1, 1, 2, 3, 4)

    isid(a)

    ## [1] TRUE

    isid(b)

    ## [1] FALSE

#### Use \#2: Data Frames

    users <- data.frame(
      user_id = 1:5,
      first_name = c('Tim', 'Brandon', 'Brandon', 'Arya', 'Cersei'),
      last_name = c('Book', 'Stark', 'Tully', 'Stark', 'Lannister')
    )

    isid(users)

    ##    user_id first_name  last_name 
    ##       TRUE      FALSE      FALSE

#### Use \#3: Combinations of Variables in a Data Frame

    isid(users, keys = c('first_name', 'last_name'))

    ## [1] TRUE

### The `tabstat` Function

The `tabstat` function can be used to view statistics based on
categorical variables within a data frame.

    tabstat('mpg', mtcars, by = 'cyl')

    ##   cyl     mean       sd  min median  max count
    ## 1   4 26.66364 4.509828 21.4   26.0 33.9    11
    ## 2   6 19.74286 1.453567 17.8   19.7 21.4     7
    ## 3   8 15.10000 2.560048 10.4   15.2 19.2    14

    tabstat('mpg', mtcars, by = 'cyl', fns = list(median, IQR, length))

    ##   cyl median  IQR count
    ## 1   4   26.0 7.60    11
    ## 2   6   19.7 2.35     7
    ## 3   8   15.2 1.85    14

### The `mdesc` Function

The `mdesc` function gives a description of missing values in a data
frame, and where they are located.

    df <- data.frame(
      a = 1:5,
      b = c(2, 3, NA, 4, 5),
      c = c(NA, 'x', 'y', 'z', NA)
    )
    mdesc(df)

    ##   variable missing total percent_missing
    ## 1        a       0     5             0.0
    ## 2        b       1     5             0.2
    ## 3        c       2     5             0.4

Quick Functions of Narrow Use
-----------------------------

### The `colMatcher` Function

The `colMatcher` function tells the user if any two columns are
identical.

    df <- data.frame(
      x = 1:5,
      y = 101:105,
      z = 1:5,
      w = 101:105,
      v = letters[1:5]
    )
    colMatcher(df)

    ## [1] TRUE

    colMatcher(df, return_index = TRUE)

    ##      col1 col2
    ## [1,]    1    3
    ## [2,]    2    4

### The `dfSplit` Function

The `dfSplit` function splits a `data.frame` into parts, either via a
training/test split, or a K-fold split.

    df <- data.frame(matrix(
      rnorm(100 * 4), 100, 4
    ))

    split1 <- dfSplit(df, method = 'traintest', train_frac = 0.8)
    lapply(split1, dim)

    ## $train
    ## [1] 80  4
    ## 
    ## $test
    ## [1] 20  4

    split2 <- dfSplit(df, method = 'traintest', train_n = 70)
    lapply(split2, dim)

    ## $train
    ## [1] 70  4
    ## 
    ## $test
    ## [1] 30  4

    split3 <- dfSplit(df, method = 'kfold', K = 4)
    lapply(split3, dim)

    ## $`1`
    ## [1] 25  5
    ## 
    ## $`2`
    ## [1] 25  5
    ## 
    ## $`3`
    ## [1] 25  5
    ## 
    ## $`4`
    ## [1] 25  5

### The `fullRanker` Function

The `fullRanker` function takes a matrix or `data.frame` and
successively removes columns until it is of full rank.

    X1 <- diag(4)
    X2 <- cbind(X1, 1)

    fullRanker(X1)

    ##      [,1] [,2] [,3] [,4]
    ## [1,]    1    0    0    0
    ## [2,]    0    1    0    0
    ## [3,]    0    0    1    0
    ## [4,]    0    0    0    1

    fullRanker(X2)

    ##      [,1] [,2] [,3] [,4]
    ## [1,]    0    0    0    1
    ## [2,]    1    0    0    1
    ## [3,]    0    1    0    1
    ## [4,]    0    0    1    1

### The `unpack` Function

The `unpack` function simply takes objects in a list, and unpacks them
into the global (or otherwise unspecified) environment.

    rm(list = ls())
    ls()

    ## character(0)

    mylist <- list(a = 1:5,
                   b = letters[1:6],
                   c = rnorm(7))
    unpack(mylist)
    ls()

    ## [1] "a"      "b"      "c"      "mylist"
