## Script to query and save lines around Svalbard on different layers in a loop
library(RPostgreSQL)
library(mapview) # For visualization only
library(dplyr)
library(sf)

# Connect to MarineRegions postgre database
pg = dbDriver("PostgreSQL")
con = dbConnect(pg, 
                user = "myuser", 
                password = "mypassword",
                host = "myhost", 
                port = 5432, 
                dbname = "MarineRegions")

# Query lines around Svalbard
qry <- "
  SELECT *, ST_AsText(the_geom) AS geom 
  FROM public.eez_boundaries
  WHERE line_id IN (3711, 3703, 3699, 2056, 2055, 2054, 1119, 1118)
"

# Transform to simple feature
eez_boundaries <- dbGetQuery(con, qry
            ) %>% select(-the_geom
            ) %>% st_as_sf(wkt = "geom", crs = 4326)

# Check visually
mapview(eez_boundaries)

# Save in a loop - Attention to the working directory
for (i in 1:nrow(eez_boundaries)){
  layer <- eez_boundaries[i, ]
  file_name <- paste0("eez_boundaries_", as.character(eez_boundaries$line_id[i]), ".gpkg")
  st_write(layer, file.path("sliver_fix", "svalbard", file_name), delete_dsn = TRUE, delete_layer = TRUE) 
}
