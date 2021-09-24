#import "HabitPlugin.h"
#import <Cordova/CDV.h>

@implementation HabitPlugin

@synthesize deviceInfoCallback;
@synthesize performTestsCallback;

- (void)getDeviceInfo:(CDVInvokedUrlCommand *)command {
        NSString* serialnumber = [[command.arguments objectAtIndex:0]];
        NSString* imeinumber = [[command.arguments objectAtIndex:1]];
        
        DeviceHealthSDK.shared.getDeviceInfo(imei: imeinumber, serialNumber: serialnumber) { (result) in
                print(result)
                CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:self.result];
        }
}

- (void)performTests:(CDVInvokedUrlCommand *)command {
        NSString* appid = [[command.arguments objectAtIndex:0]];
        NSString* apikey = [[command.arguments objectAtIndex:1]];
        NSString* serialnumber = [[command.arguments objectAtIndex:2]];
        NSString* imei = [[command.arguments objectAtIndex:3]];
        NSString* testsToPerform = [[command.arguments objectAtIndex:4]];
        NSString* language = [[command.arguments objectAtIndex:5]];
        NSString* themecolor = [[command.arguments objectAtIndex:6]];
        BOOL hidesstartcreen = [[command.arguments objectAtIndex:7] boolValue];
        NSString* screencustomization = [[command.arguments objectAtIndex:8]];
}
