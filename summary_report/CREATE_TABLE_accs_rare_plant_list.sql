-- Table: bioblitz.accs_rare_plant_list

--DROP TABLE IF EXISTS bioblitz.accs_rare_plant_list;

CREATE TABLE IF NOT EXISTS bioblitz.accs_rare_plant_list
(
    uniqueid integer,
	sciname_with_author text,
	family text,
	state_rank text,
	global_rank text,
	federal_listing text,
	ssp_var text,
	genus text,
	species text,
	sciname_only text,
	intraspecific_qualifier text,
	intraspecies text,
	last_updated timestamp with time zone,
    CONSTRAINT accs_rare_plant_list_pkey PRIMARY KEY (uniqueid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS bioblitz.accs_rare_plant_list
    OWNER to postgres;