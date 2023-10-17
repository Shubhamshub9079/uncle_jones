import 'package:UncleJons/app_config.dart';
import 'package:UncleJons/repositories/api-request.dart';
import 'package:http/http.dart' as http;
import 'package:UncleJons/data_model/slider_response.dart';
import 'package:UncleJons/helpers/shared_value_helper.dart';
class SlidersRepository {
  Future<SliderResponse> getSliders() async {

    String url =  ("${AppConfig.BASE_URL}/sliders");
    final response =
        await ApiRequest.get(url: url,
          headers: {
            "App-Language": app_language.$!,
          },);
    /*print(response.body.toString());
    print("sliders");*/
    return sliderResponseFromJson(response.body);
  }

  Future<SliderResponse> getBannerOneImages() async {
    String url =  ("${AppConfig.BASE_URL}/banners-one");
    final response =
    await ApiRequest.get(url: url,
      headers: {
        "App-Language": app_language.$!,
      },);
    /*print(response.body.toString());
    print("sliders");*/
    return sliderResponseFromJson(response.body);
  }

  Future<SliderResponse> getBannerTwoImages() async {

    String url =  ("${AppConfig.BASE_URL}/banners-two");
    print(url.toString());
    final response =
    await ApiRequest.get(url: url,
      headers: {
        "App-Language": app_language.$!,
      },);
    /*print(response.body.toString());
    print("sliders");*/
    return sliderResponseFromJson(response.body);
  }

  Future<SliderResponse> getBannerThreeImages() async {

    String url =  ("${AppConfig.BASE_URL}/banners-three");
    final response =
    await ApiRequest.get(url: url,
      headers: {
        "App-Language": app_language.$!,
      },);
    /*print(response.body.toString());
    print("sliders");*/
    return sliderResponseFromJson(response.body);
  }
}
