SELECT 
  device_0_remote_device_0_firmware_description_0_version_0_firmware_0_fw_version AS fw_version,
  COUNT(DISTINCT(device_0_remote_device_0_serial_number)) AS num_users
FROM
  remote_device_system_metrics
WHERE
  TD_TIME_RANGE(time,
    TD_TIME_ADD(TD_SCHEDULED_TIME(),
      '-10d'),
    TD_SCHEDULED_TIME())
GROUP BY
  device_0_remote_device_0_firmware_description_0_version_0_firmware_0_fw_version
