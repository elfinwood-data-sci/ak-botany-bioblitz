-- View: bioblitz.ak_bioblitz_analysis_2022_view

-- DROP VIEW bioblitz.ak_bioblitz_analysis_2022_view;

CREATE OR REPLACE VIEW bioblitz.ak_bioblitz_analysis_2022_view AS
WITH d AS (SELECT id, bbcrv.name_accepted, level, habit, native, non_native, state_rank, global_rank, federal_listing,
		observed_on_string, observed_on, time_observed_at, time_zone, user_id, user_login, created_at, updated_at, quality_grade, license, url, image_url, sound_url, tag_list, description, 
		num_identification_agreements, num_identification_disagreements, captive_cultivated, oauth_application_id, place_guess, 
		CASE
			WHEN private_latitude IS NOT NULL THEN private_latitude
			ELSE latitude
		END::double precision AS latitude, 
		CASE
			WHEN private_longitude IS NOT NULL THEN private_longitude
			ELSE longitude
		END::double precision AS longitude, positional_accuracy, private_place_guess, 
		private_latitude, private_longitude, public_positional_accuracy, geoprivacy, taxon_geoprivacy, coordinates_obscured, positioning_method, positioning_device, species_guess, 
		scientific_name, common_name, iconic_taxon_name, taxon_id, bb.taxon_family_name, taxon_genus_name, taxon_species_name, taxon_subspecies_name, 
		taxon_variety_name, high_quality_location_data
	FROM bioblitz.ak_bioblitz_import AS bb
	JOIN bioblitz.ak_bioblitz_taxonomy_crossref_2022_view AS bbcrv USING (scientific_name)
	LEFT JOIN public.flora_of_alaska_view AS foav USING (name_accepted)
	WHERE latitude IS NOT NULL AND longitude IS NOT NULL
		   --quality_grade = 'research' AND name_accepted NOT IN ('NO MATCH') --6741 records meet this criteria
		--AND coordinates_obscured IS TRUE
		--AND private_latitude IS NOT NULL
		ORDER BY name_accepted)

--SELECT * FROM d WHERE quality_grade NOT IN ('research') OR name_accepted = 'NO MATCH' --2841 record either not research grade and/or no match in Flora of AK Checklist

SELECT row_number() OVER (ORDER BY id) AS ogc_fid,id, name_accepted, level, habit, native, non_native, state_rank, global_rank, federal_listing, st_setsrid(st_makepoint(longitude, latitude), 4326) AS geom,
		observed_on_string, observed_on, time_observed_at, time_zone, user_id, user_login, created_at, updated_at, quality_grade, license, url, image_url, sound_url, tag_list, description, 
		num_identification_agreements, num_identification_disagreements, captive_cultivated, oauth_application_id, place_guess, 
		latitude, longitude, 
		positional_accuracy, private_place_guess, 
		private_latitude, private_longitude, public_positional_accuracy, geoprivacy, taxon_geoprivacy, coordinates_obscured, positioning_method, positioning_device, species_guess, 
		scientific_name, common_name, iconic_taxon_name, taxon_id, taxon_family_name, taxon_genus_name, taxon_species_name, taxon_subspecies_name, 
		taxon_variety_name, high_quality_location_data 
		FROM d
		--WHERE private_latitude IS NOT NULL

/*
Added to flora of AK taxon accepted table and child tables
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

;

ALTER TABLE bioblitz.ak_bioblitz_analysis_2022_view
    OWNER TO aaronwells;
COMMENT ON VIEW bioblitz.ak_bioblitz_analysis_2022_view
    IS 'This view standardizes the taxonomic names, includes all observations, including research and non-research grade and 4 records of taxa that did not match a taxon in the Flora of Alaska provisional checklist,  replaces the public lat/long with private, and creates geom.';

