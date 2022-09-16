-- View: bioblitz.ak_bioblitz_taxonomy_crossref_2022_view

-- DROP VIEW bioblitz.ak_bioblitz_taxonomy_crossref_2022_view;

CREATE OR REPLACE VIEW bioblitz.ak_bioblitz_taxonomy_crossref_2022_view AS

WITH d AS (SELECT scientific_name, taxon_family_name, taxon_genus_name, taxon_species_name, taxon_subspecies_name, taxon_variety_name, quality_grade,
	CASE
		WHEN taxon_subspecies_name IS NULL AND taxon_variety_name IS NULL THEN taxon_species_name
		WHEN taxon_subspecies_name IS NOT NULL THEN taxon_species_name || ' ' || 'ssp.' || ' ' || split_part(taxon_subspecies_name,' ',3)
		WHEN taxon_variety_name IS NOT NULL THEN taxon_species_name || ' ' || 'var.' || ' ' || split_part(taxon_variety_name,' ',3)
		ELSE 'SOMETHING ELSE' --genus || ' ' || specificepithet
	END::text AS sciname 
	FROM bioblitz.ak_bioblitz_import
		  WHERE taxon_family_name IS NOT NULL AND taxon_genus_name IS NOT NULL AND taxon_species_name IS NOT NULL),
		  
--SELECT * FROM d

	g AS (SELECT taxon_family_name, scientific_name, sciname,array_agg(quality_grade) AS quality_grade_array FROM d
	GROUP BY taxon_family_name, scientific_name, sciname
	ORDER BY scientific_name, sciname),
	
--SELECT * FROM g
	
	nomatch AS (SELECT taxon_family_name, scientific_name, sciname, sciname AS name_adjudicated, 
				CASE
					WHEN sciname = 'Allium schoenoprasum ssp. schoenoprasum' THEN 'Allium schoenoprasum'
					WHEN sciname = 'Artemisia norvegica' THEN 'Artemisia arctica'
					WHEN sciname = 'Artemisia annua' THEN 'NO MATCH'
					WHEN sciname = 'Antennaria parvifolia' THEN 'NO MATCH'
					WHEN sciname = 'Senecio matatini' THEN 'NO MATCH'
					WHEN sciname = 'Arctium lappa' THEN 'NO MATCH'
					WHEN sciname = 'Nemophila aphylla' THEN 'NO MATCH'
					WHEN sciname = 'Plagiobothrys scouleri var. hispidulus' THEN 'NO MATCH'
					WHEN sciname = 'Myosotis micrantha' THEN 'NO MATCH'
					WHEN sciname = 'Aphragmus eschscholtziana' THEN 'Aphragmus eschscholtzianus'
					WHEN sciname = 'Cardamine hirsuta' THEN 'NO MATCH'
					WHEN sciname = 'Imbribryum miniatum' THEN 'NO MATCH'
					WHEN sciname = 'Lobelia angulata' THEN 'NO MATCH'
					WHEN sciname = 'Honckenya peploides ssp. peploides' THEN 'Honckenya peploides'
					WHEN sciname = 'Closterium rostratum' THEN 'NO MATCH'
					WHEN sciname = 'Closterium striolatum' THEN 'NO MATCH'
					WHEN sciname = 'Carex nigra' THEN 'NO MATCH'
					WHEN sciname = 'Carex cespitosa' THEN 'NO MATCH'
					WHEN sciname = 'Carex lenticularis' THEN 'NO MATCH'
					WHEN sciname = 'Xanthidium octocorne' THEN 'Xanthidium octocorne' --algae
					WHEN sciname = 'Staurastrum arcuatum' THEN 'NO MATCH'
					WHEN sciname = 'Staurodesmus convergens' THEN 'NO MATCH'
					WHEN sciname = 'Cosmarium pseudotaxichondrum' THEN 'NO MATCH'
					WHEN sciname = 'Bambusina borreri' THEN 'NO MATCH'
					WHEN sciname = 'Pleurotaenium sceptrum' THEN 'NO MATCH'
					WHEN sciname = 'Micrasterias truncata' THEN 'Micrasterias truncata' --algae
					WHEN sciname = 'Euastrum obesum' THEN 'NO MATCH'
					WHEN sciname = 'Hyalotheca dissiliens' THEN 'NO MATCH'
					WHEN sciname = 'Hyalotheca mucosa' THEN 'NO MATCH'
					WHEN sciname = 'Staurastrum calyxoides' THEN 'NO MATCH'
					WHEN sciname = 'Entodon seductrix' THEN 'NO MATCH'
					WHEN sciname = 'Vaccinium oxycoccos' THEN 'Oxycoccus microcarpus'
					WHEN sciname = 'Andromeda polifolia var. glaucophylla' THEN 'Andromeda polifolia'
					WHEN sciname = 'Vaccinium microcarpum' THEN 'NO MATCH'
					WHEN sciname = 'Grimmia laevigata' THEN 'NO MATCH'
					WHEN sciname = 'Ribes spicatum' THEN 'NO MATCH'
					WHEN sciname = 'Braunia imberbis' THEN 'NO MATCH'
					WHEN sciname = 'Luzula nivea' THEN 'NO MATCH'
					WHEN sciname = 'Pseudisothecium cardotii' THEN 'NO MATCH'
					WHEN sciname = 'Netrium oblongum' THEN 'NO MATCH'
					WHEN sciname = 'Syringa josikaea' THEN sciname -- cultivar
					WHEN sciname = 'Syringa vulgaris' THEN sciname -- cultivar
					WHEN sciname = 'Epilobium minutum' THEN 'NO MATCH'
					WHEN sciname = 'Epilobium parviflorum' THEN 'NO MATCH'
					WHEN sciname = 'Neottia banksiana' THEN 'Listera caurina' --ITIS syn
					WHEN sciname = 'Rhinanthus groenlandicus' THEN 'Rhinanthus minor'
					WHEN sciname = 'Pedicularis sylvatica' THEN 'NO MATCH'
					WHEN sciname = 'Pedicularis sudetica' THEN 'Pedicularis interior' --Zoe's observation of Pedicularis sudetica ssp. interior
					WHEN sciname = 'Ulota crispa' THEN 'NO MATCH'
					WHEN sciname = 'Picea pungens' THEN sciname -- cultivar
					WHEN sciname = 'Pinus mugo' THEN 'NO MATCH'
					WHEN sciname = 'Alopecurus magellanicus' THEN 'Alopecurus borealis'
					WHEN sciname = 'Eragrostis cilianensis' THEN 'NO MATCH'
					WHEN sciname = 'Eragrostis albensis' THEN 'NO MATCH'
					WHEN sciname = 'Elymus elymoides' THEN 'NO MATCH'
					WHEN sciname = 'Diplachne fusca' THEN 'NO MATCH'
					WHEN sciname = 'Cymbopogon refractus' THEN 'NO MATCH'
					WHEN sciname = 'Bromus erectus' THEN 'NO MATCH'
					WHEN sciname = 'Brachypodium sylvaticum' THEN 'NO MATCH'
					WHEN sciname = 'Bothriochloa ischaemum' THEN 'NO MATCH'
					WHEN sciname = 'Leymus triticoides' THEN 'NO MATCH'
					WHEN sciname = 'Koenigia alaskana' THEN 'Aconogonon alaskanum'
					WHEN sciname = 'Rumex salicifolius' THEN 'NO MATCH'
					WHEN sciname = 'Potamogeton nodosus' THEN 'NO MATCH'
					WHEN sciname = 'Lysimachia punctata' THEN sciname -- exotic not known to occur in Alaska
					WHEN sciname = 'Trollius asiaticus' THEN 'NO MATCH' -- doesn't occur in Alaska and no syn
					WHEN sciname = 'Anemonastrum narcissiflorum' THEN 'NO MATCH' -- Flora of AK splits this, can't cross-ref
					WHEN sciname = 'Delphinium elatum' THEN 'NO MATCH' -- doesn't occur in Alasks and no syn
					WHEN sciname = 'Dryas octopetala' THEN 'Dryas'
					WHEN sciname = 'Cotoneaster lucidus' THEN sciname -- exotic, not previously found in Alaska, based on AKEPIC Cotoneaster simonii has been found in Anchorage
					WHEN sciname = 'Spiraea betulifolia' THEN 'NO MATCH'
					WHEN sciname = 'Spiraea japonica' THEN sciname -- exotic, not previously found in Alaska
					WHEN sciname = 'Amelanchier alnifolia var. semiintegrifolia' THEN 'Amelanchier alnifolia'
					WHEN sciname = 'Aronia melanocarpa' THEN 'NO MATCH'
					WHEN sciname = 'Salix atrocinerea' THEN 'NO MATCH'
					WHEN sciname = 'Salix pedicellaris' THEN 'NO MATCH'
					WHEN sciname = 'Populus grandidentata' THEN 'NO MATCH'
					WHEN sciname = 'Saxifraga granulata' THEN 'NO MATCH'
					WHEN sciname = 'Saxifraga flagellaris' THEN 'Saxifraga platysepala' -- Flora of AK splits, can't tell from photos so just selected one of the 2 based on a coin toss
					WHEN sciname = 'Saxifraga bronchialis' THEN 'Saxifraga funstonii' -- Flora of AK splits this, most of what has been called Saxifraga bronchialis fits with the taxon concept of Saxifraga funstonii
					WHEN sciname = 'Solanum tuberosum' THEN sciname -- cultivar, potato plant in someone's garden, not previously found in Alaska
					WHEN sciname = 'Oreopteris quelpartensis' THEN 'Oreopteris quelpaertensis' --slight spelling difference
					WHEN sciname = 'Trentepohlia aurea' THEN sciname -- algae
					WHEN sciname = 'Tropaeolum majus' THEN sciname -- cultivar, nasturtiums
					WHEN sciname = 'Ulva intestinalis' THEN sciname -- algae
					WHEN sciname = 'Urtica gracilis ssp. gracilis' THEN 'Urtica gracilis'
					WHEN sciname = 'Viburnum opulus var. americanum' THEN 'Viburnum opulus'
					WHEN sciname = 'Sambucus racemosa ssp. racemosa' THEN 'Sambucus racemosa'
				ELSE 'SOMETHING ELSE'
				END::character varying (120) AS name_accepted,
				'no match'::text AS taxon_crossref,
				quality_grade_array
				FROM g
	LEFT JOIN public.flora_of_ak_accepted_join_adjudicated_view ON sciname = name_adjudicated
	WHERE name_adjudicated IS NULL --AND NOT 'research' = ANY(quality_grade_array)
			   ORDER BY taxon_family_name), -- no match in AKVEG taxonomy table

--SELECT * FROM nomatch

	matching AS (SELECT taxon_family_name, scientific_name, sciname, name_adjudicated, name_accepted,'match'::text AS taxon_crossref,quality_grade_array 
				FROM g
	LEFT JOIN public.flora_of_ak_accepted_join_adjudicated_view ON sciname = name_adjudicated
	WHERE name_adjudicated IS NOT NULL) -- match in AKVEG taxonomy table
	
	SELECT * FROM matching
	UNION
	SELECT * FROM nomatch
	ORDER BY taxon_family_name DESC, sciname;

ALTER TABLE bioblitz.ak_bioblitz_taxonomy_crossref_2022_view
    OWNER TO postgres;
COMMENT ON VIEW bioblitz.ak_bioblitz_taxonomy_crossref_2022_view
    IS 'This view prepares a cross reference table between the iNaturalist taxonomic names and the accepted names in the new Flora of Alaska from the AKVEG database.';

