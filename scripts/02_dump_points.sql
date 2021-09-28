/* 
***********************************
	Development high seas product v1
	02_dump_points.sql
	Run in pgadmin 4.4
	salvadorf 2020-05-11
************************************* 
*/


-- 7. Create an empty table to store points geometry
CREATE TABLE high_seas_02 (pol_id integer, ring_id integer, sort_id integer, the_geom geometry);

-- 8. Add identifiers for the polygon, the ring, and the sort field.
INSERT INTO public.high_seas_02
SELECT pol_id, path[1] AS ring_id, path[2] AS sort_id , geom AS the_geom
FROM (
	 SELECT pol_id, (ST_DumpPoints(the_geom)).*
	 FROM(
		 SELECT ROW_NUMBER() OVER () AS pol_id, *
		 FROM public.high_seas_01
	) AS T1
) AS T2;

-- 9. Duplicate table and add primary key (requirement to edit from QGIS).
CREATE TABLE public.high_seas_03 AS 
	TABLE public.high_seas_02;

ALTER TABLE public.high_seas_03 
	ADD COLUMN id SERIAL PRIMARY KEY;