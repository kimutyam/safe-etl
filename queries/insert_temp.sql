INSERT INTO ${target_temp_table}
WITH reports AS (
  SELECT
    CAST(JSON_EXTRACT(record, '$.data') AS ARRAY<MAP<VARCHAR, JSON>>) AS reports
  FROM
    ${target_raw_table}
), unnested_reports AS (
  SELECT
    CAST(TO_UNIXTIME(FROM_ISO8601_TIMESTAMP(CAST(report['started_at'] AS VARCHAR))) AS BIGINT) AS time,
    CAST(report['id'] AS BIGINT) AS id,
    CAST(report['name'] AS VARCHAR) AS name,
    CAST(report['cv'] AS BIGINT) AS cv,
    CAST(report['cost'] AS BIGINT) AS cost,
    CAST(report['imp'] AS BIGINT) AS imp
  FROM
    reports
  CROSS JOIN
    UNNEST(reports) AS reports(report)
)
SELECT
  time,
  id,
  MAX_BY(name, time) AS name,
  MAX_BY(cv, time) AS cv,
  MAX_BY(cost, time) AS ad_name,
  MAX_BY(imp, time) AS imp
FROM
  unnested_reports
GROUP BY (
  time,
  id
)


