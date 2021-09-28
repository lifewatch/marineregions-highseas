/* 
***********************************
	Development high seas product v1
	05_union_attributes.sql
	Run in pgadmin 4.4
	salvadorf 2020-07-09
************************************* 
*/

-- 12. After Fixing the slivers (see confluence), create a new table high_seas_05 and put inside the union of high_seas_04 geometry

CREATE TABLE high_seas_05(the_geom geometry);

INSERT INTO high_seas_05
	SELECT ST_Union(the_geom) AS the_geom
	FROM high_seas_04;

-- 13. Add attributes to the table
ALTER TABLE high_seas_05
	ADD COLUMN name VARCHAR,
	ADD COLUMN mrgid INTEGER,
	ADD COLUMN source VARCHAR;

UPDATE high_seas_05
	SET name = 'High Seas', 
	    mrgid = 63203, 
	    source = 'https://marineregions.org/eezmethodology.php'
