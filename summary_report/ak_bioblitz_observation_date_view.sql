-- View: bioblitz.ak_bioblitz_observation_date_view

-- DROP VIEW bioblitz.ak_bioblitz_observation_date_view;

CREATE OR REPLACE VIEW bioblitz.ak_bioblitz_observation_date_view AS

WITH d AS (SELECT observed_on::date, quality_grade, count(name_accepted)
	FROM bioblitz.ak_bioblitz_analysis_2022_view
	GROUP BY observed_on::date, quality_grade
	ORDER BY observed_on::date, quality_grade)
	
SELECT observed_on AS observed_on_date, 
	CASE
		WHEN quality_grade = 'research' THEN 'Research Grade'
		ELSE 'Needs ID'
	END::character varying(100) AS quality_grade,
	count
FROM d;

ALTER TABLE bioblitz.ak_bioblitz_observation_date_view
    OWNER TO aaronwells;
COMMENT ON VIEW bioblitz.ak_bioblitz_observation_date_view
    IS 'This view aggregates all records by date and quality grade for use in a stacked barchart figure. AFW 2022-09-17.';