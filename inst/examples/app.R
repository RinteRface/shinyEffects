library(shiny)
library(shinyEffects)
library(shinydashboard)
library(shinydashboardPlus)

setShadow <- shinyEffects::setShadow
setPulse <- shinyEffects::setPulse
setShake <- shinyEffects::setShake
setZoom <- shinyEffects::setZoom

boxTag <- boxPlus(
  title = "Box with zoom Effect",
  closable = TRUE,
  enable_label = TRUE,
  label_text = 1,
  label_status = "danger",
  status = "warning",
  solidHeader = FALSE,
  collapsible = TRUE,
  p("Box Content")
)

btnTag <- appButton(
  url = "http://google.com",
  label = "Users",
  icon = "fa fa-users",
  enable_badge = TRUE,
  badgeColor = "purple",
  badgeLabel = 891
)

timelineTag <- column(
  width = 6,
  align = "center",
  timelineBlock(
    reversed = FALSE,
    timelineEnd(color = "danger"),
    timelineLabel(2018, color = "teal"),
    timelineItem(
      title = "Item 1",
      icon = "gears",
      color = "olive",
      time = "now",
      footer = "Here is the footer",
      "This is the body"
    ),
    timelineItem(
      title = "Item 2",
      border = FALSE
    ),
    timelineLabel(2015, color = "orange"),
    timelineStart(color = "gray")
  )
)

pillTag <- navPills(
  navPillsItem(
    active = TRUE,
    pillName = "Item 1",
    pillColor = "green",
    pillIcon = NULL,
    pillText = "Some text here"
  ),
  navPillsItem(
    pillName = "Item 2",
    pillColor = "red",
    pillIcon = "fa fa-angle-down",
    pillText = "10%"
  )
)


shinyApp(
  ui = dashboardPagePlus(
    dashboardHeaderPlus(),
    dashboardSidebar(),
    dashboardBody(
      setZoom(class = "box"),
      setPulse(class = "label"),
      setShadow(class = "btn-app"),
      h1("Set group effects using class"),
      h3("Zoom Effet"),
      fluidRow(boxTag, boxTag),
      h3("Pulse Effect"),
      br(),
      uiOutput("badgeTag"),
      h3("Shadow Effect"),
      br(),
      fluidRow(btnTag, btnTag, btnTag),
      h1("Set individual effects using id"),
      br(),
      setShake(id = "my-timeline"),
      setZoom(id = "my-pill"),
      h3("Shake Effect"),
      br(),
      fluidRow(tagAppendAttributes(timelineTag, id = "my-timeline"), timelineTag),
      h3("Zoom Effect"),
      br(),
      fluidRow(
        column(width = 6, pillTag),
        column(width = 6, tagAppendAttributes(pillTag, id = "my-pill"))
      )
    )
  ),
  server = function(input, output) {
    output$badgeTag <- renderUI({
      invalidateLater(1000)
      lapply(1:4, dashboardLabel, status = "warning")
    })
  }
)
