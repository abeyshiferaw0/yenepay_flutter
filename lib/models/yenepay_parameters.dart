import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:yenepay_flutter/constants.dart';
import 'package:yenepay_flutter/models/enums.dart';
import 'package:yenepay_flutter/models/yenepay_item.dart';

class YenepayParameters {
  final YenepayProcess process;
  final String? merchantOrderId;
  final String merchantId;
  final List<YenepayItem> items;
  final String? ipnUrl;
  final int? expiresAfter;
  final int? expiresInDays;
  final double? totalItemsHandlingFee;
  final double? totalItemsDeliveryFee;
  final double? totalItemsDiscount;
  final double? totalItemsTax1;
  final double? totalItemsTax2;

  YenepayParameters({
    required this.process,
    this.merchantOrderId,
    required this.merchantId,
    required this.items,
    this.ipnUrl,
    this.expiresAfter,
    this.expiresInDays,
    this.totalItemsHandlingFee,
    this.totalItemsDeliveryFee,
    this.totalItemsDiscount,
    this.totalItemsTax1,
    this.totalItemsTax2,
  });

  Map<String, dynamic> toJson() {
    String getReturUrl(host) {
      return Uri(scheme: Constants.returnSchema, host: host, queryParameters: {
        Constants.items: jsonEncode(items.map((e) => e.toJson()).toList())
      }).toString();
    }

    return {
      "process": EnumToString.convertToString(process),
      "merchantId": merchantId,
      "items": items.map((e) => e.toJson()).toList(),
      "successUrl": getReturUrl('success'),
      "cancelUrl": getReturUrl('cancel'),
      "failureUrl": getReturUrl('failure'),
      if (merchantOrderId != null) "merchantOrderId": merchantOrderId,
      if (ipnUrl != null) "ipnUrl": ipnUrl,
      if (expiresAfter != null) "expiresAfter": expiresAfter,
      if (expiresInDays != null) "expiresInDays": expiresInDays,
      if (totalItemsHandlingFee != null)
        "totalItemsHandlingFee": totalItemsHandlingFee,
      if (totalItemsDeliveryFee != null)
        "totalItemsDeliveryFee": totalItemsDeliveryFee,
      if (totalItemsDiscount != null) "totalItemsDiscount": totalItemsDiscount,
      if (totalItemsTax1 != null) "totalItemsTax1": totalItemsTax1,
      if (totalItemsTax2 != null) "totalItemsTax2": totalItemsTax2,
    };
  }
}
