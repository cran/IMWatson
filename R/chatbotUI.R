#' @title chatbotUI Shiny UI Module
#' @description An user interface for your shiny watson assistant apps
#' @param id namespace id
#' @examples
#' if(interactive()){
#' ### APP ###
#' library(shiny)
#' library(shinydashboard)
#' ui <- dashboardPage(
#'   dashboardHeader(),
#'     dashboardSidebar(),
#'       dashboardBody(uiOutput("context"),
#'                       IMWatson::chatbotUI("watson"))
#'                       )
#' server <- function(input, output, session) {
#' rv <- reactiveValues(rv.chat = FALSE)
#' bot <- reactive({
#' callModule(IMWatson::chatbox, "watson", texlog)
#' })
#' output$context <- renderUI(bot()$magic)
#' }
#' shinyApp(ui, server)
#'  }
#' @export
#' @rdname chatbotUI
#'

chatbotUI <- function(id){
  ns <- shiny::NS(id)
  jscode <- jsclicktoenter(send = ns("send"), chatboxid = ns("chatbox"),
                           message_field = ns("message_field"))

  shiny::tagList(
    shiny::conditionalPanel(condition = 'output.showchat == "Your message"' , ns=ns,
                            shiny::absolutePanel(
                       bottom = 5, right = 20, width = 450, height = 600,
                       draggable = TRUE,
                       shiny::actionButton(ns("send"), "Send", style='padding:0px; font-size:0%'),
                       shiny::absolutePanel(bottom = 120, right = 20, width = 450, height = 500,
                                            shiny::wellPanel(id = ns("chatbox"),style = "overflow-y:scroll;
                             max-height: 500px; height: 500px",
                                                             shiny::uiOutput(ns("chat"))
                                     )
                       ),
                       shiny::absolutePanel(bottom = 10, right = 20, width = 450, height = 100,
                                            shiny::wellPanel(id = ns("textinput"),style = "height: 100px",
                                                             shiny::textInput(ns("message_field"),
                                                                              shiny::textOutput(ns('showchat')),
                                                         width = "450px")
                                     )
                       ),


                       style = "opacity: 0.92"
                     )
    ),

    shiny::absolutePanel(bottom = 35, right = 25, width = 15, height = 15,
                         shiny::actionButton(ns("chatButton"), "", icon = shiny::icon("comments"))),
    shinyjs::useShinyjs(),
    shinyjs::extendShinyjs(text = jscode)
  )
}


