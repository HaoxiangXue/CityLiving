#' Brief Summary of Costs
#'
#' This function collects the brief summary and tidy it into a table.
#' This function obtains the index data from Numbeo (https://www.numbeo.com/)
#' You could input any city name.
#'
#' @param x the city name
#' @return a data.frame
#' @examples
#' costsummary("Beijing")
#' @importFrom dplyr %>%
#' @importFrom xml2 read_html
#' @importFrom stringr str_extract_all
#' @importFrom rvest html_nodes html_text
#' @export
costsummary <- function(x = "Beijing") {
  if (x %in% simpledata$City){
    brief_sum <- read_html(paste("https://www.numbeo.com/cost-of-living/in/", x, sep = "")) %>%
      html_nodes(xpath = "/html/body/div[1]/div[4]/ul") %>%
      html_text()
    info_value <- str_extract_all(brief_sum, " [0-9|,|.]+") %>%
      unlist %>%
      as.data.frame()
    info_value2 <- data.frame(Four_Person_Cost = info_value[1, 1], Single_Person_Cost = info_value[2, 1], Rank = as.numeric(as.character(info_value[4,1])) / as.numeric(as.character(info_value[5, 1])))
    info_value2
  } else {
    print("Please input a city which the simpledata includes!")
  }
}
