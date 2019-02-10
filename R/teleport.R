#'  Index from teleport
#'
#' This function obtains the index data from teleport (https://teleport.org/)
#' You could input 'city', any city name, or 'all'.
#'
#' @param x the category
#' @return a data.frame
#' @examples
#' teleport("Beijing")
#' @importFrom dplyr %>% select mutate
#' @importFrom httr GET content
#' @importFrom jsonlite toJSON fromJSON
#' @importFrom Hmisc capitalize
#' @export
teleport <- function(x = "city"){
  tele_city_list <- GET("https://developers.teleport.org/assets/urban_areas.json") %>%
    content() %>%
    toJSON() %>%
    fromJSON() %>%
    as.data.frame() %>%
    t()
  rownames(tele_city_list) <- NULL
  tele_city_list_2 <- capitalize(tele_city_list)
  if (x == "city"){
    x <- tele_city_list_2
    x
  } else if (x %in% tele_city_list_2) {
    city <- tolower(x)
    x <- GET(paste("https://api.teleport.org/api/urban_areas/slug:", city, "/scores/", sep = "")) %>%
      content() %>%
      toJSON() %>%
      fromJSON()
    x <- x$categories %>%
      select(name, score_out_of_10)
    x$name <- as.character(x$name)
    x$score_out_of_10 <- as.numeric(as.character(x$score_out_of_10))
    x
  } else if (x == "all"){
    x <- list()
    for (i in 1:length(tele_city_list)){
      x[[i]] <- GET(paste("https://api.teleport.org/api/urban_areas/slug:", tele_city_list[i], "/scores/",
                          sep = "")) %>%
        content() %>%
        toJSON() %>%
        fromJSON()
      x[[i]] <- x[[i]]$categories %>%
        select(name, score_out_of_10)
      x[[i]]$name <- as.character(x[[i]]$name)
      x[[i]]$score_out_of_10 <- as.character(x[[i]]$score_out_of_10)
    }
    x <- x %>%
      lapply(.,t)%>%
      sapply(unlist) %>%
      t()
    x_indicator <- x[1, seq(1,ncol(x)-1, 2)]
    x <- x[, seq(2, ncol(x), 2)] %>%
      as.data.frame()
    colnames(x) <- x_indicator
    for (i in 1:ncol(x)){
      x[, i] <- as.numeric(as.character(x[, i]))
    }
    x <- x %>%
      mutate(City = as.vector(tele_city_list_2)) %>%
      select(City, Housing:Outdoors)
    x
  } else {
    print("Valid values include 'city' for city list, names of city such as 'Beijing', 'all' for all cities.")
  }
}




