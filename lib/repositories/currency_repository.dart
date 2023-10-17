import 'package:UncleJons/app_config.dart';
import 'package:UncleJons/data_model/addons_response.dart';
import 'package:UncleJons/data_model/currency_response.dart';
import 'package:UncleJons/repositories/api-request.dart';
import 'package:http/http.dart' as http;

class CurrencyRepository{
Future<CurrencyResponse> getListResponse() async{
  String url=('${AppConfig.BASE_URL}/currencies');

  final response = await ApiRequest.get(url: url);
  return currencyResponseFromJson(response.body);
}
}