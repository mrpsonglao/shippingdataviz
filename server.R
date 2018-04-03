function(input, output, session) {
  
  #creating the valueBoxOutput content
  output$value1 <- renderValueBox({
    valueBox(
      formatC(dim(df_address_bol)[1], format="d", big.mark=',')
      ,'Total Number of Unique Ports'
      ,icon = icon("screenshot",lib='glyphicon')
      ,color = "purple")  
  })
  output$value2 <- renderValueBox({ 
    valueBox(
      formatC(sum(df_portpairs$cnt), format="d", big.mark=',')
      ,'Total number of port-to-port transactions'
      ,icon = icon("transfer",lib='glyphicon')
      ,color = "green")  
  })
  output$value3 <- renderValueBox({
    valueBox(
      formatC(dim(df_portpairs)[1], format="d", big.mark=',')
      ,'Number of unique port-to-port transactions'
      ,icon = icon("stats",lib='glyphicon')
      ,color = "yellow")   
  })
  output$plot <- renderPlotly({
    # creating dashbody content
    
    geo <- list(
      scope = 'world',
      projection = list(type = 'mercator'),
      showland = TRUE,
      landcolor = 'rgb(243, 243, 243)',
      countrycolor = 'rgb(204, 204, 204)'
    )
    m <- list(l = 0, r = 0,
              b = 0, t = 40,
              pad = 0)
    
    g <- plot_geo() %>%
      add_segments(
        data = df_portpairs,
        x = ~start_lon, xend = ~end_lon,
        y = ~start_lat, yend = ~end_lat,
        alpha = 0.1, opacity = ~cnt_pct, size = I(1), hoverinfo = "text",
        color=I('blue'), text = ~text) %>%
      add_markers(data =df_address_bol, x = ~geometry.location.lng,
                  y = ~geometry.location.lat,
                  # split = ~country,
                  size = ~number_of_transactions,
                  text = ~original_BOL_address,
                  hoverinfo='text',
                  alpha = 0.7, color=I('blue')) %>%
      layout(
        title = 'US Bills of Lading 2014-2017 Transactions',
        showlegend = FALSE, 
        geo = geo,
        margin = m
      )
    })
  
  output$flowmap <- renderPlotly({
    # creating dashbody content
    
    p <- plot_mapbox(mode = 'scattermapbox') %>%
      add_segments(
        data = df_portpairs,
        x = ~start_lon, xend = ~end_lon,
        y = ~start_lat, yend = ~end_lat,
        alpha = 0.03, opacity = ~cnt_pct, size = I(1), hoverinfo = "text",
        color=I("black"), text = ~text) %>%
      add_markers(data =df_address_bol, x = ~geometry.location.lng,
                  y = ~geometry.location.lat,
                  split = ~country,
                  size = ~number_of_transactions,
                  text = ~original_BOL_address,
                  hoverinfo='text',
                  alpha = 0.7) %>%
      layout(title='US Bills of Lading 2014-2017 Transactions',
             autosize=TRUE,
             hovermode='closest',
             showlegend=FALSE,
             mapbox = list(style = 'light',
                           accesstoken=mapbox_access_token,
                           bearing=0,
                           center=list(
                             lat=38,
                             lon=-94
                           ),
                           pitch=0,
                           zoom=2),
             legend = list(orientation = 'h',
                           font = list(size = 8)),
             margin = list(l = 0, r = 0,
                           b = 0, t = 40,
                           pad = 0))
    
  })

}