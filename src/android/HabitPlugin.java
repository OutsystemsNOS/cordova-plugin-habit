package com.cordova.plugin;

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

import com.google.gson.Gson;

public class HabitPlugin extends CordovaPlugin {
  
  private static final String TAG = "HabitPlugin";

  @Override
  public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
    if (action.equals("getDeviceInfo")) {
      this.getDeviceInfo(callbackContext, args.getString(0), args.getString(1));
      return true;   
      
      } else if (action.equals("performTests")) {
        this.performTests(callbackContext, args.getString(0), args.getString(1), args.getString(3), args.getString(4), args.getString(5));
        return true;  

      } else if (action.equals("hideStartScreen")) {
        this.hideStartScreen(callbackContext, args.getString(0));
        return true; 

      } else if (action.equals("setLanguage")) {
        this.setLanguage(callbackContext, args.getString(0));
        return true; 

      } else if (action.equals("setThemeColor")) {
        this.setThemeColor(callbackContext, args.getString(0), args.getString(1), args.getString(1));
        return true; 

      } else {
        callbackContext.error("\"" + action + "\" is not a recognized action.");
        return false;

        }
    }
   
  private void performTests(final CallbackContext callbackContext, final String appid, final String apikey, final String serialnumber, final String imei, final String testsToPerform){
   cordova.getThreadPool().execute(new Runnable() {
        public void run() {
          try {
		Gson gson = new Gson();
		String[] testsToPerform = new String[]{tests};
		  
		DeviceHealth.performTests(cordova.getActivity().getApplicationContext(), cordova.getActivity(), appid, apikey, serialnumber, imei, testsToPerform, customization, new TestCallback() {

		@Override
		public void onResponse(JSONObject obj) {
			if (obj != null) {                  	
			    try {
				if (obj.optInt("status_code") == 200) {
					callbackContext.success(obj);
				} else {
					callbackContext.success(obj);
				}
			    } catch (Exception e) {
				callbackContext.error(e.getMessage());
			    }
			} else {

			}
		    }
		});
          } catch (Exception e) {
            callbackContext.error(e.getMessage());
          }
      } });
  }
  
  private void hideStartScreen(final CallbackContext callbackContext, final String hide){
     cordova.getThreadPool().execute(new Runnable() {
        public void run() {
          try {
		callbackContext.success("ok");
          } catch (Exception e) {
            callbackContext.error(e.getMessage());
          }
      } });
  }
  
  private void setLanguage(final CallbackContext callbackContext, final String language){
     cordova.getThreadPool().execute(new Runnable() {
        public void run() {
          try {
		callbackContext.success("ok");
          } catch (Exception e) {
            callbackContext.error(e.getMessage());
          }
      } });
  }
  
  private void setThemeColor(final CallbackContext callbackContext, final String red, final String blue, final String green){
     cordova.getThreadPool().execute(new Runnable() {
        public void run() {
          try {
		callbackContext.success("ok");
          } catch (Exception e) {
            callbackContext.error(e.getMessage());
          }
      } });
  }
    
  private void getDeviceInfo(final CallbackContext callbackContext, final String serialnumber, final String imei) {      
      cordova.getThreadPool().execute(new Runnable() {
        public void run() {
          try {
                DeviceHealth.getDeviceInfo(cordova.getActivity().getApplicationContext(), cordova.getActivity(), serialnumber, imei, new DeviceInfoCallback() {
                @Override
                public void onResponse(JSONObject obj) {
                  callbackContext.success(obj);
                }
            });
          } catch (Exception e) {
            callbackContext.error(e.getMessage());
          }
      }
    });
  }
  }
