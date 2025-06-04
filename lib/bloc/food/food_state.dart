part of 'food_bloc.dart';

@immutable
abstract class FoodState {}

class FoodInitial extends FoodState {}

//Start: Random Food
class GetRandomFoodSuccess extends FoodState {
  GetRandomFoodSuccess();
}

class GetRandomFoodError extends FoodState {
  final String? errorMessage;
  GetRandomFoodError({this.errorMessage});
}

class GetRandomFoodLoading extends FoodState {}
//End: Random Food

//Start: Detail Food
class GetDetailFoodSuccess extends FoodState {
  GetDetailFoodSuccess();
}

class GetDetailFoodError extends FoodState {
  final String? errorMessage;
  GetDetailFoodError({this.errorMessage});
}

class  GetDetailFoodLoading extends FoodState {}
//End: Detail Food
