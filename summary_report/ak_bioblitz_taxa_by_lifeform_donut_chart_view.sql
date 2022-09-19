-- View: bioblitz.ak_bioblitz_taxa_by_lifeform_donut_chart_view

-- DROP VIEW bioblitz.ak_bioblitz_taxa_by_lifeform_donut_chart_view;

CREATE OR REPLACE VIEW bioblitz.ak_bioblitz_taxa_by_lifeform_donut_chart_view AS
 WITH d AS (
         SELECT
                CASE
                    WHEN bioblitz.ak_bioblitz_analysis_2022_view.habit = 'Shrub, Deciduous Tree'::text THEN 'Shrub'::text
                    WHEN bioblitz.ak_bioblitz_analysis_2022_view.habit = 'Dwarf Shrub, Shrub'::text THEN 'Dwarf Shrub'::text
                    ELSE bioblitz.ak_bioblitz_analysis_2022_view.habit
                END AS habit,
            bioblitz.ak_bioblitz_analysis_2022_view.name_accepted
           FROM bioblitz.ak_bioblitz_analysis_2022_view
	 		WHERE quality_grade = 'research' AND name_accepted NOT IN ('NO MATCH')
        ), gb AS (
         SELECT d.habit,
            d.name_accepted
           FROM d
          GROUP BY d.habit, d.name_accepted
          ORDER BY d.habit, d.name_accepted
        ), gbhab AS (
         SELECT gb.habit,
            count(gb.name_accepted) AS count
           FROM gb
          GROUP BY gb.habit
          ORDER BY gb.habit
        ), srt AS (
         SELECT
                CASE
                    WHEN gbhab.habit = 'Coniferous Tree'::text THEN 1.0
                    WHEN gbhab.habit = 'Deciduous Tree'::text THEN 2.0
                    WHEN gbhab.habit = 'Dwarf Shrub'::text THEN 4.0
                    WHEN gbhab.habit = 'Forb'::text THEN 5.0
                    WHEN gbhab.habit = 'Fungi'::text THEN 11.0
                    WHEN gbhab.habit = 'Graminoid'::text THEN 6.0
                    WHEN gbhab.habit = 'Lichen'::text THEN 10.0
                    WHEN gbhab.habit = 'Liverwort'::text THEN 9.0
                    WHEN gbhab.habit = 'Moss'::text THEN 8.0
                    WHEN gbhab.habit = 'Shrub'::text THEN 3.0
                    WHEN gbhab.habit = 'Spore-bearing'::text THEN 7.0
					WHEN gbhab.habit = 'Algae'::text THEN 10.0
                    ELSE '-999.900'::numeric
                END::numeric(4,1) AS sort_order,
                CASE
                    WHEN gbhab.habit = 'Shrub'::text THEN 'Low or Tall Shrub'::text
                    ELSE gbhab.habit
                END AS "Lifeform",
            gbhab.count
           FROM gbhab
        )
		
SELECT srt.sort_order,
    srt."Lifeform",
    srt.count
   FROM srt
  ORDER BY srt.sort_order;

ALTER TABLE bioblitz.ak_bioblitz_taxa_by_lifeform_donut_chart_view
    OWNER TO postgres;
COMMENT ON VIEW bioblitz.ak_bioblitz_taxa_by_lifeform_donut_chart_view
    IS 'The data in this view is used to create a donut chart figure for the 2022 Alaska Botany Bioblitz Sept/Oct. 2022 Borealis article figure.';

