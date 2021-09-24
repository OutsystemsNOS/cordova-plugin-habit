#import <Cordova/CDVPlugin.h>

@interface HabitPlugin : CDVPlugin {
}


@property (assign) NSString* callback;

// The hooks for our plugin commands
- (void)getDeviceInfo:(CDVInvokedUrlCommand *)command;
- (void)performTests:(CDVInvokedUrlCommand *)command;

@end
