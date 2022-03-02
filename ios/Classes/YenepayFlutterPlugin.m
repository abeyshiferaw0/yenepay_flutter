#import "YenepayFlutterPlugin.h"
#if __has_include(<yenepay_flutter/yenepay_flutter-Swift.h>)
#import <yenepay_flutter/yenepay_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "yenepay_flutter-Swift.h"
#endif

@implementation YenepayFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftYenepayFlutterPlugin registerWithRegistrar:registrar];
}
@end
