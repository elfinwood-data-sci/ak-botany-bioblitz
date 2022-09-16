SELECT id, bbcrv.name_accepted, level, habit, native, non_native, state_rank, global_rank, federal_listing,
		observed_on_string, observed_on, time_observed_at, time_zone, user_id, user_login, created_at, updated_at, quality_grade, license, url, image_url, sound_url, tag_list, description, num_identification_agreements, num_identification_disagreements, captive_cultivated, oauth_application_id, place_guess, latitude, longitude, positional_accuracy, private_place_guess, private_latitude, private_longitude, public_positional_accuracy, geoprivacy, taxon_geoprivacy, coordinates_obscured, positioning_method, positioning_device, species_guess, scientific_name, common_name, iconic_taxon_name, taxon_id, bb.taxon_family_name, taxon_genus_name, taxon_species_name, taxon_subspecies_name, taxon_variety_name, high_quality_location_data
	FROM bioblitz.ak_bioblitz_import AS bb
	JOIN bioblitz.ak_bioblitz_taxonomy_crossref_2022_view AS bbcrv USING (scientific_name)
	LEFT JOIN public.flora_of_alaska_view AS foav USING (name_accepted)
	WHERE quality_grade = 'research' AND name_accepted NOT IN ('NO MATCH') --6741
		AND habit IS NULL 
		ORDER BY name_accepted
		

/*
Add to flora of AK taxon accepted table and child tables
'Xanthidium octocorne'
'Micrasterias truncata'
'Cotoneaster lucidus'
'Cotoneaster lucidus'
'Syringa vulgaris'
'Syringa vulgaris'
'Ulva intestinalis'
'Picea pungens'
'Cotoneaster lucidus'
'Spiraea japonica'
'Lysimachia punctata'
'Cotoneaster lucidus'
'Tropaeolum majus'
'Solanum tuberosum'
'Ulva intestinalis'
'Trentepohlia aurea'
*/