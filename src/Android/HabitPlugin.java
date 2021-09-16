package org.apache.cordova.plugin;

import io.habit.android.devicehealth.DeviceHealth;
import io.habit.android.devicehealth.DeviceInfoCallback;
import io.habit.android.devicehealth.TestCallback;
import io.habit.android.devicehealth.global.Globals;
import io.habit.android.devicehealth.global.ScreenType;

import io.habit.android.devicehealth.model.BorderType;
import io.habit.android.devicehealth.model.ButtonStyle;
import io.habit.android.devicehealth.model.CustomizableScreen;
import io.habit.android.devicehealth.model.Customization;
import io.habit.android.devicehealth.util.Utils;
import io.habit.android.devicehealth.lang.ScreenCustomizationKeys;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import android.util.Log;

public class HabitPlugin extends CordovaPlugin {
  
  private static final String TAG = "HabitPlugin";

  @Override
  public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
    if (action.equals("getDeviceInfo")) {
            this.getDeviceInfo(callbackContext, args.getInt(0));
            return true;
        } 
    return false;
    }
   
    private void getDeviceInfo(final CallbackContext callbackContext, final int number) {
      
    Log.d(TAG, "getDeviceInfo  called. number: " + Integer.toString(number));
    cordova.getThreadPool().execute(new Runnable() {
    public void run() {
      try {
            DeviceHealth.getDeviceInfo(this, this, "<-serial number->", "<-device IMEI->", new DeviceInfoCallback() {
            @Override
            public void onResponse(JSONObject obj) {

            // obj == null : Canceled
            // obj != null : Success

            }
        });
        Log.d(TAG, "getDeviceInfo  success");
      } catch (Exception e) {
        callbackContext.error(e.getMessage());
      }
    }
    });
  }
  }
