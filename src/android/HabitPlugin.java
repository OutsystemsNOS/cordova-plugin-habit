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
        	DeviceHealth.setThemeColor(cordova.getActivity().getApplicationContext(), Color.argb(255, 3, 198, 252));
        	DeviceHealth.hideStartScreen(hidesstartcreen);
		  
		Gson g = new Gson();  
    	 	Customization cust = g.fromJson(screencustomization, Customization.class);
		  
		String[] testsToPerform2 = new String[]{ScreenType.buttons_v2, ScreenType.charging_v2, ScreenType.multi_touch_v2, ScreenType.device_front_video_v2};
		  
		String[] testsToPerform3 = testsToPerform.split(",");
		  
		Customization customization = new Customization();

		ButtonStyle buttonStyle = new ButtonStyle();
		buttonStyle.setBackgroundColor(Color.rgb(254, 242, 79));
		buttonStyle.setForegroundColor(Color.rgb(0, 0, 0));
		buttonStyle.setBorderType(BorderType.Rounded);
		customization.setButtonsStyle(buttonStyle);

		customization.setSkipTestButtonColor(Color.DKGRAY);
		customization.setProgressBarBackgroundColor(Color.rgb(0, 0, 0));
		customization.setProgressBarSelectedColor(Color.rgb(3, 198, 252));
		customization.setCustomNavigationBarBackgroundColor(Color.rgb(255, 255, 255));
		customization.setCustomNavigationBarTextColor(Color.rgb(0, 0, 0));
		customization.setCustomNavigationBarButtonsTextColor(Color.GRAY);

		Map<String, String> customStartCopy = new HashMap<>();
		customStartCopy.put(ScreenCustomizationKeys.start_screen.Copy.title, cust.ScreenTitle);
		customStartCopy.put(ScreenCustomizationKeys.start_screen.Copy.description, cust.ScreenDescription);

		//Map<String, Drawable> images = new HashMap<>();
		//images.put(ScreenCustomizationKeys.start_screen.Elements.image, context.getDrawable(R.drawable.your_custom_image));

		CustomizableScreen screen = new CustomizableScreen();
		screen.screenType = ScreenType.start_screen;
		screen.backgroundColor = Color.rgb(240, 240, 240);
		screen.textAccentColor = Color.rgb(255, 165, 0);
		screen.textColor = Color.GRAY;
		//screen.images = images;
		screen.copyStrings = customStartCopy;

		CustomizableScreen[] customScreens = new CustomizableScreen[]{ screen };

		customization.setCustomScreens(customScreens);
		  
		DeviceHealth.performTests(cordova.getActivity().getApplicationContext(), cordova.getActivity(), appid, apikey, serialnumber, imei, testsToPerform3, customization, new TestCallback() {
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
public class Customization {
	
	String ScreenTitle;
	String ScreenDescription;
	String ScreenBackgroundColor;
	String ScreenTextAccentColor;
	String ScreenTestColor;
	String ButtonStyleBackgroundColor;
	String ButtonStyleForegroundColor;
	String ButtonStyleBorderType;
	String StyleSkipTestButtonColor;
	String StyleProgressBarBackgroundColor;
	String ProgressBarSelectedColor;
	String CustomNavigationBarBackgroundColor;
	String CustomNavigationBarTextColor;
	String CustomNavigationBarButtonsTextColor;
}
