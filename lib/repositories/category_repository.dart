import 'dart:convert';
import 'package:UncleJons/app_config.dart';
import 'package:UncleJons/data_model/HomeCategoryResponse.dart';
import 'package:UncleJons/data_model/sub_category_response.dart';
import 'package:UncleJons/repositories/api-request.dart';
import 'package:UncleJons/data_model/category_response.dart';
import 'package:UncleJons/helpers/shared_value_helper.dart';

import '../data_model/PatanjaliModel.dart';
import '../data_model/customer_package_response.dart';
import '../data_model/kitchenModel.dart';

class CategoryRepository {
  Future<CategoryResponse> getCategories({parent_id = 0}) async {
    String url = ("${AppConfig.BASE_URL}/categories?parent_id=${parent_id}");
    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
    });
    // print("${AppConfig.BASE_URL}/categories?parent_id=${parent_id}");
    // print(response.body.toString());
    return categoryResponseFromJson(response.body);
  }

  Future<CategoryResponse> getFeturedCategories() async {
    String url = ("${AppConfig.BASE_URL}/categories/featured");
    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
    });
    //print(response.body.toString());
    //print("--featured cat--");
    return categoryResponseFromJson(response.body);
  }

  Future<CategoryResponse> getTopCategories() async {
    String url = ("${AppConfig.BASE_URL}/categories/top");
    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
    });
    return categoryResponseFromJson(response.body);
  }

  Future<HomeCategoryResponse> getHomeCategoryDairyBeverage() async {
    String url = ("${AppConfig.BASE_URL}/products/category/5");
    final response = await ApiRequest.get(url: url);
    return homeCategoryFromJson(response.body);
  }


  Future<HomeCategoryResponse> getHomeGrocery() async {
    String url = ("${AppConfig.BASE_URL}/products/category/6");
    final response = await ApiRequest.get(url: url);
    return homeCategoryFromJson(response.body);
  }

  Future<HomeCategoryResponse> getHomePersonal() async {
    String url = ("${AppConfig.BASE_URL}/products/category/8");
    final response = await ApiRequest.get(url: url);
    return homeCategoryFromJson(response.body);
  }

  Future<HomeCategoryResponse> getHomeCake() async {
    String url = ("${AppConfig.BASE_URL}/products/category/12");
    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
    });
    return homeCategoryFromJson(response.body);
  }






  Future<HomeCategoryResponse> getHomePackageFood() async {
    String url = ("${AppConfig.BASE_URL}/products/category/15");
    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
    });
    return homeCategoryFromJson(response.body);
  }

  Future<HomeCategoryResponse> getHomeStationary() async {
    String url = ("${AppConfig.BASE_URL}/products/category/16");
    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
    });
    return homeCategoryFromJson(response.body);
  }



  Future<PatanjaliModel> getHomePatanjali() async {
    String url = ("${AppConfig.BASE_URL}/products/category/273");
    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
    });
    return  PatanjaliModel.fromJson(json.decode(response.body));
  }


  Future<HomeCategoryResponse> getHomeNewKitchen() async {
    String url = ("${AppConfig.BASE_URL}/products/category/14");
    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
    });
    return homeCategoryFromJson(response.body);
  }



  Future<SubCategory> getSubCategories(id) async {
    String url = ("${AppConfig.BASE_URL}/sub-categories/$id");
    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
    });
    return SubCategory.fromJson(json.decode(response.body));
  }

  Future<CategoryResponse> getFilterPageCategories() async {
    String url = ("${AppConfig.BASE_URL}/filter/categories");
    final response = await ApiRequest.get(url: url, headers: {
      "App-Language": app_language.$!,
    });
    return categoryResponseFromJson(response.body);
  }
}
