import 'package:UncleJons/app_config.dart';
import 'package:UncleJons/data_model/addons_response.dart';
import 'package:UncleJons/data_model/offline_wallet_recharge_response.dart';
import 'package:UncleJons/repositories/api-request.dart';
import 'package:http/http.dart' as http;

class AddonsRepository{
Future<List<AddonsListResponse>> getAddonsListResponse() async{$();
  String url=('${AppConfig.BASE_URL}/addon-list');
  final response = await ApiRequest.get(url: url);
  return addonsListResponseFromJson(response.body);

}
}



