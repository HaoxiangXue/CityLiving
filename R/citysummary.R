#' Descriptive statistics of data
#'
#' This function presents the descriptive statistics information of the dataset
#'
#' @param x the dataset
#' @return a data.frame
#' @examples
#' citysummary(simpledata)
#' @importFrom psych describe
#' @importFrom dplyr %>% select
#' @export
citysummary <- function(x = simpledata){
  if (x %in% c(simpledata, fulldata, teleportdata, numbeodata)) {
    x <- x[, 2:ncol(x)]
    y <- psych::describe(x) %>%
      select(n, mean, sd, median, min, max, skew, kurtosis)
    y
  } else {
    print("It doesn't work for dataset out of this package!")
  }
}
