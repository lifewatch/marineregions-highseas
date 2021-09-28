# High Seas

This repository contains the scripts to create the version 1 of the High Seas product

## Getting started

* The naming of the scripts indicates the order in which they should be run (00* to 06*).

* There are some scripts used to solve an issue regarding spikes and slivers.
* Prerequisites: [PostgreSQL](https://www.postgresql.org/) and [PostGIS](https://postgis.net/), [QGIS v3](https://qgis.org/en/site/), [R v3.6](https://www.r-project.org/) or higher.
* It is assumed that you created a PostgreSQL database and you imported via `shp2pgsql` the following Marine Regions' products:
  * The Union World Countries Boundaries and Exclusive Economic Zones (v3) https://doi.org/10.14284/403. Name as: `eez_land`. 
  * Maritime Boundaries Geodatabase: Exclusive Economic Zones (200NM) (v11) https://doi.org/10.14284/386. Name as `eez_boundaries`.
* An overview of the workflow is available in the methodology page of the Marine Regions website: https://www.marineregions.org/eezmethodology.php

## Directory structure

```
High Seas/
├── scripts/
│   ├── 00_merge_land.sql
│   ├── 01_difference_worldbox_land.sql
│   ├── 02_dump_points.sql
│   ├── 03_remove_spikes.sql
│   ├── 04_build_polygon.sql
│   ├── 05_union_attributes.sql
│   ├── 06_rename_drop.sql
│   │
│   ├── sliver_fix_svalbard_export_lines.R
│   ├── sliver_fix_tanzania.sql
│   └── sliver_fix_tanzania_elongate_line.R
└── images/
    └── spikes_location.pdf

```

## More information

For any questions please send an email to: info@marineregions.org



