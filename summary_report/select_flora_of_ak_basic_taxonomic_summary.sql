WITH d AS (SELECT accepted_id, name_accepted, auth_accepted_id, accepted_author, hierarchy_id, link_source, family_id, accepted_family, level_id, level, habit_id, habit, category_id, category, native, non_native, taxon_source_id, accepted_taxon_source, accepted_citation, adjudicated_id, name_adjudicated, auth_adjudicated_id, adjudicated_author, status_adjudicated_id, taxon_status
	FROM public.flora_of_ak_accepted_join_adjudicated_view
	WHERE taxon_status = 'accepted' AND level = 'genus'
	--AND level IN ('genus','subspecies','variety','hybrid','species')
	AND habit IN ('Lichen')
		   )
		   SELECT * FROM d 
		   
		  -- GROUP BY accepted_family
	
	--- Flora of Alaska provisional checklist ---
	-- 505 vascular genera in the Flora of Alaska provisional checklist
	-- 2181 vascular species, infraspecies, hybrids
	--106 families
	
	-- 1099 bryophyte species, infraspecies, hybrids
	-- 287 bryophyte genera
	-- 98 familes
	
	-- 1688 lichen species, infraspecies, hybrids
	-- 390 lichen genera
	-- 115 lichen families
	
	
	