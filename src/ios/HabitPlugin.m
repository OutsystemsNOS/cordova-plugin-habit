#import "HabitPlugin.h"

@import DeviceHealth;

@implementation HabitPlugin

- (void)getDeviceInfo:(CDVInvokedUrlCommand *)command {
        NSString* serialnumber = [command.arguments objectAtIndex:0];
        NSString* imeinumber = [command.arguments objectAtIndex:1];
        __block CDVPluginResult* pluginResult = nil;
        
        @try{   
                [[DeviceHealthSDK shared] getDeviceInfoWithImei:imeinumber serialNumber:serialnumber SWIFT_WARN_UNUSED_RESULT) {
                        if (result != nil) {
                                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:SWIFT_WARN_UNUSED_RESULT];
                        } else {
                                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Some error getting device info"];
                        }                                                                                                                                                                    
                        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                }];
        }@catch (NSException* exception) {
              pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[exception reason]];  
              [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
}

- (void)performTests:(CDVInvokedUrlCommand *)command {
        NSString* appid = [command.arguments objectAtIndex:0];
        NSString* apikey = [command.arguments objectAtIndex:1];
        NSString* serialnumber = [command.arguments objectAtIndex:2];
        NSString* imei = [command.arguments objectAtIndex:3];
        NSString* testsToPerform = [command.arguments objectAtIndex:4];
        NSString* language = [command.arguments objectAtIndex:5];
        NSString* themecolor = [command.arguments objectAtIndex:6];
        BOOL hidesstartcreen = [[command.arguments objectAtIndex:7] boolValue];
        NSString* screencustomization = [command.arguments objectAtIndex:8];
        
        __block CDVPluginResult* pluginResult = nil;
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Ok"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
