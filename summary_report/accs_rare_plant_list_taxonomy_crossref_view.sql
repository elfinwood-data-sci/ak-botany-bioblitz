-- View: bioblitz.accs_rare_plant_list_taxonomy_crossref_view

-- DROP VIEW bioblitz.accs_rare_plant_list_taxonomy_crossref_view;

CREATE OR REPLACE VIEW bioblitz.accs_rare_plant_list_taxonomy_crossref_view AS

SELECT 
	CASE
		WHEN name_accepted IS NULL THEN sciname_only
		ELSE name_accepted
	   END::character varying(120) AS name_accepted_adjusted, --there are 6 taxa in the rare plant list that don't match with a name (accepted or not) in the provisional checklist database
	   CASE
		WHEN name_accepted IS NULL THEN FALSE
		ELSE TRUE
	   END::boolean AS not_in_provisional_checklist, 
		*
FROM public.flora_of_ak_accepted_join_adjudicated_view
	RIGHT JOIN bioblitz.accs_rare_plant_list ON name_adjudicated = sciname_only
	ORDER BY name_accepted_adjusted;
	
/*non-matches:
'Malaxis monophyllos ssp. monophyllos'
'Botrychium robustum'
'Erigeron glacialis var. glacialis'
'Trollius membranostylis'
'Hypericum anagalloides'
'Lathyrus ochroleucus'*/

ALTER TABLE bioblitz.accs_rare_plant_list_taxonomy_crossref_view
    OWNER TO aaronwells;
COMMENT ON VIEW bioblitz.accs_rare_plant_list_taxonomy_crossref_view
    IS 'This view creates a taxonomic cross reference table between the ACCS rare plant list taxonomic names and the Flora of AK provisional checklist names. AFW 2022-09-15.';

