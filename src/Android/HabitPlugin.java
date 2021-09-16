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

public class HabitPlugin extends CordovaPlugin {

  @Override
  public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
    if (action.equals("getDeviceInfo")) {
            this.getDeviceInfo(callbackContext, args.getInt(0));
            return true;
        } 
    }
   
    private void getDeviceInfo(final CallbackContext callbackContext, final int number) {
    Log.d(TAG, "getDeviceInfo  called. number: " + Integer.toString(number));
      
    cordova.getThreadPool().execute(new Runnable() {
      public void run() {
        try {
          
          Log.d(TAG, "getDeviceInfo  success");
        } catch (Exception e) {
          Crashlytics.logException(e);
          callbackContext.error(e.getMessage());
        }
      }
    });
  }
  }
