#import <Cordova/CDV.h>


@interface HabitPlugin : CDVPlugin {
}

@property (nonatomic, readwrite) NSString *ScreenTitle;

// The hooks for our plugin commands
- (void)getDeviceInfo:(CDVInvokedUrlCommand *)command;
- (void)performTests:(CDVInvokedUrlCommand *)command;

@end
