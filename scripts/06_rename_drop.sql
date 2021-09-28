/* 
***********************************
	Development high seas product v1
	06_rename_drop.sql
	Run in pgadmin 4.4
	salvadorf 2020-07-09
************************************* 
*/

-- 14. Once checked that everything is ok in high_seas_04, rename this table to 'high_seas' and drop temporal tables
DROP TABLE high_seas_00;
DROP TABLE high_seas_01;
DROP TABLE high_seas_02;
DROP TABLE high_seas_03;
DROP TABLE high_seas_04;

ALTER TABLE public.high_seas_05
	RENAME TO high_seas;

DO $$ BEGIN 
RAISE NOTICE '%',CONCAT('High seas product finalized as public.high_seas at ', NOW()); 
END; 
$$;