#' shinyEffects
#'
#' Use only if you need shinyEffects on the server side
#'
#' @examples
#' library(shiny)
#'
#' ui <- fluidPage(
#'   use_effects(), # dependencies
#'
#'   actionButton("show", "Show loading for 5 seconds")
#' )
#'
#' server <- function(input, output, session){
#'   waiter_hide() # will hide *on_load waiter
#'
#'   observeEvent(input$show, {
#'
#'   })
#' }
#'
#' if(interactive()) shinyApp(ui, server)
#'
#' @import shiny
#' @export
use_effects <- function() {
  singleton(
    tags$head(
      tags$script(
        src = system.file("js/shinyeffects.js", package = "shinyEffects")
      ),
      tags$link(
        href = system.file("css/shinyeffects.css", package = "shinyEffects"),
        rel = "stylesheet",
        type = "text/css"
      )
    )
  )
}
