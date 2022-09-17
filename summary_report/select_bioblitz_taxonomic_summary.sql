WITH d AS (SELECT ogc_fid, id, name_accepted, bb.level, bb.habit, bb.native, bb.non_native, state_rank, global_rank, federal_listing, geom, 
--accepted_family,
observed_on_string, observed_on, time_observed_at, time_zone, user_id, user_login, created_at, updated_at, quality_grade, 
license, url, image_url, sound_url, tag_list, description, num_identification_agreements, num_identification_disagreements, 
captive_cultivated, oauth_application_id, place_guess, latitude, longitude, positional_accuracy, private_place_guess, 
private_latitude, private_longitude, public_positional_accuracy, geoprivacy, taxon_geoprivacy, coordinates_obscured, 
positioning_method, positioning_device, species_guess, scientific_name, common_name, iconic_taxon_name, taxon_id, 
taxon_family_name, taxon_genus_name, taxon_species_name, taxon_subspecies_name, taxon_variety_name, high_quality_location_data
	FROM bioblitz.ak_bioblitz_analysis_2022_view AS bb --6741
	--LEFT JOIN public.flora_of_ak_accepted_join_adjudicated_view v USING (name_accepted)
	WHERE name_accepted NOT IN ('NO MATCH','ABOVE SPECIES') AND
quality_grade = 'research'
		   AND bb.habit IN ('Moss','Liverwort') AND level NOT IN ('genus','unknown'))

SELECT name_accepted  FROM d
GROUP BY name_accepted
ORDER BY name_accepted

--90 vasular families represented in the bioblitz data
-- 321 vascular genera
-- 644 species, subspecies, varieties

-- 16 bryophyte families
-- 21 genera
-- 24 species

-- lichens weren't included in the project