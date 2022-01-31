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
import io.habit.android.devicehealth.global.ScreenType;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.graphics.Color;
import java.util.*;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.google.gson.Gson;

//import android.util.Log;

public class HabitPlugin extends CordovaPlugin {
  
  private static final String TAG = "HabitPlugin";

  @Override
  public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
      if (action.equals("getDeviceInfo")) {
      	this.getDeviceInfo(callbackContext, args.getString(0), args.getString(1));
      	return true;   
      
      } else if (action.equals("performTests")) {
        this.performTests(callbackContext, args.getString(0), args.getString(1), args.getString(2), args.getString(3), args.getString(4), args.getString(5), args.getString(6), args.getBoolean(7), args.getString(8));	    
        return true;  

      } else {
        callbackContext.error("\"" + action + "\" is not a recognized action.");
        return false;

        }
    }
		
  private void performTests(final CallbackContext callbackContext, final String appid, final String apikey, final String serialnumber, final String imei, final String testsToPerform, final String language, final String themecolor, final boolean hidesstartcreen, final String screencustomization){
   cordova.getThreadPool().execute(new Runnable() {
        public void run() {
          try {			  
		DeviceHealth.setLanguage(cordova.getActivity().getApplicationContext(), language);
        	DeviceHealth.setThemeColor(cordova.getActivity().getApplicationContext(), Color.parseColor(themecolor));
        	DeviceHealth.hideStartScreen(hidesstartcreen);
		  
		Gson g = new Gson();  
    	 	MyCustomization cust = g.fromJson(screencustomization, MyCustomization.class);
		  		
		List<String> testsList = new ArrayList<String>();
		if(testsToPerform.contains("ScreenType.buttons_v2"))
			testsList.add(ScreenType.buttons_v2);
		if(testsToPerform.contains("ScreenType.charging_v2"))
			testsList.add(ScreenType.charging_v2);
		if(testsToPerform.contains("ScreenType.multi_touch_v2"))
			testsList.add(ScreenType.multi_touch_v2);
		if(testsToPerform.contains("ScreenType.device_front_video_v2"))
			testsList.add(ScreenType.device_front_video_v2);
		  
		 String[] testsToPerform2 = new String[testsList.size()];
		 testsList.toArray(testsToPerform2);
		  
		Customization customization = new Customization();

		ButtonStyle buttonStyle = new ButtonStyle();
		buttonStyle.setBackgroundColor(Color.parseColor(cust.ButtonStyleBackgroundColor));
		buttonStyle.setForegroundColor(Color.parseColor(cust.ButtonStyleForegroundColor));
		buttonStyle.setBorderType(BorderType.valueOf(cust.ButtonStyleBorderType));
		customization.setButtonsStyle(buttonStyle);

		customization.setSkipTestButtonColor(Color.parseColor(cust.StyleSkipTestButtonColor));
		customization.setProgressBarBackgroundColor(Color.parseColor(cust.StyleProgressBarBackgroundColor));
		customization.setProgressBarSelectedColor(Color.parseColor(cust.ProgressBarSelectedColor));
		customization.setCustomNavigationBarBackgroundColor(Color.parseColor(cust.CustomNavigationBarBackgroundColor));
		customization.setCustomNavigationBarTextColor(Color.parseColor(cust.CustomNavigationBarTextColor));
		customization.setCustomNavigationBarButtonsTextColor(Color.parseColor(cust.CustomNavigationBarButtonsTextColor));

		Map<String, String> customStartCopy = new HashMap<>();
		//Start Screen
		customStartCopy.put(ScreenCustomizationKeys.start_screen.Copy.title, cust.ScreenTitle);
		customStartCopy.put(ScreenCustomizationKeys.start_screen.Copy.description, cust.ScreenDescription);
		//End Screen
		Map<String, String> customEndCopy = new HashMap<>();
		customEndCopy.put(ScreenCustomizationKeys.end_screen.Copy.text, cust.CustomEndScreenText);
                customEndCopy.put(ScreenCustomizationKeys.end_screen.Copy.buttonFinish, cust.CustomEndScreenButtonFinish);
                customEndCopy.put(ScreenCustomizationKeys.end_screen.Copy.buttonTestAgain, cust.CustomEndScreenButtonTestAgain);

		//Map<String, Drawable> images = new HashMap<>();
		//images.put(ScreenCustomizationKeys.start_screen.Elements.image, context.getDrawable(R.drawable.your_custom_image));

		CustomizableScreen screen = new CustomizableScreen();
		screen.screenType = ScreenType.start_screen;
		screen.backgroundColor = Color.parseColor(cust.ScreenBackgroundColor);
		screen.textAccentColor = Color.parseColor(cust.ScreenTextAccentColor);
		screen.textColor = Color.parseColor(cust.ScreenTestColor);
		//screen.images = images;
		screen.copyStrings = customStartCopy;
		  
		CustomizableScreen screen2 = new CustomizableScreen();
		screen2.screenType = ScreenType.end_screen;
		screen2.backgroundColor = Color.parseColor(cust.ScreenBackgroundColor);
		//screen2.textAccentColor = Color.parseColor(cust.ScreenTextAccentColor);
		//screen2.textColor = Color.parseColor(cust.ScreenTestColor);
		screen2.copyStrings = customEndCopy;

		CustomizableScreen[] customScreens = new CustomizableScreen[]{ screen, screen2 };

		customization.setCustomScreens(customScreens);
		  
		DeviceHealth.performTests(cordova.getActivity().getApplicationContext(), cordova.getActivity(), appid, apikey, serialnumber == "null" ? null : serialnumber, imei == "null" ? null : imei, testsToPerform2, customization, new TestCallback() {
		@Override
		public void onResponse(JSONObject obj) {
			if (obj != null) {              
			    callbackContext.success(obj);
			} else {
			    callbackContext.error("Error performing device test - Empty obj");
			}
		    }
		});
          } catch (Exception e) {
            callbackContext.error(e.getMessage());
          }
      } });
  }
    
  private void getDeviceInfo(final CallbackContext callbackContext, final String serialnumber, final String imei) {      
      cordova.getThreadPool().execute(new Runnable() {
        public void run() {
          try {	
		//String TAG = "HabitPlugin";
		//Log.d(TAG, "getDeviceInfo");
		  
		DeviceHealth.getDeviceInfo(cordova.getActivity().getApplicationContext(), cordova.getActivity(), serialnumber == "null" ? null : serialnumber, imei == "null" ? null : imei, new DeviceInfoCallback() {
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
