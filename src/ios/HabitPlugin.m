#import "HabitPlugin.h"

@import DeviceHealth;

@implementation HabitPlugin

- (void)getDeviceInfo:(CDVInvokedUrlCommand *)command {
        NSString* serialnumber = [command.arguments objectAtIndex:0] != (NSString *)[NSNull null] ? [command.arguments objectAtIndex:0] : nil;
        NSString* imeinumber = [command.arguments objectAtIndex:1] != (NSString *)[NSNull null] ? [command.arguments objectAtIndex:1] : nil;
        
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
        NSString* serialnumber = [command.arguments objectAtIndex:2] != (NSString *)[NSNull null] ? [command.arguments objectAtIndex:2] : nil;
        NSString* imeinumber = [command.arguments objectAtIndex:3] != (NSString *)[NSNull null] ? [command.arguments objectAtIndex:3] : nil;
        NSString* testsToPerform = [command.arguments objectAtIndex:4];
        NSString* language = [command.arguments objectAtIndex:5];
        NSString* themecolor = [command.arguments objectAtIndex:6];
        BOOL hidesstartcreen = [[command.arguments objectAtIndex:7] boolValue];
        NSString* screencustomization = [command.arguments objectAtIndex:8];
       
        NSString* ScreenTitle;
        NSString* ScreenDescription;
        NSString* ScreenBackgroundColor;
        NSString* ScreenTextAccentColor;
        NSString* ScreenTestColor;
        NSString* ButtonStyleBackgroundColor;
        NSString* ButtonStyleForegroundColor;
        NSString* ButtonStyleBorderType;
        NSString* StyleSkipTestButtonColor;
        NSString* StyleProgressBarBackgroundColor;
        NSString* ProgressBarSelectedColor;
        NSString* CustomNavigationBarBackgroundColor;
        NSString* CustomNavigationBarTextColor;
        NSString* CustomNavigationBarButtonsTextColor;        
        NSString* CustomEndScreenText;
	NSString* CustomEndScreenButtonFinish;
	NSString* CustomEndScreenButtonTestAgain;
        
        @try{
                @try{
                //Deserialize JSON to variables
                NSError *error = nil;
                NSData* jsonData = [screencustomization dataUsingEncoding:NSUTF8StringEncoding];               
                NSMutableDictionary *s = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];         
               
                ScreenTitle = [s objectForKey:@"ScreenTitle"];
                ScreenDescription = [s objectForKey:@"ScreenDescription"];                        
                ScreenBackgroundColor = [s objectForKey:@"ScreenBackgroundColor"];
                ScreenTextAccentColor = [s objectForKey:@"ScreenTextAccentColor"];
                ScreenTestColor = [s objectForKey:@"ScreenTestColor"];
                ButtonStyleBackgroundColor = [s objectForKey:@"ButtonStyleBackgroundColor"];
                ButtonStyleForegroundColor = [s objectForKey:@"ButtonStyleForegroundColor"];
                StyleSkipTestButtonColor = [s objectForKey:@"StyleSkipTestButtonColor"];
                StyleProgressBarBackgroundColor = [s objectForKey:@"StyleProgressBarBackgroundColor"];
                ProgressBarSelectedColor = [s objectForKey:@"ProgressBarSelectedColor"];
                CustomNavigationBarBackgroundColor = [s objectForKey:@"CustomNavigationBarBackgroundColor"];
                CustomNavigationBarTextColor = [s objectForKey:@"CustomNavigationBarTextColor"];
                CustomNavigationBarButtonsTextColor = [s objectForKey:@"CustomNavigationBarButtonsTextColor"];
                CustomEndScreenText = [s objectForKey:@"CustomEndScreenText"];
                CustomEndScreenButtonFinish = [s objectForKey:@"CustomEndScreenButtonFinish"];
                CustomEndScreenButtonTestAgain = [s objectForKey:@"CustomEndScreenButtonTestAgain"];
                        
                }@catch (NSException* exception) {
                        CDVPluginResult* pluginResultErr3 = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Error parsing json"];  
                        [self.commandDelegate sendPluginResult:pluginResultErr3 callbackId:command.callbackId];
                }
                
                [DeviceHealthSDK shared].language = [language isEqualToString:@"pt"] ? SupportedLanguagePortuguese: SupportedLanguageEnglish; 

                [DeviceHealthSDK shared].themeColor =  [self colorFromHexString:themecolor];        
                [DeviceHealthSDK shared].hideStartScreen  = hidesstartcreen;

                Customization * customization = [[Customization alloc] init];
                customization.skipTestButtonColor = [self colorFromHexString:StyleSkipTestButtonColor];
                customization.buttonsStyle.backgroundColor = [self colorFromHexString:ButtonStyleBackgroundColor];
                customization.buttonsStyle.foregroundColor = [self colorFromHexString:ButtonStyleForegroundColor];
                customization.buttonsStyle.borderType = BorderTypeSquare;
                customization.progressBarBackgroundColor = [self colorFromHexString:StyleProgressBarBackgroundColor];
                customization.progressBarSelectedColor = [self colorFromHexString:ProgressBarSelectedColor];

                customization.customNavigationBarBackgroundColor = [self colorFromHexString:CustomNavigationBarBackgroundColor];
                customization.customNavigationBarTextColor = [self colorFromHexString:CustomNavigationBarTextColor];
                customization.customNavigationBarButtonsTextColor = [self colorFromHexString:CustomNavigationBarButtonsTextColor];

                CustomizableScreen * screen = [[CustomizableScreen alloc] init];
                screen.screenType = ScreenType.start_screen;
                screen.backgroundColor = [self colorFromHexString:ScreenBackgroundColor];
                screen.textColor = [self colorFromHexString:ScreenTestColor];
                screen.textAccentColor = [self colorFromHexString:ScreenTextAccentColor];
                //NSDictionary * images = @{ScreenCustomizationKeysStartScreenElements.image: [UIImage imageNamed:@"customImage"]};
                //screen.images = images;

                NSDictionary * customStartCopy = @{ScreenCustomizationKeysStartScreenCopy.title : ScreenTitle, ScreenCustomizationKeysStartScreenCopy.text : ScreenDescription, ScreenCustomizationKeysEndScreenCopy.text : CustomEndScreenText, ScreenCustomizationKeysEndScreenCopy.buttonFinish : CustomEndScreenButtonFinish, ScreenCustomizationKeysEndScreenCopy.buttonTestAgain : CustomEndScreenButtonTestAgain};
                screen.copyStrings = customStartCopy;

                customization.customScreens = [NSArray arrayWithObjects: screen, nil];
                                
                NSMutableArray* selectedTests = [NSMutableArray array];
                if ([testsToPerform rangeOfString:@"buttons_v2"].location != NSNotFound)
                {
                        [selectedTests addObject:ScreenType.buttons_v2]; 
                }
                if ([testsToPerform rangeOfString:@"charging_v2"].location != NSNotFound)
                {
                        [selectedTests addObject:ScreenType.charging_v2]; 
                }
                if ([testsToPerform rangeOfString:@"multi_touch_v2"].location != NSNotFound)
                {
                        [selectedTests addObject:ScreenType.multi_touch_v2];
                }
                if ([testsToPerform rangeOfString:@"device_front_video_v2"].location != NSNotFound)
                {
                        [selectedTests addObject:ScreenType.device_front_video_v2];
                }
                
                        
                [[DeviceHealthSDK shared] performTestsWithAppID:appid apiKey:apikey testsToPerform:selectedTests imei:imeinumber serialNumber:serialnumber customization:customization completion:^(NSDictionary<NSString *,id> * result) {
                        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];                      
                }];
                
        }@catch (NSException* exception) {
                CDVPluginResult* pluginResultErr4 = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[exception reason]];  
                [self.commandDelegate sendPluginResult:pluginResultErr4 callbackId:command.callbackId];
        }
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner* scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
