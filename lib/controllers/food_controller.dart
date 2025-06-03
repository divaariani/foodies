import 'package:dio/dio.dart';
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

      return data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        int? statusCode = e.response!.statusCode;
        if (statusCode == 500) {
          throw "500";
        }
        if (statusCode == 401) {
          throw "401";
        }
        throw "error";
      }
      throw "error";
    }
  }
  //END: Random Food
}
