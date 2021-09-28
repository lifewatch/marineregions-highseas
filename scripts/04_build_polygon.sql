/* 
***********************************
	Development high seas product v1
	04_build_polygon.sql
	Run in pgadmin 4.4
	salvadorf 2020-05-11
************************************* 
*/

-- 10. Remove id
ALTER TABLE public.high_seas_03
	DROP COLUMN IF EXISTS id;

-- 11. Create table to insert geometries
CREATE TABLE high_seas_04(the_geom geometry);

-- 12. Rebuild polygons in a loop
DO $$
BEGIN
   FOR n IN 1..(SELECT COUNT(DISTINCT pol_id) FROM public.high_seas_03) LOOP
   
		WITH lines AS (
			SELECT pol_id, ring_id, ST_ForceClosed(ST_MakeLine(the_geom ORDER BY sort_id)) AS the_geom
			FROM public.high_seas_03
			WHERE pol_id = n
			GROUP BY pol_id, ring_id
		), outer_ring AS (
			SELECT the_geom
			FROM lines
			WHERE ring_id = 1
		), inner_ring AS (
			SELECT the_geom
			FROM lines
			WHERE ring_id > 1
		), high_seas_n AS (
			 SELECT CASE WHEN (SELECT COUNT(*) FROM inner_ring) > 0 
					THEN ST_MakePolygon((SELECT the_geom FROM outer_ring), (SELECT ARRAY(SELECT * FROM inner_ring)))
					ELSE ST_MakePolygon((SELECT the_geom FROM outer_ring))
					END AS the_geom
		)
		INSERT INTO public.high_seas_04
		SELECT the_geom FROM high_seas_n;
		
   END LOOP;
END; $$