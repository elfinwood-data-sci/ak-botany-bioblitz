WITH pgeom AS (SELECT serial, id, user_login, lat_wgs84, long_wgs84, accuracy_m, coordinates_obscured, scientific_name,
	ST_SetSRID(ST_MakePoint(long_wgs84,lat_wgs84),4326) AS geom_point
	FROM public.ak_bioblitz),

aaarea AS (SELECT user_login, 
ST_CONVEXHULL(ST_COLLECT(geom_point)) AS geom_poly_by_user,
ST_AREA(ST_CONVEXHULL(ST_COLLECT(geom_point))) as area 
FROM pgeom
GROUP BY user_login)

SELECT * FROM aaarea ORDER BY area DESC