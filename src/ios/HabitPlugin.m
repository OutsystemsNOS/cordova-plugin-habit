#import "HabitPlugin.h"

@import DeviceHealth;

@implementation HabitPlugin

- (void)getDeviceInfo:(CDVInvokedUrlCommand *)command {
        NSString* serialnumber = [command.arguments objectAtIndex:0];
        NSString* imeinumber = [command.arguments objectAtIndex:1];
        
        @try{   
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[[DeviceHealthSDK shared] getDeviceInfoWithImei:imeinumber serialNumber:serialnumber]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }@catch (NSException* exception) {
              CDVPluginResult* pluginResultErr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[exception reason]];  
              [self.commandDelegate sendPluginResult:pluginResultErr callbackId:command.callbackId];
        }
}

- (void)performTests:(CDVInvokedUrlCommand *)command {
        NSString* appid = [command.arguments objectAtIndex:0];
        NSString* apikey = [command.arguments objectAtIndex:1];
        NSString* serialnumber = [command.arguments objectAtIndex:2];
        NSString* imeinumber = [command.arguments objectAtIndex:3];
        NSString* testsToPerform = [command.arguments objectAtIndex:4];
        NSString* language = [command.arguments objectAtIndex:5];
        NSString* themecolor = [command.arguments objectAtIndex:6];
        BOOL hidesstartcreen = [[command.arguments objectAtIndex:7] boolValue];
        NSString* screencustomization = [command.arguments objectAtIndex:8];
        
        __block CDVPluginResult* pluginResult = nil;  
        
        const selectedTests = [ScreenType.buttons_v2, ScreenType.charging_v2, ScreenType.multi_touch_v2, ScreenType.device_front_video_v2 ]
                
        const customization = Customization()

        var customStartCopy = [String: String]()
        customStartCopy[ScreenCustomizationKeys.start_screen.Copy.title] = "Your custom title"
        customStartCopy[ScreenCustomizationKeys.start_screen.Copy.description] = "Your custom description"

        //var images = [String: UIImage]()
        //images[ScreenCustomizationKeys.start_screen.Elements.image] = UIImage(named: "your_custom_image")

        const screen = CustomizableScreen(screenType : ScreenType.start_screen)
        screen.backgroundColor = UIColor.white
        screen.textAccentColor = UIColor.blue
        screen.textColor = UIColor.black
        //screen.images = images
        screen.copyStrings = customStartCopy

        customization.customScreens.append(screen)
        
        @try{
        [[DeviceHealthSDK shared] performTestsWithAppID:appid apiKey:apikey testsToPerform:selectedTests imei:imeinumber serialNumber:serialnumber customization:customization completion:^(NSDictionary<NSString *,id> * result) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
        }@catch (NSException* exception) {
              CDVPluginResult* pluginResultErr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[exception reason]];  
              [self.commandDelegate sendPluginResult:pluginResultErr callbackId:command.callbackId];
        }
}

@end
