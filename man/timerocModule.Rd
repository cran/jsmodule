% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/timeroc.R
\name{timerocModule}
\alias{timerocModule}
\alias{timerocModule2}
\title{timerocModule: shiny module server for time-dependent roc analysis}
\usage{
timerocModule(
  input,
  output,
  session,
  data,
  data_label,
  data_varStruct = NULL,
  nfactor.limit = 10,
  design.survey = NULL,
  id.cluster = NULL,
  iid = T,
  NRIIDI = T
)

timerocModule2(
  input,
  output,
  session,
  data,
  data_label,
  data_varStruct = NULL,
  nfactor.limit = 10,
  design.survey = NULL,
  id.cluster = NULL,
  iid = T,
  NRIIDI = T
)
}
\arguments{
\item{input}{input}

\item{output}{output}

\item{session}{session}

\item{data}{Reactive data}

\item{data_label}{Reactuve data label}

\item{data_varStruct}{Reactive List of variable structure, Default: NULL}

\item{nfactor.limit}{nlevels limit in factor variable, Default: 10}

\item{design.survey}{Reactive survey data. default: NULL}

\item{id.cluster}{Reactive cluster variable if marginal model, Default: NULL}

\item{iid}{logical, get CI of AUC, Default: T}

\item{NRIIDI}{logical, get NRI & IDI, Default: T}
}
\value{
shiny module server for time-dependent roc analysis

shiny module server for time dependent roc analysis- input number of model as integer
}
\description{
shiny module server for time-dependent roc analysis

shiny module server for time-dependent roc analysis- input number of model as integer
}
\details{
shiny module server for time-dependent roc analysis

shiny module server for time dependent roc analysis- input number of model as integer
}
\examples{
library(shiny)
library(DT)
library(data.table)
library(jstable)
library(ggplot2)
library(timeROC)
library(survIDINRI)
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      timerocUI("timeroc")
    ),
    mainPanel(
      plotOutput("plot_timeroc"),
      ggplotdownUI("timeroc"),
      DTOutput("table_timeroc")
    )
  )
)

server <- function(input, output, session) {
  data <- reactive(mtcars)
  data.label <- jstable::mk.lev(mtcars)

  out_timeroc <- callModule(timerocModule, "timeroc",
    data = data, data_label = data.label,
    data_varStruct = NULL
  )

  output$plot_timeroc <- renderPlot({
    print(out_timeroc()$plot)
  })

  output$table_timeroc <- renderDT({
    datatable(out_timeroc()$tb,
      rownames = F, editable = F, extensions = "Buttons",
      caption = "ROC results",
      options = c(jstable::opt.tbreg("roctable"), list(scrollX = TRUE))
    )
  })
}
library(shiny)
library(DT)
library(data.table)
library(jstable)
library(ggplot2)
library(timeROC)
library(survIDINRI)
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      timerocUI("timeroc")
    ),
    mainPanel(
      plotOutput("plot_timeroc"),
      ggplotdownUI("timeroc"),
      DTOutput("table_timeroc")
    )
  )
)

server <- function(input, output, session) {
  data <- reactive(mtcars)
  data.label <- jstable::mk.lev(mtcars)

  out_timeroc <- callModule(timerocModule2, "timeroc",
    data = data, data_label = data.label,
    data_varStruct = NULL
  )

  output$plot_timeroc <- renderPlot({
    print(out_timeroc()$plot)
  })

  output$table_timeroc <- renderDT({
    datatable(out_timeroc()$tb,
      rownames = F, editable = F, extensions = "Buttons",
      caption = "ROC results",
      options = c(jstable::opt.tbreg("roctable"), list(scrollX = TRUE))
    )
  })
}
}
\seealso{
\code{\link[stats]{quantile}}
 \code{\link[data.table]{setkey}}
 \code{\link[data.table]{data.table}}
 \code{\link[data.table]{rbindlist}}

\code{\link[stats]{quantile}}
 \code{\link[data.table]{setkey}}
 \code{\link[data.table]{data.table}}
 \code{\link[data.table]{rbindlist}}
}
