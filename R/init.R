#' @title Initialize connection with Watson's Conversation API
#' @description Connect to Watson's Conversation API
#' @param api_key API Key
#' @param workspace Workspace api
#' @param url optional argument that defaults to "https://gateway.watsonplatform.net/assistant/api/v1/workspaces"
#' @param version optional argument that defaults to "2018-09-20"
#' @return The function returns a lits with the text and the contex that is returned by your assistant.
#' @details This function allows you to start a connection to your Watson Assistant
#' @examples
#' if(interactive()){
#' # See https://cloud.ibm.com/apidocs/assistant
#'  conection <- init(api_key, workspace)
#'  conection[["text"]]
#'  chat1 <- chat("Ignacio", conection, username, password, workspace)
#'  chat1[["text"]]
#'  chat2 <- chat("I would like flower suggestions", chat1, username, password, workspace)
#'  chat2[["text"]]
#'  }
#' @export

init <- function(api_key, workspace, url, version)  {
  if(missing(url)){
    url <- "https://gateway.watsonplatform.net/assistant/api/v1/workspaces"
  }
  if(missing(version)){
    version <- "2018-09-20"
  }
  conv.init <- httr::POST(url=glue::glue("{url}/{workspace}/message?version={version}"),
                          httr::authenticate("apikey",api_key),
                          httr::add_headers(c("Content-Type"="application/json")),

                          body = '{ "input": { "text":""},
                        "system":{ "dialog_stack":["root"]},
                        "dialog_turn_counter":1,
                        "dialog_request_counter":1}',
                          encode = "json") %>%
    httr::content("text", encoding = "UTF-8") %>%
    jsonlite::fromJSON()

  out <- list(text=conv.init$output$text,
              context = jsonlite::toJSON(conv.init$context, auto_unbox = TRUE))

  return(out)
}
