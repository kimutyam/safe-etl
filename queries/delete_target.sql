DELETE FROM
  ${target_table}
WHERE
  CAST(time AS VARCHAR) || CAST(id AS VARCHAR) IN (
    SELECT CAST(time AS VARCHAR) || CAST(id AS VARCHAR) FROM ${target_temp_table}
  )
