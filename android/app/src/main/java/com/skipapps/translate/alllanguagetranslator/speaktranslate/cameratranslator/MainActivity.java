package com.skipeapps.translate.alllanguagetranslator.speaktranslate.cameratranslator;

import android.content.ContentValues;
import android.content.Intent;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;
import android.provider.MediaStore;
import android.provider.Settings;

import androidx.annotation.NonNull;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.nativespecificcodeproject/browser";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

        super.configureFlutterEngine(flutterEngine);


        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        new MethodChannel.MethodCallHandler() {
                            @Override
                            public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                                String rintonePath = call.argument("path");


                                if (call.method.equals("setRingtone")) {
//                            openBrowser(call, result, url);
//                            SetAsRingtoneOrNotification(new File(Environment.getExternalStorageDirectory() + "/Download/audio_clip.mp3"), 1);

//                                    AdSettings.addTestDevice("74f2b691-006c-4d25-95bb-783161cdc0ed");
//                                    boolean value =   SetAsRingtoneOrNotification(new File(rintonePath), 1);
//                                    MediationTestSuite.launch(MainActivity.this);
                                    System.out.println("Channel Called");

//                                    result.success(value);
                                } else if (call.method.equals("setNotification")) {

//                                    boolean value =   SetAsRingtoneOrNotification(new File(rintonePath), 2);
//                                    result.success(value);

                                } else if (call.method.equals("setAlarm")) {

//                                    boolean value =   SetAsRingtoneOrNotification(new File(rintonePath), 4);
//                                    result.success(value);

                                } else {
                                    result.notImplemented();
                                }
                            }
                        }
                );
    }


}
