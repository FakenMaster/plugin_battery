#import "BatteryPlugin.h"

@implementation BatteryPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"battery"
            binaryMessenger:[registrar messenger]];
  BatteryPlugin* instance = [[BatteryPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

__weak typeof(self) weakSelf = self;

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } if ([@"getBatteryLevel" isEqualToString:call.method]) {
          int batteryLevel = [weakSelf getBatteryLevel];

          if (batteryLevel == -1) {
            result([FlutterError errorWithCode:@"UNAVAILABLE"
                                       message:@"Battery info unavailable"
                                       details:nil]);
          } else {
            result(@(batteryLevel));
          }
        } else {
    result(FlutterMethodNotImplemented);
  }
}

- (int)getBatteryLevel {
  UIDevice* device = UIDevice.currentDevice;
  device.batteryMonitoringEnabled = YES;
  if (device.batteryState == UIDeviceBatteryStateUnknown) {
    return -1;
  } else {
    return (int)(device.batteryLevel * 100);
  }
}

@end
