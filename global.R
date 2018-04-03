# import required libraries
# packages <- c("shiny", "shinydashboard", "plotly", "DT")
# install.packages(packages)

require(shinydashboard)
require(shiny)
require(plotly)
require(DT)
require(dplyr)
# require(crosstalk)

# import datasets
df_portpairs <- read.csv("C:/Users/mrpso/Documents/GitHub/shippingdataviz/data/df_portpairs.csv")
df_address_bol <- read.csv("C:/Users/mrpso/Documents/GitHub/shippingdataviz/data/df_address_bol.csv")
df_portpairs$cnt_pct <- df_portpairs$cnt/max(df_portpairs$cnt)
df_hscodes <- read.csv("C:/Users/mrpso/Documents/GitHub/shippingdataviz/data/df_hscodes_in_bol.csv")
hscode_names <- df_hscodes$text

# prepare mapbox
Sys.setenv('MAPBOX_TOKEN' = 'pk.eyJ1IjoibXJwc29uZ2xhbyIsImEiOiJjamY4bTQ3YnczMWZ2MnlwbnJ3Y3VvZ292In0._wUqj1YIyVKL07CL3G7wlQ')

mapbox_access_token <- 'pk.eyJ1IjoibXJwc29uZ2xhbyIsImEiOiJjamY4bTQ3YnczMWZ2MnlwbnJ3Y3VvZ292In0._wUqj1YIyVKL07CL3G7wlQ'