package com.autobaraka.auto_baraka

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.telephony.TelephonyManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val SIM_CHECK_CHANNEL = "com.autobaraka.auto_baraka/simcheck"
    private val CALL_PHONE_CHANNEL = "com.autobaraka.auto_baraka/call_phone"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // SIM card check channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SIM_CHECK_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "hasSimCard") {
                val hasSim = hasSimCard()
                result.success(hasSim)
            } else {
                result.notImplemented()
            }
        }

        // Phone call channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CALL_PHONE_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "callPhone") {
                val number: String? = call.argument("number")
                if (number != null) {
                    callPhone(number)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "Number is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun hasSimCard(): Boolean {
        val telephonyManager = getSystemService(TELEPHONY_SERVICE) as TelephonyManager
        return telephonyManager.simState == TelephonyManager.SIM_STATE_READY
    }

    private fun callPhone(number: String) {
        val intent = Intent(Intent.ACTION_CALL)
        intent.data = Uri.parse("tel:$number")
        startActivity(intent)
    }
}
