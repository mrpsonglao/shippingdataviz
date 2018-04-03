# Define UI for application
summary_stats <- fluidRow(
  titlePanel("Product Flow Explorer"),
  valueBoxOutput("value1")
  ,valueBoxOutput("value2")
  ,valueBoxOutput("value3")
)

prodbody <- fluidRow(
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectizeInput(
        'e6', "Explore the flow of one or more product categories:", choices = hscode_names,
        multiple = TRUE,
        options = list(
          placeholder = 'Type or click to select one or more categories',
          onInitialize = I('function() { this.setValue(""); }'), 
                           maxOptions = 10)
        )
      )
    ,
    
    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput("plot")
    )
  )
)

networkbody <- fluidRow(
  # Application title
  titlePanel("Select a Country to show its supply chain network:"),

  # Show a plot of the generated distribution
  fillPage(
    plotlyOutput("flowmap")
  )
)

dashboardPage(
  dashboardHeader(title = "US Bills of Lading Explorer"),
  dashboardSidebar(sidebarMenu(
    menuItem("Product View", tabName = "product", icon = icon("dashboard")),
    menuItem("Country Network", tabName = "network", icon = icon("th")),
    menuItem("Country Comparison", tabName = "comparison", icon = icon("th")),
    menuItem("Background", tabName = "bg", icon = icon("th"))
  )),
  dashboardBody(
    
    tabItems(
      # First tab content
      tabItem(tabName = "product",
              summary_stats, 
              prodbody
      ),
      
      # Second tab content
      tabItem(tabName = "network",
              networkbody
      ),
      
      # Second tab content
      tabItem(tabName = "comparison",
              h4("Select two or more countries to show how they interconnect:")
      ),
      
      # Second tab content
      tabItem(tabName = "bg",
              h4("Data Processing background information:")
      )
    )
  )
)