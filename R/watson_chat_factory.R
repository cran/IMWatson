#' @title watson chat factory
#' @export
watson_chat_factory <- R6::R6Class(
  "WatsonChat",
  private = list(
    ..api_key = NULL,
    ..workspace = NULL,
    ..url = "https://gateway.watsonplatform.net/assistant/api/v1/workspaces",
    ..version = "2018-09-20",
    ..text = NULL,
    ..context = NULL
  ),

  active = list(

    workspace = function(value){
      if(missing(value)){
        private$..workspace
      } else {
        if(!assertive::is_a_string(value)) stop("workspace has to be a character string")
        private$..workspace <- value
      }
    },

    text = function(){
      private$..text
    },

    context = function(){
      private$..context
    }
  ),

  public = list(
    initialize = function(api_key, workspace){
      private$..api_key <- api_key
      private$..workspace <- workspace
      hello <- init(api_key, workspace,
                    url = private$..url,
                    version = private$..version)
      private$..text <- paste0("<b>Chatbot:</b> ", hello$text)
      private$..context <- hello$context
    },

    answer = function(text, context){

      if(!missing(context)){
        private$..context <- context
      }

      if(missing(text)){
        response <- continue_chat(text = "",
                                  context = private$..context,
                                  url = private$..url,
                                  version = private$..version,
                                  api_key = private$..api_key,
                                  workspace = private$..workspace)
        private$..text <- c(private$..text,
                            paste0("<b>Chatbot:</b> ", response$text))
      }else{
        response <- continue_chat(text = text,
                                  context = private$..context,
                                  url = private$..url,
                                  version = private$..version,
                                  api_key = private$..api_key,
                                  workspace = private$..workspace)
        private$..text <- c(private$..text,
                            paste0("<b>You:</b> ", text),
                            paste0("<b>Chatbot:</b> ", response$text))
      }
      private$..context <- response$context
    },

    print = function(...) {
      cat(private$..text,sep="\n")
    }
  )

)
