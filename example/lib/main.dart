import 'package:flutter/material.dart';
import 'package:yenepay_flutter/models/enums.dart';
import 'package:yenepay_flutter/models/yenepay_item.dart';
import 'package:yenepay_flutter/models/yenepay_parameters.dart';
import 'package:yenepay_flutter/yenepay_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    YenepayFlutter.init(
      onPaymentSuccess: (List<YenepayItem> items) {
        print("onPaymentSuccess ${items.length} ${items[0].itemName}");
      },
      onPaymentCancel: (List<YenepayItem> items) {
        print("onPaymentCancel ${items.length} ${items[0].itemName}");
      },
      onPaymentFailure: (List<YenepayItem> items) {
        print("onPaymentFailure ${items.length} ${items[0].itemName}");
      },
      onError: (e) {
        print("onError ${e.toString()}");
      },
    );

    ///start payment
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
    super.initState();
  }

  @override
  void dispose() {
    YenepayFlutter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
