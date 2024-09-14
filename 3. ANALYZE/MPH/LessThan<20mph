SELECT
ride_id,
member_casual,
rideable_type,
distance_ft,
distance_mi,
dur_h,
dur_m,
dur_s,
distance_mi/dur_h AS MPH,
start_lat,
start_lng,
end_lat,
end_lng,
start_station_name,
end_station_name
FROM
`cyclistic-data-strategy.555.ALLCLEAN`
WHERE distance_mi IS NOT NULL
AND distance_mi/dur_h > 20
