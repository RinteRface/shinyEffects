#' Custom zoom
#'
#' Allow to apply a zoom on a given element.
#'
#' @param id Use this argument if you want to target an individual element.
#' @param class The element to which the zoom should be applied.
#' For example, class is set to box.
#' @param scale Zoom scale. 1.05 by default (5\% bigger than the normal). We do not
#' recommand using higher values, except in some particular cases.
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
#'
#'       setZoom(class = "box"),
#'       setZoom(id = "my-progress"),
#'
#'       tags$h2("Add zoom to the box class"),
#'       fluidRow(boxTag, boxTag),
#'       tags$h2("Add zoom only to the first element using id"),
#'       tagAppendAttributes(
#'        progressBar(
#'         value = 10,
#'         striped = TRUE,
#'         animated = TRUE,
#'         vertical = TRUE
#'        ),
#'        id = "my-progress"
#'       ),
#'       progressBar(
#'        value = 50,
#'        status = "warning",
#'        size = "xs",
#'       )
#'      ),
#'      controlbar = dashboardControlbar(),
#'      title = "DashboardPage"
#'    ),
#'    server = function(input, output) { }
#'   )
#' }
setZoom <- function(id = NULL, class = NULL, scale = 1.05) {

  # zoom css
  cssZoom <- paste0(
    " transition: transform .2s; /* Animation */
   ")

  cssZoom <- if (!is.null(id)) {
    if (!is.null(class)) {
      paste0("#", id, " .", class, ":hover {", cssZoom, "}")
    } else {
      paste0("#", id, " {", cssZoom, "}")
    }
  } else {
    if (!is.null(class)) {
      paste0(".", class, " {", cssZoom, "}")
    } else {
      NULL
    }
  }

  # hover effect css
  cssHover <- paste0("transform: scale(", scale, ");
  /* (x% zoom - Note: if the zoom is too large,
  it will go outside of the viewport)
  */")


  cssHover <- if (!is.null(id)) {
    if (!is.null(class)) {
      paste0("#", id, ":hover .", class, ":hover {", cssHover, "}")
    } else {
      paste0("#", id, ":hover", " {", cssHover, "}")
    }
  } else {
    if (!is.null(class)) {
      paste0(".", class, ":hover", " {", cssHover, "}")
    } else {
      NULL
    }
  }

  css <- paste(cssZoom, cssHover)

  # wrap everything in the head
  htmltools::tags$head(
    htmltools::tags$style(css)
  )
}

