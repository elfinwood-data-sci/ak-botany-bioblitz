SELECT scientific_name, count(name_accepted) --, non_native
--observed_on::date, count(name_accepted)
--level, habit, native, non_native, state_rank, global_rank, federal_listing, geom, observed_on_string, observed_on, time_observed_at, time_zone, user_id, user_login, created_at, updated_at, quality_grade, license, url, image_url, sound_url, tag_list, description, num_identification_agreements, num_identification_disagreements, captive_cultivated, oauth_application_id, place_guess, latitude, longitude, positional_accuracy, private_place_guess, private_latitude, private_longitude, public_positional_accuracy, geoprivacy, taxon_geoprivacy, coordinates_obscured, positioning_method, positioning_device, species_guess, scientific_name, common_name, iconic_taxon_name, taxon_id, taxon_family_name, taxon_genus_name, taxon_species_name, taxon_subspecies_name, taxon_variety_name, high_quality_location_data
	FROM bioblitz.ak_bioblitz_analysis_2022_view
	--WHERE observed_on IS NOT NULL 
WHERE 	quality_grade IN ('research') 
AND name_accepted  IN ('NO MATCH')
--ANd state_rank IS NOT NULL
--AND non_native IS TRUE
 --AND habit IN ('Moss','Lichen','Liverwort','Hornwort')
 GROUP BY scientific_name --,state_rank
 ORDER BY count(name_accepted) DESC ---count(name_accepted) DESC
-- GROUP BY observed_on::date
-- HAVING count(name_accepted) > 490
-- ORDER BY --observed_on::date 
-- count(name_accepted) DESC
 