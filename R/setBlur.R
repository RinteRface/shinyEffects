#' Custom blur animation
#'
#' Allow to apply a blur effect on a given element.
#'
#' @param intensity Blur intensity.
#'
#' @export
#'
#' @examples
#'  if (interactive()) {
#'
#'   library(shiny)
#'   library(shinydashboard)
#'   library(shinydashboardPlus)
#'   library(shinyEffects)
#'
#'   boxTag <- box(
#'    title = "A box",
#'    status = "warning",
#'    solidHeader = FALSE,
#'    collapsible = TRUE,
#'    p("Box Content")
#'   )
#'
#'   shinyApp(
#'    ui = dashboardPage(
#'      header = dashboardHeader(),
#'      sidebar = dashboardSidebar(),
#'      body = dashboardBody(
#'       setBlur(),
#'       fluidRow(blurContainer(boxTag), boxTag)
#'      ),
#'      controlbar = dashboardControlbar(),
#'      title = "DashboardPage"
#'    ),
#'    server = function(input, output) { }
#'   )
#' }
setBlur <- function(intensity = 2) {

  css <- paste0(
    "* {
      margin: 0;
      padding: 0;
      overflow: hidden;
     }

     .blur {
       -webkit-transition: all .25s ease;
       -moz-transition: all .25s ease;
       -o-transition: all .25s ease;
       -ms-transition: all .25s ease;
       transition: all .25s ease;
     }

     .blur:hover {
       -webkit-filter: blur(15px);
       -moz-filter: all .25s ease;
       -o-filter: all .25s ease;
       -ms-filter: all .25s ease;
       filter: blur(", intensity, "px);
     }
    "
  )

  # wrap everything in the head
  htmltools::tags$head(
    htmltools::tags$style(css)
  )
}



#' Blur container
#'
#' Allow to apply a blur effect on a given element.
#'
#' @param tag Element to apply the blur effect.
#'
#' @export
blurContainer <- function(tag) {
  if (length(tag) == 2) {
    tag[[2]]$attribs$class <- paste0(tag[[2]]$attribs$class, " blur")
    return(tag)
  } else {
    tag$attribs$class <- paste0(tag$attribs$class, " blur")
    return(tag)
  }
}
