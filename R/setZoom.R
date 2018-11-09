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
#'   boxTag <- boxPlus(
#'    title = "Closable box, with label",
#'    closable = TRUE,
#'    enable_label = TRUE,
#'    label_text = 1,
#'    label_status = "danger",
#'    status = "warning",
#'    solidHeader = FALSE,
#'    collapsible = TRUE,
#'    p("Box Content")
#'   )
#'
#'   shinyApp(
#'    ui = dashboardPagePlus(
#'      header = dashboardHeaderPlus(
#'        enable_rightsidebar = TRUE,
#'        rightSidebarIcon = "gears"
#'      ),
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
#'        verticalProgress(
#'         value = 10,
#'         striped = TRUE,
#'         active = TRUE
#'        ),
#'        id = "my-progress"
#'       ),
#'       verticalProgress(
#'         value = 50,
#'         active = TRUE,
#'         status = "warning",
#'         size = "xs"
#'       ),
#'       verticalProgress(
#'         value = 20,
#'         status = "danger",
#'         size = "sm",
#'         height = "60%"
#'       )
#'      ),
#'      rightsidebar = rightSidebar(),
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

