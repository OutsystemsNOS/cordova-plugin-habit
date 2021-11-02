#import "HabitPlugin.h"
#import "MyCustomization.h"

@import DeviceHealth;

@implementation MyCustomization
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
        
        /*
        
        [DeviceHealthSDK shared].language = SupportedLanguagePortuguese;
        
        [DeviceHealthSDK shared].themeColor =  [UIColor colorWithRed:156/255 green:34/255 blue:93/255 alpha:1.0];
        
        [DeviceHealthSDK shared].hideStartScreen  = true;
        
        NSArray * selectedTests = [NSArray arrayWithObjects:ScreenType.buttons_v2, ScreenType.charging_v2, ScreenType.multi_touch_v2, ScreenType.device_front_video_v2, nil];
        
        Customization * customization = [[Customization alloc] init];
        customization.skipTestButtonColor = [UIColor blackColor];
        customization.buttonsStyle.backgroundColor = [UIColor blueColor];
        customization.buttonsStyle.foregroundColor = [UIColor whiteColor];
        customization.buttonsStyle.borderType = BorderTypeSquare;
        customization.progressBarBackgroundColor = [UIColor whiteColor];
        customization.progressBarSelectedColor = [UIColor blackColor];

        customization.customNavigationBarBackgroundColor = [UIColor blueColor];
        customization.customNavigationBarTextColor = [UIColor blackColor];
        customization.customNavigationBarButtonsTextColor = [UIColor whiteColor];
        
        Customization * customization = [[Customization alloc] init];

        CustomizableScreen * screen = [[CustomizableScreen alloc] init];
        screen.screenType = ScreenType.start_screen;
        screen.backgroundColor = [UIColor whiteColor];
        screen.textColor = [UIColor blackColor];
        screen.textAccentColor = [UIColor blueColor];
        //NSDictionary * images = @{ScreenCustomizationKeysStartScreenElements.image: [UIImage imageNamed:@"customImage"]};
        //screen.images = images;

        NSDictionary * customStartCopy = @{ScreenCustomizationKeysStartScreenCopy.title : @"Your custom title", ScreenCustomizationKeysStartScreenCopy.text : @"Your custom text"};
        screen.copyStrings = customStartCopy;

        customization.customScreens = [NSArray arrayWithObjects: screen, nil];
                
        @try{
        [[DeviceHealthSDK shared] performTestsWithAppID:appid apiKey:apikey testsToPerform:selectedTests imei:imeinumber serialNumber:serialnumber customization:customization completion:^(NSDictionary<NSString *,id> * result) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
        }@catch (NSException* exception) {
              CDVPluginResult* pluginResultErr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[exception reason]];  
              [self.commandDelegate sendPluginResult:pluginResultErr callbackId:command.callbackId];
        }
        */
}

@end
