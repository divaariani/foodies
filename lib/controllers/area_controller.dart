import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/models/food_model.dart';
import 'package:foodies/utils/app_constant.dart';

class AreaController {
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

  //START: Area Food
  Future<List<FoodModel>> getArea() async {
    try {
      response = await dio.get(
        "$baseUrl/list.php?a=list",
      );

      List<FoodModel> result = (response.data["meals"] as List)
          .map((e) => FoodModel.fromJson(e))
          .toList();

      debugPrint("$result nya");
      return result;
    } on DioException catch (e) {
      debugPrint("DioException Area: ${e.message}");
      debugPrint("Status CODE Area: ${e.response?.statusCode}");
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
  //END: Area Food

  //START: List Food Per Area
  Future<List<FoodModel>> getFoodArea(String foodName) async {
    try {
      response = await dio.get(
        "$baseUrl/filter.php?a=$foodName",
      );

      List<FoodModel> result = (response.data["meals"] as List)
          .map((e) => FoodModel.fromJson(e))
          .toList();

      debugPrint("List Food Per Area $result");
      return result;
    } on DioException catch (e) {
      debugPrint("DioException List Food Per Area: ${e.message}");
      debugPrint("Status CODE List Food Per Area: ${e.response?.statusCode}");
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
  //END: List Food Per Area
}
