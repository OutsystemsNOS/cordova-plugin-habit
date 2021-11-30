
## cordova-plugin-habit

This plugin can be used to interact with Habit native SDK`s through cordova apps.

### Methods

#### getDeviceInfo

```bash
window.Habit.getDeviceInfo($parameters.SerialNumber, $parameters.IMEI, success, error);
```

#### performTests

```bash
window.Habit.performTests($parameters.AppID, $parameters.APIKey, $parameters.SerialNumber, $parameters.IMEI, $parameters.ArrayTests,$parameters.Language,$parameters.ThemeColor, $parameters.HideStartScreen, $parameters.Customization, success, error);
```
    
