import 'dart:async';

import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yenepay_flutter/constants.dart';
import 'package:yenepay_flutter/models/enums.dart';
import 'package:yenepay_flutter/models/yenepay_item.dart';
import 'package:yenepay_flutter/models/yenepay_parameters.dart';
import 'package:yenepay_flutter/util/checkout_url_generater.dart';
import 'package:yenepay_flutter/util/error_handler.dart';
import 'package:yenepay_flutter/util/payment_util.dart';

class YenepayFlutter {
  static late StreamSubscription _sub;
  static void init({
    required Function(List<YenepayItem> items) onPaymentSuccess,
    required Function(List<YenepayItem> items) onPaymentCancel,
    required Function(List<YenepayItem> items) onPaymentFailure,
    required Function(Exception) onError,
  }) {
    _sub = linkStream.listen((String? link) async {
      ///HANDLE IF LINK NULL ERROR
      if (link == null) {
        await closeWebView();
        onError(
          ErrorHandler.handleError(
            msg: '${Constants.tag} - error reading link',
          ),
        );
      }
      if (link == null) return;

      ///HANDLE PAYMENT CANCLED
      if (PaymentUtil.isCancelUrl(link)) {
        await closeWebView();
        onPaymentCancel(PaymentUtil.getItems(link));
      }

      ///HANDLE PAYMENT FAILURE
      if (PaymentUtil.isFailureUrl(link)) {
        await closeWebView();
        onPaymentFailure(PaymentUtil.getItems(link));
      }

      ///HANDLE PAYMENT SUCCESS
      if (PaymentUtil.isSuccessUrl(link)) {
        await closeWebView();
        onPaymentSuccess(PaymentUtil.getItems(link));
      }
      print('${Constants.tag} $link');
    }, onError: (err) {
      ///HANDLE STREAM SUB ERROR
      onError(err);
    });
  }

  static void startPayment(
      {required bool isTestEnv,
      required YenepayParameters yenepayParameters}) async {
    ///HANDLE EXPRESS CAN ONLY HAVE ONE ITEM ERROR
    if (yenepayParameters.process == YenepayProcess.Express) {
      if (yenepayParameters.items.length > 1) {
        throw ErrorHandler.handleError(
          msg:
              '${Constants.tag} - YenepayProcess express can only have one item',
        );
      }
    }

    ///GENERATE CHECK OUT LINK
    Uri uri =
        await CheckoutUrlGenerator.generateUrl(isTestEnv, yenepayParameters);

    ///CHECK IF URL CAN BE LAUNCHED
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw ErrorHandler.handleError(
        msg:
            '${Constants.tag} - generated url can not be lauched - try using a real device',
      );
    }
  }

  static void stopPayment() async {
    await closeWebView();
  }

  static void dispose() {
    _sub.cancel();
  }
}
