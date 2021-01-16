package com.example.Beacon;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.Manifest;
import android.content.pm.PackageManager;
import android.telephony.SmsManager;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "beacon.flutter.dev/sms_sender";

  private static final int SMS_PERMISSION_CODE = 0;
  private static final String TAG = "MainActivity";

  private boolean hasSendSmsPermission() {
    return ContextCompat.checkSelfPermission(MainActivity.this, Manifest.permission.SEND_SMS) == PackageManager.PERMISSION_GRANTED;
  }

  private void requestReadAndSendSmsPermission() {
    ActivityCompat.requestPermissions(MainActivity.this, new String[]{Manifest.permission.SEND_SMS},
            SMS_PERMISSION_CODE);
  }

  private boolean hasValidPreConditions() {
    if (!hasSendSmsPermission()) {
      requestReadAndSendSmsPermission();
      return false;
    }
    return true;
  }

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                    (call, result) -> {
                      // Note: this method is invoked on the main thread.
                      if (call.method.equals("sendSMSAndroid")) {

                        String body = call.argument("body");
                        String number = call.argument("number");

                        if (hasSendSmsPermission()) {
                          SmsManager smsManager = SmsManager.getDefault();
                          smsManager.sendTextMessage(number, null, body, null, null);
                        }
                        else {
                          requestReadAndSendSmsPermission();
                        }

                      } else {
                        result.notImplemented();
                      }
                    }
            );
  }
}
