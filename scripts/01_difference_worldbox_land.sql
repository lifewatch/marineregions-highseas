/* 
***********************************
	Development high seas product v1
	01_difference_worldbox_land.sql
	Run in pgadmin 4.4
	salvadorf 2020-05-11
************************************* 
*/

-- 2. Create an empty table where we will store the geometry
CREATE TABLE high_seas_01 (the_geom geometry);

-- 3. Create a box of the world. 
WITH world_box AS (
	SELECT ST_GeomFromText('POLYGON ((-180 -90, 180 -90, 180 90, -180 90, -180 -90))', 4326) AS the_geom
-- 4. Compute the difference between high_seas_union and the worldBox. 
), high_seas_1 AS (
	SELECT ST_Difference(
		(SELECT the_geom FROM world_box),
		(SELECT the_geom FROM public.high_seas_00)
	) AS the_geom
-- 5. Split multipart in singleparts 
), high_seas_2 AS (
	SELECT (ST_Dump(the_geom)).geom AS the_geom 
	FROM high_seas_1
)
-- 6. Save
INSERT INTO public.high_seas_01
SELECT * FROM high_seas_2;