import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/models/food_model.dart';
import 'package:foodies/utils/app_constant.dart';

class FoodController {
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

  //START: Random Food
  Future<FoodModel> getRandomFood() async {
    try {
      response = await dio.get(
        "$baseUrl/random.php",
      );

      var data = FoodModel.fromJson(response.data["meals"][0]);
      debugPrint("$data nya");
      return data;
    } on DioException catch (e) {
      debugPrint("DioException: ${e.message}");
      debugPrint("Status CODE: ${e.response?.statusCode}");
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
  //END: Random Food

  //START: Detail Food
  Future<FoodModel> getDetailFood(String foodId) async {
    try {
      response = await dio.get(
        "$baseUrl/lookup.php?i=$foodId",
      );

      var data = FoodModel.fromJson(response.data["meals"][0]);
      debugPrint("$data nya");
      return data;
    } on DioException catch (e) {
      debugPrint("DioException Detail Food: ${e.message}");
      debugPrint("Status CODE Detail Food: ${e.response?.statusCode}");
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
  //END: Detail Food
}
