library(shiny)
library(shinyEffects)
library(bs4Dash)

boxTag <- box(
  title = "Box with zoom Effect",
  closable = TRUE,
  label = boxLabel(
    text = 1,
    status = "danger",
  ),
  status = "warning",
  solidHeader = FALSE,
  collapsible = TRUE,
  p("Box Content")
)

btnTag <- appButton(
  inputId = "myAppButton",
  label = "Users",
  icon = icon("users"),
  dashboardBadge(textOutput("btnVal"), color = "primary")
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
      icon = icon("gears"),
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
    timelineStart(color = "purple")
  )
)

shinyApp(
  ui = dashboardPage(
    dashboardHeader(),
    dashboardSidebar(),
    dashboardBody(
      setZoom(class = "card"),
      setPulse(class = "badge"),
      setShadow(class = "btn-app"),
      h1("Set group effects using class"),
      h3("Zoom Effet"),
      fluidRow(boxTag),
      h3("Pulse Effect"),
      br(),
      uiOutput("badgeTag"),
      h3("Shadow Effect"),
      br(),
      fluidRow(btnTag),
      h1("Set individual effects using id"),
      br(),
      setShake(id = "my-timeline"),
      setZoom(id = "my-pill"),
      h3("Shake Effect"),
      br(),
      fluidRow(tagAppendAttributes(timelineTag, id = "my-timeline"), timelineTag)
    )
  ),
  server = function(input, output) {
    output$btnVal <- renderText(input$myAppButton)

    output$badgeTag <- renderUI({
      invalidateLater(1000)
      lapply(1:4, dashboardBadge, color = "warning")
    })
  }
)
