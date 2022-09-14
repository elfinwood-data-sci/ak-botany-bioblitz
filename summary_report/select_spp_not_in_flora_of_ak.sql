WITH g AS (SELECT scientific_name
	FROM bioblitz.ak_bioblitz_import
		   WHERE taxon_genus_name IS NOT NULL AND taxon_species_name IS NOT NULL
		  GROUP BY scientific_name),
	
j AS (SELECT scientific_name, name_accepted 
FROM g
LEFT JOIN bioblitz.ak_bioblitz_taxonomy_crossref_2022_view USING (scientific_name) 
WHERE name_accepted NOT IN ('NO MATCH')
	  )
	  
--names in this list don't have a match in the taxon_accepted table and needed to added there and to all related tables
SELECT * FROM j
LEFT JOIN public.flora_of_alaska_view USING (name_accepted)
WHERE accepted_id IS NULL
	