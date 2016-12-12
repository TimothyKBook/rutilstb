#' Split a data frame into multiple parts.
#'
#' Given a data frame, split it as either (1) K equal slices for use in K-fold
#' cross validation or (2) into a train-test split.  If split into a training
#' and testing set, you may select the training size as either a fraction of the
#' original data, or by the number of observations.
#'
#' @param dat Either a data frame or matrix to be split.
#' @param method Either \code{"kfold"} or \code{"traintest"}, for splitting
#' based on K-fold cross validation or a train/test split.
#' @param K The number of folds, if \code{"kfold"} is selected.
#' @param train_frac The fraction of data to be put into the training set.
#' @param train_n The number of observations to be put into the trianing set,
#' if \code{train_frac} is not selected.
#'
#' @return A list of data frames sliced from the original data.
dfSplit <- function(dat, method = c("kfold", "traintest"),
                    K = NULL, train_frac = NULL, train_n = NULL)
{
  # Stop if an incorrect dat is given.
  if (!(is.data.frame(dat) | is.matrix(dat)))
  {
    stop("Please enter a dataframe or matrix!")
  }

  n <- nrow(dat)

  # Split into K groups.
  if (method == "kfold")
  {
    if (is.null(K)) stop("Please enter a value for K!")
    u <- sample(1:n)
    dat$cat <- cut(u, K, labels = 1:K)
    dat <- split(dat, as.factor(dat$cat))
    return(dat)
  }

  # Split into train and testing data.
  if (method == "traintest")
  {
    # Return error if neither or both options specified.
    if (!xor(is.null(train_frac), is.null(train_n)))
    {
      stop("Please specify exactly one of train_frac or train_n!")
    }

    # Split by fractions.
    if (!is.null(train_frac))
    {
      train_index <- sample(1:n, round(train_frac*n), replace = FALSE)
      train <- as.data.frame(dat[train_index,])
      test <- as.data.frame(dat[-train_index,])

      out <- list("train" = train, "test" = test)
      return(out)
    }

    # Split by sample size.
    if (!is.null(train_n))
    {
      train_index <- sample(1:n, train_n, replace = FALSE)
      train <- as.data.frame(dat[train_index,])
      test <- as.data.frame(dat[-train_index,])

      out <- list("train" = train, "test" = test)
      return(out)
    }
  }
}
