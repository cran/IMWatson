#' @title Continue Chat with Watson
#' @description Chat with Waston after initializing a connection
#' @param text Whatever you want to say to Watson
#' @param api_key api key to connect to your watson assistant
#' @param url optional argument that defaults to "https://gateway.watsonplatform.net/assistant/api/v1/workspaces"
#' @param version optional argument that defaults to "2018-09-20"
#' @param workspace Workspace api
#' @param context context returned by your assistant
#' @return a list with the response and context produced by our assistant
#' @details continue your conversation with your assistant
#' @examples
#' if(interactive()){
#'  connection <- init(api_key, workspace)
#'  connection[["text"]]
#'  chat1 <- chat("Ignacio", connection, api_key, workspace)
#'  chat1[["text"]]
#'  chat2 <- chat("I would like flower suggestions", chat1, api_key, workspace)
#'  chat2[["text"]]
#'  }


continue_chat <- function(text, context, url, version, api_key, workspace) {

  if(missing(url)){
    url <- "https://gateway.watsonplatform.net/assistant/api/v1/workspaces"
  }
  if(missing(version)){
    version <- "2018-09-20"
  }

  the_body <-  paste('{"input":{"text":"',
                     text,
                     '"},"context":',
                     context,
                     "}",
                     sep="")

  back <- httr::POST(url=glue::glue("{url}/{workspace}/message?version={version}"),
                     httr::authenticate("apikey",api_key),
                     httr::add_headers("Content-Type"="application/json"),
                     body = the_body) %>%
    httr::content("text", encoding = "UTF-8") %>%
    jsonlite::fromJSON()

  out <- list(text=gsub('\\"|\\[|\\]', "",back$output$text),
              context = jsonlite::toJSON(back$context, auto_unbox = TRUE))

  return(out)

}
