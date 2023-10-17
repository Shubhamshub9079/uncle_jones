import 'package:UncleJons/app_config.dart';
import 'package:UncleJons/data_model/check_response_model.dart';
import 'package:UncleJons/helpers/response_check.dart';
import 'dart:convert';
import 'package:UncleJons/helpers/shared_value_helper.dart';
import 'package:UncleJons/middlewares/banned_user.dart';
import 'package:UncleJons/repositories/api-request.dart';
import 'package:flutter/foundation.dart';
import 'package:UncleJons/data_model/clubpoint_response.dart';
import 'package:UncleJons/data_model/clubpoint_to_wallet_response.dart';

class ClubpointRepository {
  Future<dynamic> getClubPointListResponse(
      { page = 1}) async {
    String url=(
        "${AppConfig.BASE_URL}/clubpoint/get-list?page=$page");
    print("url(${url.toString()}) access token (Bearer ${access_token.$})");
    final response = await ApiRequest.get(
      url:url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$!
      },
      middleware: BannedUser()
    );
    return clubpointResponseFromJson(response.body);
  }

  Future<dynamic> getClubpointToWalletResponse(
       int? id) async {
    var post_body = jsonEncode({
      "id": "${id}",
    });
    String url=("${AppConfig.BASE_URL}/clubpoint/convert-into-wallet");
    final response = await ApiRequest.post(url:url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$!
        },
        body: post_body,
      middleware: BannedUser()
    );
    return clubpointToWalletResponseFromJson(response.body);
  }
}
