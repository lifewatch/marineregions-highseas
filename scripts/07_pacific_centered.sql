/* 
***********************************
	Development Pacific-centered high seas product v1
	07_pacific_centered.sql
	Run in pgadmin 4.4
	brittl 2020-07-09
************************************* 
*/


-- 1. Create a duplicate table for working on the Pacific-centered product
CREATE TABLE high_seas_0_360_00 AS
TABLE high_seas;
 
-- 2. Clip the dataset to -180° - 180° (quality control step)
UPDATE high_seas_0_360_00
SET the_geom = ST_Multi(ST_Intersection(the_geom,ST_GeomFromText('MultiPolygon (((-180 90, 180 90, 180 -90, -180 -90, -180 90)))',4326)))
 
-- 3. Split the features on longitude = 0
UPDATE high_seas_0_360_00
SET the_geom = ST_CollectionExtract(ST_Split(the_geom, ST_MakeLine(ST_SetSRID(ST_MakePoint(0,90), 4326),ST_SetSRID(ST_MakePoint(0,-90), 4326))), 3)
 
-- 4. Shift features with longitude <0 to the east by 360 degrees
UPDATE high_seas_0_360_00
SET the_geom = ST_WrapX(the_geom, 0, 360)

-- 5. Create new table for dissolved geometry
CREATE TABLE high_seas_0_360_01 (the_geom geometry);

-- 5. Dissolve the resulting polygons
INSERT INTO high_seas_0_360_01
SELECT ST_UnaryUnion(the_geom) AS the_geom FROM high_seas_0_360_00
 
-- 6. Fix potential invalid geometry (quality control step)
UPDATE high_seas_0_360_01
SET the_geom=ST_CollectionExtract(ST_MakeValid(the_geom),3)
WHERE ST_IsValid(the_geom) = false;

-- 7. Check the final output, drop the temporary table and rename the final product
DROP TABLE high_seas_0_360_00;

ALTER TABLE high_seas_0_360_01
	RENAME TO high_seas_0_360;


DO $$ BEGIN 
RAISE NOTICE '%',CONCAT('High seas Pacific-centered product finalized as high_seas_0_360 at ', NOW()); 
END; 
$$;