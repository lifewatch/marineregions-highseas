/* 
***********************************
	Development high seas product v1
	00_merge_land.sql
	Run in pgadmin 4.4
	salvadorf 2020-05-11
************************************* 
*/

-- 1. Merge all the countries in EEZ_Land. Takes around 1h.
CREATE TABLE high_seas_00 (the_geom geometry);

INSERT INTO public.high_seas_00
SELECT CASE WHEN ST_isValid(the_geom) = FALSE THEN ST_MakeValid(the_geom) ELSE the_geom END AS the_geom
FROM (
	SELECT ST_Union(the_geom) AS the_geom 
		FROM (
			SELECT the_geom 
			FROM public.eez_land
	) AS Q1
) AS Q2;