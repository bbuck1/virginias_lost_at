library(tidyverse)
library(dplyr)
library(lubridate)
library(scales)
library(readr)
library(leaflet)
library(sf)
library(shiny)
library(distill)

va_shape<- read_sf("C:/Users/bpbuc/Documents/Brandan's Stuff/_PhD Stuff/RRCHNM_Projects/at_project/county_bound/20th_cen_VA_counties_aoi.shp")

roads<- read_sf("data/roads.shp")

va_cities<- va_shape %>% 
  filter(City == "Y")

va_county<- va_shape %>% 
  filter(City == "N")

nc_county<- read_sf("county_bound/20th_cen_NC_counties_aoi.shp")

at_map_points_site<- read.csv("data/at_map_points_site_2.csv")

at_trail_31<- read_sf("data/1931_at.shp")

at_trail_41<- read_sf("data/1941_at.shp")

at_trail_current<- read_sf("data/at_aoi/AT_aoi.shp")

pal <- colorFactor(c("orange","red", "blue"), domain = c("1931 AT", "1941 AT", "Current AT"))

leaflet(options = leafletOptions(maxZoom = 14, minZoom = 9)) %>% 
  addProviderTiles("Esri.WorldShadedRelief") %>% 
  addProviderTiles("Esri.WorldImagery", options = providerTileOptions(opacity = 0.50)) %>%
  setView(lng = -80.616, 
          lat = 37.83, 
          zoom = 9) %>%
  setMaxBounds(lng1 = -082.17,
               lat1 = 37.69,
               lng2 = -079.16,
               lat2 = 36.52) %>%
  addPolygons(data = va_county,
              color = 'black',
              weight = 2.0,
              opacity = 1.0,
              fillOpacity = 0.0,
              label =  ~as.character(NAME), 
              labelOptions = labelOptions(noHide = T, direction = 'bottom', textOnly = T, textsize = "12px"),               
              group = "County Boundaries") %>% 
  addPolygons(data = va_cities,
              color = 'black',
              fillOpacity = 0.0,               
              group = "County Boundaries") %>%
  addPolylines(data = nc_county,
               color = "black",
               opacity = 1.0,
               weight = 2.0,
               group = "County Boundaries") %>%
  addPolylines(data = at_trail_31,
               color = "orange",
               opacity = 1.0,
               dashArray = "8") %>%
  addPolylines(data = at_trail_41,
               color = "red",
               opacity = 1.0,
               dashArray = "8") %>%
  addPolylines(data = at_trail_current,
               opacity = 1.0,
               color = "blue",
               dashArray = "8") %>% 
  addMarkers(data = at_map_points_site,
             clusterOptions = markerClusterOptions(),
             popup = ~paste("<center> <h2>", namewithlink, "</center> </h2>", "<br>",
                            "<center>", thumbnail, "</center>", "<br>",
                            "<center>",snippet, "</center>"),
             group = "Points of Interest") %>% 
  addLayersControl(
    overlayGroups = c("County Boundaries", "Points of Interest"),
    options = layersControlOptions(collapsed = FALSE)) %>%
  addScaleBar(position = "bottomleft",
              options = scaleBarOptions(maxWidth = 200, imperial = TRUE,
                                        metric = FALSE, updateWhenIdle = TRUE)) %>% 
  addLegend(position = "bottomright",
            pal = pal,
            values = c("1931 AT","Current AT", "1941 AT"),
            title = "Trail Versions") %>% 
  addMiniMap(
    tiles = providers$OpenStreetMap.Mapnik,
    position = 'bottomleft', 
    width = 125, height = 125,
    toggleDisplay = TRUE)



leaflet(options = leafletOptions(maxZoom = 12, minZoom = 9)) %>% 
  addProviderTiles("Esri.WorldShadedRelief") %>% 
  addProviderTiles("Esri.WorldImagery", options = providerTileOptions(opacity = 0.50)) %>%
  setView(lng = -80.616, 
          lat = 37.83, 
          zoom = 9) %>%
  setMaxBounds(lng1 = -082.17,
               lat1 = 37.69,
               lng2 = -079.16,
               lat2 = 36.52) %>%
  addPolygons(data = va_county,
              color = 'black',
              weight = 2.0,
              fillOpacity = 0.0,
              label =  ~as.character(NAME), 
              labelOptions = labelOptions(noHide = T, direction = 'bottom', textOnly = T, textsize = "12px"),               
              group = "County Boundaries") %>% 
  addPolygons(data = va_cities,
              color = 'black',
              fillOpacity = 0.0,               
              group = "County Boundaries") %>%
  addPolylines(data = nc_county,
               color = "black",
               weight = 2.0,
               group = "County Boundaries") %>%
  addPolylines(data = at_trail_31,
               color = "orange",
               opacity = 1.0,
               dashArray = "8") %>%
  addPolylines(data = at_trail_41,
               color = "red",
               opacity = 1.0,
               dashArray = "8") %>%
  addPolylines(data = at_trail_current,
               opacity = 1.0,
               color = "blue",
               dashArray = "8") %>% 
  addMarkers(data = at_map_points_site,
             clusterOptions = markerClusterOptions(),
             popup = ~paste("<center> <h2>", namewithlink, "</center> </h2>", "<br>",
                            "<center>", thumbnail, "</center>", "<br>",
                            "<center>",snippet, "</center>"),
             group = "Points of Interest") %>% 
  addLayersControl(
    overlayGroups = c("County Boundaries", "Points of Interest"),
    options = layersControlOptions(collapsed = FALSE)) %>%
  addScaleBar(position = "bottomleft",
              options = scaleBarOptions(maxWidth = 250, imperial = TRUE,
                                        metric = FALSE, updateWhenIdle = TRUE)) %>% 
  addLegend(position = "bottomright",
            pal = pal,
            values = c("1931 AT","Current AT", "1941 AT"),
            title = "Trail Versions") %>% 
  addMiniMap(
    tiles = providers$OpenStreetMap.Mapnik,
    position = 'bottomleft', 
    width = 150, height = 150,
    toggleDisplay = TRUE)