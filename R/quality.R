#' Presenting Quality Indices
#'
#' This function presents the life quality indices.
#'
#' @param x the city, a city name or "all"
#' @return a list include a table and a plot
#' @examples
#' quality("Beijing")
#' @importFrom dplyr %>% select arrange
#' @export
quality <- function(x = "all") {
  if (x == "all"){
    x <- simpledata %>%
      select(City, Weighted_Quality) %>%
      arrange(desc(Weighted_Quality))
    table1 <- head(x, 5)
    plot1 <- barplot(x$Weighted_Quality[1:5], main = "Top 5 Quality Index cities", names.arg = x$City[1:5], col = "blue")
    result <- list(table1, plot1)
    result
  } else if (x %in% simpledata$City) {
    table1 <- simpledata %>%
      select(City, 38:44)
    table2 <- table1[which(simpledata$City == x), ]
    matrix <- table2 %>%
      select(-City) %>%
      as.matrix()
    plot2 <- barplot(matrix, main = paste("Indices of ", x, sep = ""), names.arg = c("Power use", "Safety", "Health", "Climate", "Property", "Traffic", "Pollution"))
    result <- list(table2, plot2)
    result
  } else {
    print("Valid input includes 'all', and city name such as 'Tokyo'.")
  }
}
