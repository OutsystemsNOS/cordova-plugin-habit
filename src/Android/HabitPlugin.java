package org.apache.cordova.habit;

import io.habit.android.devicehealth.model.BorderType;
import io.habit.android.devicehealth.model.ButtonStyle;
import io.habit.android.devicehealth.model.CustomizableScreen;
import io.habit.android.devicehealth.model.Customization;
import io.habit.android.devicehealth.util.Utils;
import io.habit.android.devicehealth.lang.ScreenCustomizationKeys;

public class HabitPlugin extends CordovaPlugin {

  @Override
  public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
    if (action.equals("getDeviceInfo")) {      
        DeviceHealth.getDeviceInfo(this, this, args.getString(0), args.getString(1), new DeviceInfoCallback() {
          @Override
          public void onResponse(JSONObject obj) {
            this.getDeviceInfo(obj);
          }
        });
      return true;      
    } else if (action.equals("performTests")) {
      return true;
    }
    return false;	
  }
  }