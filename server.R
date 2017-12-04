
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

# Load data


level1 <- readOGR(dsn = "DATA/BotanicalCountries/level1/level1.shp")
level2 <- readOGR(dsn = "DATA/BotanicalCountries/level2/level2.shp")
level3 <- readOGR(dsn = "DATA/BotanicalCountries/level3/TDWG_level3_Coordinates.shp")
level4 <- readOGR(dsn = "DATA/BotanicalCountries/level4/level4.shp")

shinyServer(function(input, output) {
  

  output$mymap <- renderLeaflet({
    
    leaflet() %>%
      setView(lng = 0, lat = 0, zoom = 2)%>% 
      addProviderTiles(providers$Esri.WorldImagery, group = "Esri.WorldImagery") %>% 
      addProviderTiles(providers$OpenStreetMap, group = "OpenStreetMap") %>%
      addPolygons(data = level1, weight = 3, 
                  fill = FALSE,color = "white", group = "TDWG-Level1" ,
                  highlightOptions = highlightOptions(color = "white", weight = 2),
                  label = ~htmlEscape(level1$LEVEL1_NAM)) %>%
      addPolygons(data = level2, weight = 3, 
                  fillOpacity = 0.01,color = "white",  group = "TDWG-Level2" ,
                  highlightOptions = highlightOptions(color = "white", weight = 2),
                  label = ~htmlEscape(level2$LEVEL2_NAM)) %>%
      addPolygons(data = level3, weight = 3, 
                  fillOpacity = 0.01,color = c("white"),  group = "TDWG-Level3" ,
                  highlightOptions = highlightOptions(color = "white", weight = 2),
                  label = ~htmlEscape(level3$LEVEL_NAME)) %>%
      addPolygons(data = level4, weight = 3, 
                  fillOpacity = 0.01,color = ("white"),  group = "TDWG-Level4" ,
                  highlightOptions = highlightOptions(color = "white", weight = 2),
                  label = ~htmlEscape(level4$Level_4_Na))%>%
       # Layers control
      addLayersControl(
        overlayGroups = c("TDWG-Level1", "TDWG-Level2", "TDWG-Level3","TDWG-Level4"),
        baseGroups = c("Esri.WorldImagery", "OpenStreetMap"),
        options = layersControlOptions(collapsed = FALSE)
      ) %>%
      showGroup("TDWG-Level1") %>% 
      addMiniMap(toggleDisplay = TRUE) %>% 

      addEasyButton(easyButton(
        icon="fa-crosshairs", title="Locate Me",
        onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
  })

})
