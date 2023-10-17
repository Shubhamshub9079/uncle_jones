import 'package:UncleJons/app_config.dart';
import 'package:UncleJons/data_model/check_response_model.dart';
import 'package:UncleJons/helpers/response_check.dart';
import 'package:UncleJons/middlewares/banned_user.dart';
import 'package:UncleJons/repositories/api-request.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:UncleJons/data_model/coupon_apply_response.dart';
import 'package:UncleJons/data_model/coupon_remove_response.dart';
import 'package:UncleJons/helpers/shared_value_helper.dart';

class CouponRepository {
  Future<dynamic> getCouponApplyResponse(
       String coupon_code) async {
    var post_body =
        jsonEncode({"user_id": "${user_id.$}", "coupon_code": "$coupon_code"});

    String url=("${AppConfig.BASE_URL}/coupon-apply");
    final response = await ApiRequest.post(url:url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!
        },
        body: post_body,
      middleware: BannedUser()
    );
    return couponApplyResponseFromJson(response.body);
  }

  Future<dynamic> getCouponRemoveResponse() async {
    var post_body = jsonEncode({"user_id": "${user_id.$}"});

    String url=("${AppConfig.BASE_URL}/coupon-remove");
    final response = await ApiRequest.post(url:url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!
        },
        body: post_body,
      middleware: BannedUser()
    );
    return couponRemoveResponseFromJson(response.body);
  }
}
