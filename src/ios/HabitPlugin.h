#import <Cordova/CDV.h>


@interface HabitPlugin : CDVPlugin {
}

// The hooks for our plugin commands
- (void)getDeviceInfo:(CDVInvokedUrlCommand *)command;
- (void)performTests:(CDVInvokedUrlCommand *)command;

@interface MyCustomization : NSObject {
      NSString *ScreenTitle;
       /*
       @property (nonatomic, strong) NSString *ScreenDescription;
       @property (nonatomic, strong) NSString *ScreenBackgroundColor;
       @property (nonatomic, strong) NSString *ScreenTextAccentColor;
       @property (nonatomic, strong) NSString *ScreenTestColor;
       @property (nonatomic, strong) NSString *ButtonStyleBackgroundColor;
       @property (nonatomic, strong) NSString *ButtonStyleForegroundColor;
       @property (nonatomic, strong) NSString *ButtonStyleBorderType;
       @property (nonatomic, strong) NSString *StyleSkipTestButtonColor;
       @property (nonatomic, strong) NSString *StyleProgressBarBackgroundColor;
       @property (nonatomic, strong) NSString *ProgressBarSelectedColor;
       @property (nonatomic, strong) NSString *CustomNavigationBarBackgroundColor;
       @property (nonatomic, strong) NSString *CustomNavigationBarTextColor;
       @property (nonatomic, strong) NSString *CustomNavigationBarButtonsTextColor;
       */
}

@property (nonatomic, readwrite) NSString *ScreenTitle;

@end
