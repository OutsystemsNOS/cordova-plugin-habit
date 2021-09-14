package org.apache.cordova.habit;

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
