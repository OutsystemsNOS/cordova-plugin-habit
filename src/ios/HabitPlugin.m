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
       
        @try{
                [DeviceHealthSDK shared].language = SupportedLanguagePortuguese;

                [DeviceHealthSDK shared].themeColor =  [UIColor colorWithRed:156/255 green:34/255 blue:93/255 alpha:1.0];

                [DeviceHealthSDK shared].hideStartScreen  = false;

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
                NSDictionary * images = @{ScreenCustomizationKeysStartScreenElements.image: [UIImage imageNamed:@"customImage"]};
                screen.images = images;


                NSDictionary * customStartCopy = @{ScreenCustomizationKeysStartScreenCopy.title : @"Your custom title", ScreenCustomizationKeysStartScreenCopy.text : @"Your custom text"};
                screen.copyStrings = customStartCopy;

                customization.customScreens = [NSArray arrayWithObjects: screen, nil];

                NSArray * selectedTests = [NSArray arrayWithObjects:ScreenType.buttons_v2, ScreenType.charging_v2, ScreenType.multi_touch_v2, ScreenType.device_front_video_v2, nil];

                [[DeviceHealthSDK shared] performTestsWithAppID:appid apiKey:apikey testsToPerform:selectedTests imei:imeinumber serialNumber:serialnumber customization:customization completion:^(NSDictionary<NSString *,id> * result) {
                        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                }];
                
        }@catch (NSException* exception) {
                CDVPluginResult* pluginResultErr3 = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[exception reason]];  
                [self.commandDelegate sendPluginResult:pluginResultErr3 callbackId:command.callbackId];
        }
        
        
        //Version 1
        /*
        //MyCustomization
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
                
        @try{
                @try{
                //Deserialize JSON to variables
                //NSError *error = nil;
                //NSData* jsonData = [screencustomization dataUsingEncoding:NSUTF8StringEncoding];               
                //NSMutableDictionary *s = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];         
               
                ScreenTitle = @"Teste 1"; //[s objectForKey:@"ScreenTitle"];
                ScreenDescription = @"Teste 22";//[s objectForKey:@"ScreenDescription"];
                        
                }@catch (NSException* exception) {
                        CDVPluginResult* pluginResultErr3 = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Error parsing json"];  
                        [self.commandDelegate sendPluginResult:pluginResultErr3 callbackId:command.callbackId];
                }
                
                if(language == @"Portuguese"){
                        [DeviceHealthSDK shared].language = SupportedLanguagePortuguese; 
                }else{
                        [DeviceHealthSDK shared].language = SupportedLanguageEnglish;
                }

                [DeviceHealthSDK shared].themeColor =  [self colorFromHexString:themecolor];        
                [DeviceHealthSDK shared].hideStartScreen  = hidesstartcreen;
                
                NSArray* selectedTests;
                if ([testsToPerform rangeOfString:@"ScreenType.buttons_v2"].location != NSNotFound){
                        selectedTests = [selectedTests arrayByAddingObject:ScreenType.buttons_v2];        
                }else if ([testsToPerform rangeOfString:@"ScreenType.charging_v2"].location != NSNotFound){
                        selectedTests = [selectedTests arrayByAddingObject:ScreenType.charging_v2];
                }else if ([testsToPerform rangeOfString:@"ScreenType.multi_touch_v2"].location != NSNotFound){
                        selectedTests = [selectedTests arrayByAddingObject:ScreenType.multi_touch_v2];
                }else if ([testsToPerform rangeOfString:@"ScreenType.device_front_video_v2"].location != NSNotFound){
                        selectedTests = [selectedTests arrayByAddingObject:ScreenType.device_front_video_v2];
                }else{
                }
                
                Customization* customization = [[Customization alloc] init];
                customization.skipTestButtonColor = [UIColor blackColor];
                customization.buttonsStyle.backgroundColor = [UIColor blueColor];
                customization.buttonsStyle.foregroundColor = [UIColor whiteColor];
                customization.buttonsStyle.borderType = BorderTypeSquare;
                customization.progressBarBackgroundColor = [UIColor whiteColor];
                customization.progressBarSelectedColor = [UIColor blackColor];

                customization.customNavigationBarBackgroundColor = [UIColor blueColor];
                customization.customNavigationBarTextColor = [UIColor blackColor];
                customization.customNavigationBarButtonsTextColor = [UIColor whiteColor];

                CustomizableScreen* screen = [[CustomizableScreen alloc] init];
                screen.screenType = ScreenType.start_screen;
                screen.backgroundColor = [UIColor whiteColor];
                screen.textColor = [UIColor blackColor];
                screen.textAccentColor = [UIColor blueColor];
                //NSDictionary * images = @{ScreenCustomizationKeysStartScreenElements.image: [UIImage imageNamed:@"customImage"]};
                //screen.images = images;

                NSDictionary* customStartCopy = @{ScreenCustomizationKeysStartScreenCopy.title:ScreenTitle, ScreenCustomizationKeysStartScreenCopy.text:ScreenDescription};
                screen.copyStrings = customStartCopy;

                customization.customScreens = [NSArray arrayWithObjects:screen];

                @try{
                [[DeviceHealthSDK shared] performTestsWithAppID:appid apiKey:apikey testsToPerform:selectedTests imei:imeinumber serialNumber:serialnumber customization:customization completion:^(NSDictionary<NSString *,id> * result) {
                        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                }];
                }@catch (NSException* exception) {
                      CDVPluginResult* pluginResultErr2 = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Error calling performTestsWithAppID"];  
                      [self.commandDelegate sendPluginResult:pluginResultErr2 callbackId:command.callbackId];
                }
        }@catch (NSException* exception) {
              CDVPluginResult* pluginResultErr3 = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[exception reason]];  
              [self.commandDelegate sendPluginResult:pluginResultErr3 callbackId:command.callbackId];
        }
        */
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner* scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
