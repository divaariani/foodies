import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/controllers/category_controller.dart';
import 'package:foodies/models/food_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<GetCategoryRequest>((event, emit) async {
      await _getCategory(event, emit);
    });
    on<GetFoodCategoryRequest>((event, emit) async {
      await _getFoodPerCategory(event, emit);
    });
  }

  List<FoodModel>? category;
  List<FoodModel>? foodPerCategory;

  Future<void> _getCategory(
      GetCategoryRequest event, Emitter<CategoryState> emit) async {
    CategoryController controller = CategoryController();
    emit(GetCategoryLoading());
    try {
      List<FoodModel> data = await controller.getCategory();
      category = data;
      emit(GetCategorySuccess());
    } catch (ex) {
      emit(GetCategoryError(errorMessage: ex.toString()));
    }
  }

  Future<void> _getFoodPerCategory(
      GetFoodCategoryRequest event, Emitter<CategoryState> emit) async {
    CategoryController controller = CategoryController();
    emit(GetFoodCategoryLoading());
    try {
      List<FoodModel> data = await controller.getFoodCategory(event.name);
      foodPerCategory = data;
      emit(GetFoodCategorySuccess());
    } catch (ex) {
      emit(GetFoodCategoryError(errorMessage: ex.toString()));
    }
  }
}
