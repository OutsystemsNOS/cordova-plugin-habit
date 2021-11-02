#import "HabitPlugin.h"
//#import "MyCustomization.h"
#import <Foundation/Foundation.h>

@import DeviceHealth;

@interface MyCustomization : NSObject
        NSString *ScreenTitle;
        NSString *ScreenDescription;
        NSString *ScreenBackgroundColor;
        NSString *ScreenTextAccentColor;
        NSString *ScreenTestColor;
        NSString *ButtonStyleBackgroundColor;
        NSString *ButtonStyleForegroundColor;
        NSString *ButtonStyleBorderType;
        NSString *StyleSkipTestButtonColor;
        NSString *StyleProgressBarBackgroundColor;
        NSString *ProgressBarSelectedColor;
        NSString *CustomNavigationBarBackgroundColor;
        NSString *CustomNavigationBarTextColor;
        NSString *CustomNavigationBarButtonsTextColor;
@end

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
        
        //Deserialize JSON to objet MyCustomization
        NSString* path  = [[NSBundle mainBundle] pathForResource:screencustomization ofType:@"json"];
        NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSDictionary  *object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

        if(! error) {
                NSMutableArray *array = [[NSMutableArray alloc] init];

        for (NSString *dictionaryKey in object) {
            MyCustomization *oMyCustomization = [[MyCustomization alloc] init];
            oMyCustomization.ScreenTitle = [[object valueForKey:dictionaryKey] objectForKey:@"ScreenTitle"];
            oMyCustomization.ScreenDescription = [[object valueForKey:dictionaryKey] objectForKey:@"ScreenDescription"];
            oMyCustomization.ScreenBackgroundColor = [[object valueForKey:dictionaryKey] objectForKey:@"ScreenBackgroundColor"];
            oMyCustomization.ScreenTextAccentColor = [[object valueForKey:dictionaryKey] objectForKey:@"ScreenTextAccentColor"];
            oMyCustomization.ScreenTestColor = [[object valueForKey:dictionaryKey] objectForKey:@"ScreenTestColor"];
            oMyCustomization.ButtonStyleBackgroundColor = [[object valueForKey:dictionaryKey] objectForKey:@"ButtonStyleBackgroundColor"];
            oMyCustomization.ButtonStyleForegroundColor = [[object valueForKey:dictionaryKey] objectForKey:@"ButtonStyleForegroundColor"];
            oMyCustomization.ButtonStyleBorderType = [[object valueForKey:dictionaryKey] objectForKey:@"ButtonStyleBorderType"];
            oMyCustomization.StyleSkipTestButtonColor = [[object valueForKey:dictionaryKey] objectForKey:@"StyleSkipTestButtonColor"];
            oMyCustomization.StyleProgressBarBackgroundColor = [[object valueForKey:dictionaryKey] objectForKey:@"StyleProgressBarBackgroundColor"];
            oMyCustomization.ProgressBarSelectedColor = [[object valueForKey:dictionaryKey] objectForKey:@"ProgressBarSelectedColor"];
            oMyCustomization.CustomNavigationBarBackgroundColor = [[object valueForKey:dictionaryKey] objectForKey:@"CustomNavigationBarBackgroundColor"];
            oMyCustomization.CustomNavigationBarTextColor = [[object valueForKey:dictionaryKey] objectForKey:@"CustomNavigationBarTextColor"];
            oMyCustomization.CustomNavigationBarButtonsTextColor = [[object valueForKey:dictionaryKey] objectForKey:@"CustomNavigationBarButtonsTextColor"];
            [array addObject:oMyCustomization];
        }
        } else {
                NSLog(@"Error in parsing JSON");
        }
        
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
