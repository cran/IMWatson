#' @title Shiny Chatbot
#' @description FUNCTION_DESCRIPTION
#' @param title The title for the chatbox
#' @param api_key The API key
#' @param workspace The workspace api for your chatbot
#' @examples
#' if(interactive()){
#' library(IMWatson)
#' ShinyChatbot(api_key = your_api_key,
#' workspace = your_workspace)
#'  }
#' @seealso
#'  \code{\link[shiny]{runApp}}
#' @rdname ShinyChatbot
#' @export
ShinyChatbot <- function(api_key, workspace, title="Chatbot powered by Watson") {
  server_path <- system.file("chat/server.R", package = "IMWatson")
  source(server_path, local = TRUE)
  ui_path <- system.file("chat/ui.R", package = "IMWatson")
  source(ui_path, local = TRUE)
  server_env <- environment(server)

  # Here you add any variables that your server can find
  server_env$title <- title
  server_env$api_key <- api_key
  server_env$workspace <- workspace
  ui <- server <- NULL # avoid NOTE about undefined globals
  server_env <- environment(server)
  app <- shiny::shinyApp(ui, server)
  shiny::runApp(app)
}
