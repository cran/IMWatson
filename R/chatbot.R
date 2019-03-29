#' @title chatbot Shiny server Module
#' @details A shiny server module for the chatbot
#' @param input input variable to read the value from
#' @param output output variable to read the value from
#' @param session session variable to read the value from
#' @param api_key api key to connect to your watson assistant
#' @param workspace your watson assistant workspace
#' @param rv.chat optional variable to pass your chatbot as a reactive variable
#' @examples
#' if(interactive()){
#' ## app.R ##
#' library(shiny)
#' library(shinydashboard)
#' library(IMWatson)
#' ui <- dashboardPage(
#' dashboardHeader(),
#' dashboardSidebar(),
#' dashboardBody(IMWatson::chatbotUI("watson"))
#' )
#' server <- function(input, output, session) {
#' callModule(IMWatson::chatbot, "watson", api_key = your_api_key,
#' workspace = your_workspace)
#'  }
#'  shinyApp(ui, server)
#'  }

#' @export
#' @rdname chatbot
#'
chatbot <- function(input, output, session, api_key, workspace, rv.chat=FALSE){

  if(!is.list(rv.chat)){
    bot <- IMWatson::watson_chat_factory$new(api_key, workspace)
    rv.chat <- shiny::reactiveValues(text = bot$text,
                              show.chat = FALSE,
                              context = bot$context,
                              bot = bot)
    shiny::observeEvent(input$send, {
      bot$answer(text = input$message_field)

      rv.chat$text <- shiny::HTML(paste(bot$text, collapse = '<br/>'))
      rv.chat$context <- bot$context
      shiny::updateTextInput(session, inputId = "message_field", value = "")
    })

    shiny::observeEvent(input$chatButton, ({
      rv.chat$show.chat <- !(rv.chat$show.chat)
    }))
  }

  shiny::observe({
    output$chat <- shiny::renderUI({ shiny::HTML(rv.chat$text) })
  })

  output$showchat <- shiny::renderText({
    if(rv.chat$show.chat){
      "Your message"
    } else{
      "hidded"
    }
  })

  shiny::outputOptions(output, "showchat", suspendWhenHidden = FALSE)
  return(rv.chat)
}
