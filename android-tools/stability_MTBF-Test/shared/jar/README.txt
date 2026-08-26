MTBF jar 离线调度器（PC Reliability 平台 OfflineRun 同款）

请放入：
  sevice.jar

来源示例：
  552_MTBF_laohua/.../data/offline/sevice.jar

设备端启动方式（脚本自动完成）：
  dalvikvm -classpath /data/local/tmp/sevice.jar com.tinno.soft.test.sevice.Sevice &

要求：
  adb 可拿到 root（adb root / whoami=root）
  任务 XML 推到 /data/local/tmp/runtask.xml
