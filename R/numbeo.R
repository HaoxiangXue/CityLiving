#' Data from Numbeo
#'
#' This function obtains the index data from Numbeo (https://www.numbeo.com/)
#' You could input 'cost', "crime", or 'quality'.
#'
#' @param x the category, including "cost", "crime", "quality".
#' @return a data.frame
#' @examples
#' numbeo("cost")
#' @importFrom dplyr %>% select mutate
#' @importFrom httr GET content
#' @importFrom jsonlite toJSON fromJSON
#' @importFrom Hmisc capitalize
#' @importFrom xml2 read_html
#' @importFrom stringr str_extract str_replace_all
#' @importFrom rvest html_nodes html_table
#' @export
numbeo <- function(x = "cost") {
  cost <- read_html("https://www.numbeo.com/cost-of-living/rankings_current.jsp") %>%
    html_nodes(xpath = "//*[@id='t2']") %>%
    html_table() %>%
    as.data.frame() %>%
    select(-Rank)
  city <- str_extract(cost$City, "^[A-Z][ |a-z|A-Z]*") %>%
    str_replace_all(" ", "-")
  cost$City <- city
  if (x == "cost") {
    x <- cost
    x
  } else if (x == "crime"){
    x <- list()
    for (i in 1:length(city)){
      x[[i]] <- read_html(paste("https://www.numbeo.com/crime/in/", city[[i]], sep = "")) %>%
        html_nodes(xpath = "/html/body/div/table[1]") %>%
        html_table()
    }
    x_indicator <- as.vector(x[[1]][[1]]$X1)
    x_indicator <- c("City", x_indicator)
    x_value <- x %>%
      sapply(unlist) %>%
      do.call(rbind,.)%>%
      as.data.frame %>%
      select(X31:X313)
    x_sub <- vector()
    for ( i in 1: length(x)) {
      x_sub[i] <- length(x[[i]]) !=0
    }
    crime_city <- city[x_sub]
    x <- cbind(crime_city, x_value)
    colnames(x) <- x_indicator
    x
  } else if (x == "quality") {
    x <- list()
    for (i in 1:length(city)){
      x[[i]] <- read_html(paste("https://www.numbeo.com/quality-of-life/in/", city[[i]], sep = "")) %>%
        html_nodes(xpath = "/html/body/div/table") %>%
        html_table()
    }
    x_indicator <- as.vector(x[[1]][[1]]$X1)
    x_indicator <- c("City", x_indicator)
    x_value <- x %>%
      sapply(unlist) %>%
      do.call(rbind,.)%>%
      as.data.frame %>%
      select(X21:X210)

    x_sub <- vector()
    for ( i in 1: length(x)) {
      x_sub[i] <- length(x[[i]]) !=0
    }
    qua_city <- city[x_sub]
    x <- cbind(qua_city, x_value)
    colnames(x) <- x_indicator
    x <- x %>%
      select(-10) %>%
      select(1:9, Weighted_Quality = 10)
    x
  } else {
    print("Valid values include 'cost', 'crime', and 'quality'.")
  }
}


