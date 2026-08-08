-- Query 1: Average heart rate by hour of day
CREATE TABLE `bellabeat_analysis.summary_heartrate_hourly` AS
SELECT
  EXTRACT(HOUR FROM PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', Time)) AS hour_of_day,
  AVG(Value) AS avg_heart_rate,
  COUNT(DISTINCT Id) AS user_count
FROM `bellabeat_analysis.heartrate_seconds`
GROUP BY hour_of_day
ORDER BY hour_of_day;

-- Query 2: Average steps by hour of day
CREATE TABLE `bellabeat_analysis.summary_steps_hourly` AS
SELECT
  EXTRACT(HOUR FROM PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', ActivityMinute)) AS hour_of_day,
  AVG(Steps) AS avg_steps,
  COUNT(DISTINCT Id) AS user_count
FROM `bellabeat_analysis.minute_steps`
GROUP BY hour_of_day
ORDER BY hour_of_day;

-- Query 3: Average intensity by hour of day
CREATE TABLE `bellabeat_analysis.summary_intensity_hourly` AS
SELECT
  EXTRACT(HOUR FROM PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', ActivityMinute)) AS hour_of_day,
  AVG(Intensity) AS avg_intensity,
  COUNT(DISTINCT Id) AS user_count
FROM `bellabeat_analysis.minute_intensities`
GROUP BY hour_of_day
ORDER BY hour_of_day;

-- Query 4: Average METs by hour of day
CREATE TABLE `bellabeat_analysis.summary_mets_hourly` AS
SELECT
  EXTRACT(HOUR FROM PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', ActivityMinute)) AS hour_of_day,
  AVG(METs) AS avg_mets,
  COUNT(DISTINCT Id) AS user_count
FROM `bellabeat_analysis.minute_mets`
GROUP BY hour_of_day
ORDER BY hour_of_day;

-- Query 5: Combined day-of-week + hour-of-day activity heatmap
CREATE TABLE `bellabeat_analysis.summary_activity_heatmap` AS
SELECT
  FORMAT_DATETIME('%A', PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', s.ActivityMinute)) AS day_of_week,
  EXTRACT(HOUR FROM PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', s.ActivityMinute)) AS hour_of_day,
  AVG(s.Steps) AS avg_steps,
  AVG(i.Intensity) AS avg_intensity,
  AVG(m.METs) AS avg_mets
FROM `bellabeat_analysis.minute_steps` s
JOIN `bellabeat_analysis.minute_intensities` i
  ON s.Id = i.Id AND s.ActivityMinute = i.ActivityMinute
JOIN `bellabeat_analysis.minute_mets` m
  ON s.Id = m.Id AND s.ActivityMinute = m.ActivityMinute
GROUP BY day_of_week, hour_of_day
ORDER BY day_of_week, hour_of_day;
