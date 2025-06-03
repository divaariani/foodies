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
