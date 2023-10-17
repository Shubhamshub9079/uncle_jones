import 'package:UncleJons/app_config.dart';
import 'package:UncleJons/data_model/carriers_response.dart';
import 'package:UncleJons/data_model/check_response_model.dart';
import 'package:UncleJons/data_model/delivery_info_response.dart';
import 'package:UncleJons/helpers/response_check.dart';
import 'package:UncleJons/helpers/shared_value_helper.dart';
import 'package:UncleJons/repositories/api-request.dart';


class ShippingRepository{
  Future<dynamic> getDeliveryInfo() async {
    String url =
    ("${AppConfig.BASE_URL}/delivery-info");
    print(url.toString());
    final response = await ApiRequest.get(
      url:url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$!,
      },
    );

    bool checkResult = ResponseCheck.apply(response.body);

    if(!checkResult)
      return responseCheckModelFromJson(response.body);


    return deliveryInfoResponseFromJson(response.body);
  }

}