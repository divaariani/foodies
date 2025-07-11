import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/controllers/food_controller.dart';
import 'package:foodies/models/food_model.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodInitial()) {
    on<GetRandomFoodRequest>((event, emit) async {
      await _getRandomFood(event, emit);
    });
    on<GetDetailFoodRequest>((event, emit) async {
      await _getDetailFood(event, emit);
    });
  }

  FoodModel? randomFood;
  FoodModel? detailFood;

  Future<void> _getRandomFood(
      GetRandomFoodRequest event, Emitter<FoodState> emit) async {
    FoodController controller = FoodController();
    emit(GetRandomFoodLoading());
    try {
      FoodModel data = await controller.getRandomFood();
      randomFood = data;
      emit(GetRandomFoodSuccess());
    } catch (ex) {
      emit(GetRandomFoodError(errorMessage: ex.toString()));
    }
  }

  Future<void> _getDetailFood(
      GetDetailFoodRequest event, Emitter<FoodState> emit) async {
    FoodController controller = FoodController();
    emit(GetDetailFoodLoading());
    try {
      FoodModel data = await controller.getDetailFood(event.foodId);
      detailFood = data;
      emit(GetDetailFoodSuccess());
    } catch (ex) {
      emit(GetDetailFoodError(errorMessage: ex.toString()));
    }
  }
}
