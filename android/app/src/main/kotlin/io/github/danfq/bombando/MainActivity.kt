package io.github.danfq.bombando

import android.provider.Settings
import androidx.annotation.NonNull

import android.app.Application
import android.content.Context
import android.os.Build
import android.util.Log
import android.net.Uri
import android.content.Intent;

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "flutter.native/helper"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {

        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        .setMethodCallHandler{
                call, result ->
            when {

                //System Write Permission
                call.method.equals("checkSystemWritePermission") -> {
                    checkSystemWritePermission()
                }

            }
        }
    }

    private fun checkSystemWritePermission() : Boolean {

        var retVal = true;

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {

            retVal = Settings.System.canWrite(this)
            Log.d("TAG", "WRITE_SETTINGS => " + retVal)

            finish()

            if (retVal) {
                //Permission granted by the user
                finish()
            } else {
                //Permission not granted navigate to permission screen
                openAndroidPermissionsMenu()
            }
        }

        return retVal;

    }
    
    private fun openAndroidPermissionsMenu() {

        val intent = Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS);
        intent.setData(Uri.parse("package:" + this.getPackageName()));

        startActivity(intent);
     }

}
