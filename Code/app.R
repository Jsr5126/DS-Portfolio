ui <- fluidPage(
    titlePanel("JReese_HW4"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Bin Width:",
                        min = 0,
                        max = 20,
                        value = 1),
            sliderInput("start",
                        "Bin Start",
                        min = 0,
                        max = 100,
                        value = 1),
             selectInput(inputId = "bincolor",
                        label = "Fill Color:",
                        choices = choices = c("red1", "red2", "red3", "red4"),
                        selected = "red1"),
             selectInput(inputId = "bordercolor",
                        label = "Border Color:",
                        choices = choices = c("blue1", "blue2", "blue3", "blue4")),
                        selected = "red1")))
        checkboxInput(inputId = "addmean",
                          label = "Add Density?",
                          value = FALSE)
        mainPanel(
           plotOutput("Histogram"))

server <- function(input, output) {
    output$Histogram <- renderPlot({
        Histogram(QBR, bin_width=input$bins, 
                  bin_start=input$start, 
                  fill = input$bincolor, 
                  color = input$bordercolor, 
                  density=input$addmean)})}
shinyApp(ui = ui, server = server)
