## Calculate bearing and next point in order to extend the line in Tanzania
library(geosphere)
library(sf)

## These are the last two points of line id 3635. See sliver_fix_tanzania.sql
puntoB <- c(43.2740488941736, -7.73629775300242)
puntoA <- c(43.2751282504547, -7.73441057198409)

# Calculate the bearing
bearing(puntoA, puntoB)

# Calculate next point 0.5m away from last point
destPoint(puntoB, bearing(puntoA, puntoB), 0.5)

# lon                lat
# 43.274046648194997 -7.736301679945818
# Use this point in sliver_fix_tanzania.sql
