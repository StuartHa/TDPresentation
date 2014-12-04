SELECT 
  fw_version,
  day_unix_time,
  COUNT(serial) AS num_users
FROM (
    SELECT 
      device_0_remote_device_0_serial_number AS serial,
      MAX(device_0_remote_device_0_firmware_description_0_version_0_firmware_0_fw_version) AS fw_version,
      TD_TIME_PARSE(
        TD_TIME_FORMAT(time,
          'yyyy-MM-dd')
      ) AS day_unix_time
    FROM
      remote_device_system_metrics
    WHERE
      TD_TIME_RANGE(time,
        TD_TIME_ADD(TD_SCHEDULED_TIME(),
          '-90d'),
        TD_SCHEDULED_TIME())
      AND platform = 'ios'
      AND length(device_0_remote_device_0_firmware_description_0_version_0_firmware_0_fw_version)< 8
    GROUP BY
      device_0_remote_device_0_serial_number,
      TD_TIME_FORMAT(time,
        'yyyy-MM-dd')
  )
GROUP BY
  day_unix_time,
  fw_version
ORDER BY
  day_unix_time ASC
