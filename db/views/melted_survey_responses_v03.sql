SELECT melted.survey_response_id,
  melted.survey_id,
  melted.distance,
  ST_ASTEXT(melted.geometry),
  melted.created,
  melted.modified,
  melted.shed,
  melted.dropoff,
  melted.from_school,
  melted.grade,
  melted.pickup,
  melted.to_school,
  melted.school_id,
  melted.nr_licenses,
  melted.nr_vehicles,
  melted.schid
 FROM ( SELECT survey_responses.id AS survey_response_id,
          survey_responses.survey_id,
          survey_responses.distance,
          survey_responses.geometry,
          survey_responses.created_at AS created,
          survey_responses.updated_at AS modified,
          survey_responses.shed,
          survey_responses.nr_licenses,
          survey_responses.nr_vehicles,
          unnest(ARRAY[survey_responses.dropoff_0, survey_responses.dropoff_1, survey_responses.dropoff_10, survey_responses.dropoff_11, survey_responses.dropoff_12, survey_responses.dropoff_13, survey_responses.dropoff_14, survey_responses.dropoff_15, survey_responses.dropoff_16, survey_responses.dropoff_17, survey_responses.dropoff_18, survey_responses.dropoff_19, survey_responses.dropoff_2, survey_responses.dropoff_3, survey_responses.dropoff_4, survey_responses.dropoff_5, survey_responses.dropoff_6, survey_responses.dropoff_7, survey_responses.dropoff_8, survey_responses.dropoff_9]) AS dropoff,
          unnest(ARRAY[survey_responses.from_school_0, survey_responses.from_school_1, survey_responses.from_school_10, survey_responses.from_school_11, survey_responses.from_school_12, survey_responses.from_school_13, survey_responses.from_school_14, survey_responses.from_school_15, survey_responses.from_school_16, survey_responses.from_school_17, survey_responses.from_school_18, survey_responses.from_school_19, survey_responses.from_school_2, survey_responses.from_school_3, survey_responses.from_school_4, survey_responses.from_school_5, survey_responses.from_school_6, survey_responses.from_school_7, survey_responses.from_school_8, survey_responses.from_school_9]) AS from_school,
          unnest(ARRAY[survey_responses.grade_0, survey_responses.grade_1, survey_responses.grade_10, survey_responses.grade_11, survey_responses.grade_12, survey_responses.grade_13, survey_responses.grade_14, survey_responses.grade_15, survey_responses.grade_16, survey_responses.grade_17, survey_responses.grade_18, survey_responses.grade_19, survey_responses.grade_2, survey_responses.grade_3, survey_responses.grade_4, survey_responses.grade_5, survey_responses.grade_6, survey_responses.grade_7, survey_responses.grade_8, survey_responses.grade_9]) AS grade,
          unnest(ARRAY[survey_responses.pickup_0, survey_responses.pickup_1, survey_responses.pickup_10, survey_responses.pickup_11, survey_responses.pickup_12, survey_responses.pickup_13, survey_responses.pickup_14, survey_responses.pickup_15, survey_responses.pickup_16, survey_responses.pickup_17, survey_responses.pickup_18, survey_responses.pickup_19, survey_responses.pickup_2, survey_responses.pickup_3, survey_responses.pickup_4, survey_responses.pickup_5, survey_responses.pickup_6, survey_responses.pickup_7, survey_responses.pickup_8, survey_responses.pickup_9]) AS pickup,
          unnest(ARRAY[survey_responses.to_school_0, survey_responses.to_school_1, survey_responses.to_school_10, survey_responses.to_school_11, survey_responses.to_school_12, survey_responses.to_school_13, survey_responses.to_school_14, survey_responses.to_school_15, survey_responses.to_school_16, survey_responses.to_school_17, survey_responses.to_school_18, survey_responses.to_school_19, survey_responses.to_school_2, survey_responses.to_school_3, survey_responses.to_school_4, survey_responses.to_school_5, survey_responses.to_school_6, survey_responses.to_school_7, survey_responses.to_school_8, survey_responses.to_school_9]) AS to_school,
          schools.id AS school_id,
          schools.schid
         FROM survey_responses
         INNER JOIN surveys ON survey_responses.survey_id = surveys.id
         INNER JOIN schools ON surveys.school_id = schools.id
        ORDER BY survey_responses.id) melted
WHERE melted.from_school IS NOT NULL AND melted.grade IS NOT NULL AND melted.to_school IS NOT NULL;
