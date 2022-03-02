import 'dart:convert';

import 'package:yenepay_flutter/constants.dart';
import 'package:yenepay_flutter/models/yenepay_item.dart';
import 'package:yenepay_flutter/util/error_handler.dart';
import 'package:yenepay_flutter/util/extensions.dart';

class PaymentUtil {
  static bool isSuccessUrl(String link) {
    try {
      Uri uri = Uri.parse(link);
      if (uri.scheme.clear() == Constants.returnSchema.clear()) {
        if (uri.host.clear() == Constants.successHost.clear()) {
          return true;
        }
      }
      return false;
    } catch (e) {
      throw ErrorHandler.handleError(
        msg: '${Constants.tag} - ${e.toString()}',
      );
    }
  }

  static bool isCancelUrl(String link) {
    try {
      Uri uri = Uri.parse(link);
      if (uri.scheme.clear() == Constants.returnSchema.clear()) {
        if (uri.host.clear() == Constants.cancelHost.clear()) {
          return true;
        }
      }
      return false;
    } catch (e) {
      throw ErrorHandler.handleError(
        msg: '${Constants.tag} - ${e.toString()}',
      );
    }
  }

  static bool isFailureUrl(String link) {
    try {
      Uri uri = Uri.parse(link);
      if (uri.scheme.clear() == Constants.returnSchema.clear()) {
        if (uri.host.clear() == Constants.failureHost.clear()) {
          return true;
        }
      }
      return false;
    } catch (e) {
      throw ErrorHandler.handleError(
        msg: '${Constants.tag} - ${e.toString()}',
      );
    }
  }

  static List<YenepayItem> getItems(String link) {
    final List<YenepayItem> items;
    try {
      Uri uri = Uri.parse(link);

      dynamic itemsMap = jsonDecode(uri.queryParameters[Constants.items]!);

      ///PARSE ITEMS
      items = (itemsMap as List)
          .map((yenepayItem) => YenepayItem.fromJson(yenepayItem))
          .toList();
      return items;
    } catch (e) {
      throw ErrorHandler.handleError(
        msg: '${Constants.tag} - ${e.toString()}',
      );
    }
  }
}
