/* This script elongates the eez_boundaries.line_id = 3635 in order to overlap completely the polygon in high_seas_04 gid = 1 and fix the sliver present near Tanzania. 
   The first two points of the line were checked with ST_DumpPoints in line 11 and they were used in the script sliver_fix_tanzania_elongate_line.R to calculate an extra point to elongate the line.
   This is the point indicated here as 43.274046648194997, -7.736301679945818 in line 8
*/
CREATE TABLE high_seas_04_line_extended AS
SELECT ST_MakeLine(point_geom ORDER BY path) AS the_geom
FROM (
		SELECT 0::INT AS path, ST_SetSRID(ST_Point(43.274046648194997, -7.736301679945818),4326) AS point_geom
	UNION
		SELECT BTRIM((ST_DumpPoints(line)).path::VARCHAR, '{}')::INT AS path, 
			   (ST_DumpPoints(line)).geom AS point_geom
		FROM (
			SELECT (ST_Dump(the_geom)).geom AS line 
			FROM eez_boundaries
			WHERE line_id = 3635 
		) AS foo
) AS foo2
WHERE path < 7 -- checked with ST_Contains() on dumped points. The point 5 is the last point inside the polygon high_seas_04 where gid = 1.
;

-- Now we split the polygon conaining the sliver near Tanzania and save the final polygon in high_seas_tanzania
CREATE TABLE public.high_seas_tanzania AS 
	SELECT BTRIM((ST_Dump(the_geom)).path::VARCHAR, '{}')::INT AS gid, 
		   (ST_Dump(the_geom)).geom AS the_geom
	FROM (
		SELECT ST_Split(
				(SELECT the_geom FROM high_seas_04 WHERE gid = 1),
				(SELECT the_geom FROM high_seas_04_line_extended)
				   ) AS the_geom
	) AS T1;

-- Remove the part that we do not need
DELETE FROM public.high_seas_tanzania WHERE gid = 2;