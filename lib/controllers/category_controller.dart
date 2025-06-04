import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/models/food_model.dart';
import 'package:foodies/utils/app_constant.dart';

class CategoryController {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
      contentType: "application/json",
      responseType: ResponseType.json,
    ),
  );

  late Response response;

  //START: Category Food
  Future<List<FoodModel>> getCategory() async {
    try {
      response = await dio.get(
        "$baseUrl/list.php?c=list",
      );

      List<FoodModel> result = (response.data["meals"] as List)
          .map((e) => FoodModel.fromJson(e))
          .toList();

      debugPrint("$result nya");
      return result;
    } on DioException catch (e) {
      debugPrint("DioException Category: ${e.message}");
      debugPrint("Status CODE Category: ${e.response?.statusCode}");
      if (e.type == DioExceptionType.badResponse) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == 404) {
          throw "Data tidak ditemukan";
        }
        throw "error";
      }
      throw "error";
    }
  }
  //END: Category Food

  //START: List Food Per Category
  Future<List<FoodModel>> getFoodCategory(String foodName) async {
    try {
      response = await dio.get(
        "$baseUrl/filter.php?c=$foodName",
      );

      List<FoodModel> result = (response.data["meals"] as List)
          .map((e) => FoodModel.fromJson(e))
          .toList();

      debugPrint("List Food Per Category $result");
      return result;
    } on DioException catch (e) {
      debugPrint("DioException List Food Per Category: ${e.message}");
      debugPrint("Status CODE List Food Per Category: ${e.response?.statusCode}");
      if (e.type == DioExceptionType.badResponse) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == 404) {
          throw "Data tidak ditemukan";
        }
        throw "error";
      }
      throw "error";
    }
  }
  //END: List Food Per Category
}
