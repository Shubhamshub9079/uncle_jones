import 'package:UncleJons/app_config.dart';
import 'package:UncleJons/repositories/api-request.dart';
import 'package:UncleJons/data_model/brand_response.dart';
import 'package:UncleJons/helpers/shared_value_helper.dart';

class BrandRepository {

  Future<BrandResponse> getFilterPageBrands() async {
    String url=("${AppConfig.BASE_URL}/filter/brands");
    final response =
    await ApiRequest.get(url: url,headers: {
      "App-Language": app_language.$!,
    });
    return brandResponseFromJson(response.body);
  }

  Future<BrandResponse> getBrands({name = "", page = 1}) async {
    String url=("${AppConfig.BASE_URL}/brands"+
        "?page=${page}&name=${name}");
    final response =
    await ApiRequest.get(url: url,headers: {
      "App-Language": app_language.$!,
    });
    return brandResponseFromJson(response.body);
  }



}
