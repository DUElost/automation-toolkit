用例集目录约定（两阶段选套）

  suites/
  ├── apk/          # APK 池
  │   ├── ReliabilityUiautomatorTest.apk / ReliabilityUiautomatorTestTest.apk
  │   └── StabilityTestWithPom.apk / StabilityTestWithPomTest.apk
  └── task/         # 任务 XML

交互流程：
  1. 先选 APK 族（ReliabilityUiautomatorTestTest / StabilityTestWithPomTest）
  2. 再只显示 <apk name="所选.apk"> 匹配的 task XML
  3. 安装对应 APK 对，推送该 XML 为 /sdcard/runtask.xml

调度器 OfflineScriptManager.apk 放在 shared/apk/。
