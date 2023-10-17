import 'package:UncleJons/app_config.dart';
import 'package:UncleJons/data_model/check_response_model.dart';
import 'package:UncleJons/helpers/response_check.dart';
import 'package:UncleJons/middlewares/banned_user.dart';
import 'package:UncleJons/repositories/api-request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:UncleJons/data_model/offline_payment_submit_response.dart';

import 'package:UncleJons/helpers/shared_value_helper.dart';
import 'package:flutter/foundation.dart';

class OfflinePaymentRepository {
  Future<dynamic> getOfflinePaymentSubmitResponse(
      {required int? order_id,
      required String amount,
      required String name,
      required String trx_id,
      required int? photo}) async {
    var post_body = jsonEncode({
      "order_id": "$order_id",
      "amount": "$amount",
      "name": "$name",
      "trx_id": "$trx_id",
      "photo": "$photo",
    });

    String url=("${AppConfig.BASE_URL}/offline/payment/submit");

    print(post_body);
    print(url);

    final response = await ApiRequest.post(url:url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!
        },
        body: post_body,
      middleware: BannedUser()
    );
      return offlinePaymentSubmitResponseFromJson(response.body);
  }



}
