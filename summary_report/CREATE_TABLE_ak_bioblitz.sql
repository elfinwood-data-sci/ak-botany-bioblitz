-- Table: bioblitz.ak_bioblitz_import

-- DROP TABLE IF EXISTS bioblitz.ak_bioblitz_import;

CREATE TABLE IF NOT EXISTS bioblitz.ak_bioblitz_import
(
  id bigint,
  observed_on_string text,
  observed_on text,
  time_observed_at text,
  time_zone text,
  user_id bigint,
  user_login character varying(100),
  created_at text,
  updated_at text,
  quality_grade character varying(100),
  license  character varying(100),
  url text,
  image_url text,
  sound_url text,
  tag_list text,
  description text,
  num_identification_agreements integer,
  num_identification_disagreements integer,
  captive_cultivated boolean,
  oauth_application_id integer,
  place_guess text,
  latitude double precision,
  longitude double precision,
  positional_accuracy bigint,
  private_place_guess text,
  private_latitude double precision,
  private_longitude double precision,
  public_positional_accuracy bigint,
  geoprivacy character varying(100),
  taxon_geoprivacy character varying(100),
  coordinates_obscured boolean,
  positioning_method character varying(100),
  positioning_device character varying(100),
  species_guess text,
  scientific_name text,
  common_name text,
  iconic_taxon_name text,
  taxon_id bigint,
  taxon_family_name text,
  taxon_genus_name text,
  taxon_species_name text,
  taxon_subspecies_name text,
  taxon_variety_name text,
  high_quality_location_data boolean,
    CONSTRAINT ak_bioblitz_pkey PRIMARY KEY (id)

)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS bioblitz.ak_bioblitz_import
    OWNER to postgres;
