#' Custom shake animation
#'
#' Allow to apply a shake animation on a given element.
#'
#' @param id Use this argument if you want to target an individual element.
#' @param class The element to which the shake should be applied.
#' For example, class is set to box.
#' @param duration Shake total duration. 0.82s by default.
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
#'       setShake(class = "box"),
#'       setShake(id = "my-progress"),
#'
#'       tags$h2("Add shake to the box class"),
#'       fluidRow(boxTag, boxTag),
#'       tags$h2("Add shake only to the first element using id"),
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
#'      title = "Shake Effect"
#'    ),
#'    server = function(input, output) { }
#'   )
#' }
setShake <- function(id = NULL, class = NULL, duration = 0.82) {

  # shake css
  cssShake <- paste0(
    "animation: shake ", duration ,"s cubic-bezier(.36,.07,.19,.97) both;
     transform: translate3d(0, 0, 0);
     backface-visibility: hidden;
     perspective: 1000px;
    "
  )

  cssHover <- if (!is.null(id)) {
    if (!is.null(class)) {
      paste0("#", id, ":hover .", class, ":hover {", cssShake, "}")
    } else {
      paste0("#", id, ":hover", " {", cssShake, "}")
    }
  } else {
    if (!is.null(class)) {
      paste0(".", class, ":hover", " {", cssShake, "}")
    } else {
      NULL
    }
  }

  # other CSS elements
  extracss <- paste0(
    "@keyframes shake {
      10%, 90% {
        transform: translate3d(-1px, 0, 0);
      }

      20%, 80% {
        transform: translate3d(2px, 0, 0);
      }

      30%, 50%, 70% {
        transform: translate3d(-4px, 0, 0);
      }

      40%, 60% {
        transform: translate3d(4px, 0, 0);
      }
     }
    "
  )

  css <- paste(cssHover, extracss)

  # wrap everything in the head
  htmltools::tags$head(
    htmltools::tags$style(css)
  )
}

