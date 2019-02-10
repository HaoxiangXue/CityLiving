#' Presenting scores of city
#'
#' This function presents the average score of each city.
#'
#' @param x the city, input a city name or "all"
#' @return a plot
#' @examples
#' score("Tokyo")
#' @importFrom dplyr %>% select mutate arrange
#' @export
score <- function(x = "all") {
  teleport_mean <- simpledata %>%
    select(Housing:Outdoors) %>%
    rowMeans() %>%
    round(digits = 2)
  index_mean <- as.data.frame(simpledata$City) %>%
    mutate(teleport_mean)
  colnames(index_mean) <- c("City", "index_mean")
  index_mean <- unique(arrange(index_mean, desc(index_mean)))
  if (x == "all") {
    barplot(index_mean$index_mean[1:5], main = "Top 5 Livable cities by teleport", names.arg = index_mean$City[1:5], col = "blue", ylab = "score out of 10")
  } else if (x %in% simpledata$City){
    barplot(as.matrix(simpledata[which(simpledata$City == x), 2:8]), main = paste("scores out of 10 of ", x, sep = ""))
  } else {
    print("Valid input includes 'all', and city name such as 'Tokyo'.")
}
}
