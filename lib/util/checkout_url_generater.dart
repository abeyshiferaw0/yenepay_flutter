import 'package:dio/dio.dart';
import 'package:yenepay_flutter/constants.dart';
import 'package:yenepay_flutter/models/yenepay_parameters.dart';
import 'package:yenepay_flutter/util/error_handler.dart';

class CheckoutUrlGenerator {
  static Future<Uri> generateUrl(
      bool isTestEnv, YenepayParameters yenepayParameters) async {
    try {
      var response = await Dio().post(
        isTestEnv ? Constants.testUrl : Constants.productionUrl,
        data: getParams(yenepayParameters),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if (response.statusCode == 200) {
        return Uri.parse(response.data['result']);
      } else {
        throw ErrorHandler.handleError(
          msg: '${Constants.tag} - error_code UNK',
        );
      }
    } catch (e) {
      if (e is DioError) {
        throw ErrorHandler.handleError(
            msg:
                '${Constants.tag} - ${e.message} - ${e.response != null ? e.response!.data : ''}');
      } else {
        throw ErrorHandler.handleError(
          msg: '${Constants.tag} - error_code UNK - ${e.toString()}',
        );
      }
    }
  }

  static Map getParams(YenepayParameters yenepayParameters) {
    print(yenepayParameters.toJson());
    return yenepayParameters.toJson();
  }
}
