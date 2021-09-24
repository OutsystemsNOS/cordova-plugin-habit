#import <Cordova/CDVPlugin.h>

@interface HabitPlugin : CDVPlugin {
}

// The hooks for our plugin commands
- (void)getDeviceInfo:(CDVInvokedUrlCommand *)command;
- (void)performTests:(CDVInvokedUrlCommand *)command;

@property(nonatomic, copy) NSString *deviceInfoCallback;
@property(nonatomic, copy) NSString *performTestsCallback;

@end
