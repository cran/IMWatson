% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/init.R
\name{init}
\alias{init}
\title{Initialize connection with Watson's Conversation API}
\usage{
init(api_key, workspace, url, version)
}
\arguments{
\item{api_key}{API Key}

\item{workspace}{Workspace api}

\item{url}{optional argument that defaults to "https://gateway.watsonplatform.net/assistant/api/v1/workspaces"}

\item{version}{optional argument that defaults to "2018-09-20"}
}
\value{
The function returns a lits with the text and the contex that is returned by your assistant.
}
\description{
Connect to Watson's Conversation API
}
\details{
This function allows you to start a connection to your Watson Assistant
}
\examples{
if(interactive()){
# See https://cloud.ibm.com/apidocs/assistant
 conection <- init(api_key, workspace)
 conection[["text"]]
 chat1 <- chat("Ignacio", conection, username, password, workspace)
 chat1[["text"]]
 chat2 <- chat("I would like flower suggestions", chat1, username, password, workspace)
 chat2[["text"]]
 }
}
