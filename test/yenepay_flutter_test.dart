import 'package:flutter_test/flutter_test.dart';
import 'package:yenepay_flutter/models/enums.dart';
import 'package:yenepay_flutter/models/yenepay_item.dart';
import 'package:yenepay_flutter/models/yenepay_parameters.dart';
import 'package:yenepay_flutter/util/checkout_url_generater.dart';

void main() {
  // const MethodChannel channel = MethodChannel('yenepay_flutter');
  //
  // TestWidgetsFlutterBinding.ensureInitialized();
  //
  // setUp(() {
  //   channel.setMockMethodCallHandler((MethodCall methodCall) async {
  //     return '42';
  //   });
  // });
  //
  // tearDown(() {
  //   channel.setMockMethodCallHandler(null);
  // });
  //
  // test('getPlatformVersion', () async {
  //   expect(await YenepayFlutter.platformVersion, '42');
  // });

  test('generateYenepayCheckoutUrl', () async {
    expect(
      await CheckoutUrlGenerator.generateUrl(
        true,
        YenepayParameters(
          process: YenepayProcess.Express,
          merchantId: 'SB1356',
          merchantOrderId: "asdakjsdkajsd",
          totalItemsDeliveryFee: 2.3,
          totalItemsDiscount: 3.4,
          totalItemsHandlingFee: 2.2,
          totalItemsTax1: 1,
          totalItemsTax2: 2,
          expiresAfter: 24,
          items: [
            YenepayItem(quantity: 1, unitPrice: 12, itemName: 'test item')
          ],
        ),
      ),
      Uri,
    );
  });
}
