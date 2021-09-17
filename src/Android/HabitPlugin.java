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
    
    cordova.getActivity().runOnUiThread(new Runnable() {
                  public void run() {
                    callbackContext.success("teste1");
                  }
              });
            return true;
    }
   
    private void getDeviceInfo(final CallbackContext callbackContext, final String number, final String imei) {      
      Log.d(TAG, "getDeviceInfo  called. number: " + number + " IMEI: " + imei);
      cordova.getThreadPool().execute(new Runnable() {
        public void run() {
          try {
                DeviceHealth.getDeviceInfo(cordova.getActivity().getApplicationContext(), cordova.getActivity(), number, imei, new DeviceInfoCallback() {
                @Override
                public void onResponse(JSONObject obj) {
                  callbackContext.success(obj);
                }
            });
            Log.d(TAG, "getDeviceInfo  success");
          } catch (Exception e) {
            Log.d(TAG, "getDeviceInfo  error");
            callbackContext.error(e.getMessage());
          }
      }
    });
  }
  }
