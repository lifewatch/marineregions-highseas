/* 
***********************************
	Development high seas product v1
	03_remove_spikes.sql
	Run in pgadmin 4.4
	salvadorf 2020-05-12
************************************* 
*/

-- 9. Open high_seas_03 in QGIS and remove manually points causing spikes.
DO $$ BEGIN 
RAISE NOTICE '%','Layer containing the vertices of the High Seas polygons saved as high_seas_03. Please open this layer in QGIS, remove points causing spikes and update layer.'; 
RAISE NOTICE '%','Open this link for further information: https://docs.qgis.org/3.16/en/docs/user_manual/managing_data_source/opening_data.html?highlight=postgres#creating-a-stored-connection';
END; 
$$;


