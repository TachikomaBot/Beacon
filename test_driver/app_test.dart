// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:io';
import 'package:path/path.dart';

void main() {
  group('Beacon App', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {

      //grant permission for android
      final envVars = Platform.environment;
      final adbPath = join(
        envVars['ANDROID_SDK_ROOT'] ?? envVars['ANDROID_HOME'],
        'platform-tools',
        Platform.isWindows ? 'adb.exe' : 'adb',
      );

      await Process.run(adbPath, [
        'shell',
        'pm',
        'grant',
        'com.example.Beacon',
        'android.permission.CAMERA'
      ]);

      await Process.run(adbPath, [
        'shell',
        'pm',
        'grant',
        'com.example.Beacon',
        'android.permission.RECORD_AUDIO'
      ]);

      await Process.run(adbPath, [
        'shell',
        'pm',
        'grant',
        'com.example.yourapp', // replace with your app id
        'android.permission.WRITE_EXTERNAL_STORAGE'
      ]);
    
      driver = await FlutterDriver.connect();
      
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    //Video Test: Open and use Beacon's video functionality
    test("Open and use Beacon's video functionality", () async{
      final bypass = find.byValueKey('bypass');
      final control = find.byValueKey('control');
      final controlCenter = find.byValueKey('control-center');
      final videoScreen = find.byValueKey('video-screen');
      final stopButton = find.byValueKey('stop-btn');

      await driver.waitFor(bypass);
      await driver.tap(bypass);
      await driver.waitFor(controlCenter);
      await driver.waitFor(control);
      await driver.scroll(control, 100, 0, Duration(milliseconds: 300));
      await driver.waitFor(videoScreen, timeout: Duration(seconds: 10));
      await driver.tap(stopButton);

      //Verify that video is stopped and app is redirect back
      await driver.waitFor(controlCenter);

    });

  });
}