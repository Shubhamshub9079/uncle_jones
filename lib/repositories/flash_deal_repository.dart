import 'package:UncleJons/app_config.dart';
import 'package:UncleJons/repositories/api-request.dart';
import 'package:http/http.dart' as http;
import 'package:UncleJons/data_model/flash_deal_response.dart';
import 'package:UncleJons/helpers/shared_value_helper.dart';

class FlashDealRepository {
  Future<FlashDealResponse> getFlashDeals() async {
    String url = "${AppConfig.BASE_URL}/flash-deals";
    final response = await ApiRequest.get(
      url: url,
      headers: {
        "App-Language": app_language.$!,
      },
    );

    print('Status Code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Flash deal response: ${response.body}');

    return flashDealResponseFromJson(response.body.toString());
  }
}

