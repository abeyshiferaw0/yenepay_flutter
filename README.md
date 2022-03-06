# yenepay_flutter

A Flutter plugin for making payments via Yenepay Payment Gateway. supports Android and iOS.

## Installation

To use the plugin, add `yenepay_flutter` as a
[dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

#### For Android

You need to declare this intent filters in `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest ...>
  <!-- ... other tags -->
      <!-- Provide required visibility configuration for API level 30 and above -->
      <queries>
          <intent>
              <action android:name="android.intent.action.VIEW" />
              <data android:scheme="https" />
          </intent>
      </queries>


  <application ...>
    <activity ...>
      <!-- ... other tags -->

        <!-- Deep Links For Listning to yenepay payment status -->
        <intent-filter>
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <!-- Accepts URIs that begin with YOUR_SCHEME://YOUR_HOST -->
                <data
                    android:scheme="yenepayflutter"
                    android:host="success" />

                <data
                    android:scheme="yenepayflutter"
                    android:host="cancel" />

                <data
                    android:scheme="yenepayflutter"
                    android:host="failure" />

        </intent-filter>
    </activity>
  </application>
</manifest>
```

#### For iOS

Add this URL schemes `LSApplicationQueriesSchemes` entries in your Info.plist file.

```
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>https</string>
  <string>http</string>
</array>
```

For **Listning to yenepay payment status** you need to declare the scheme in
`ios/Runner/Info.plist` (or through Xcode's Target Info editor,
under URL Types):

```xml
<!-- ... other tags -->
<plist>
<dict>
  <!-- ... other tags -->
  <key>CFBundleURLTypes</key>
  <array>
    <dict>
      <key>CFBundleTypeRole</key>
      <string>Editor</string>
      <key>CFBundleURLName</key>
      <string>[REPLACE_WITH_YOU_APP_BUNDLE_ID]</string>
      <key>CFBundleURLSchemes</key>
      <array>
        <string>yenepayflutter</string>
      </array>
    </dict>
  </array>
  <!-- ... other tags -->
</dict>
</plist>
```

## Usage

First initialize yenepay_flutter, prefrebly on app start

```dart
import 'package:flutter/material.dart';
import 'package:yenepay_flutter/models/enums.dart';
import 'package:yenepay_flutter/models/yenepay_item.dart';
import 'package:yenepay_flutter/models/yenepay_parameters.dart';
import 'package:yenepay_flutter/yenepay_flutter.dart';

  @override
  void initState() {
    YenepayFlutter.init(
      onPaymentSuccess: (List<YenepayItem> items) {
        print("onPaymentSuccess");
      },
      onPaymentCancel: (List<YenepayItem> items) {
        print("onPaymentCancel");
      },
      onPaymentFailure: (List<YenepayItem> items) {
        print("onPaymentFailure");
      },
      onError: (e) {
        print("onError ${e.toString()}");
      },
    );

    super.initState();
  }
```


start payment process after initialization, with startPayment() method
for getting a test `merchant and buyer` account visit(https://sandbox.yenepay.com/).

```dart
    YenepayFlutter.startPayment(
      isTestEnv: true,
      yenepayParameters: YenepayParameters(
        process: YenepayProcess.Express,
        merchantId: "SB1356",
        items: [
          YenepayItem(
            itemId: '1',
            unitPrice: 12.2,
            quantity: 2,
            itemName: 'test',
          ),
        ],
      ),
    );
```

finally don't forget to call dispose when app close

```dart
  @override
  void dispose() {
    YenepayFlutter.dispose();
    super.dispose();
  }
```

