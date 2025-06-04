part of 'food_bloc.dart';

@immutable
abstract class FoodEvent {}

class GetRandomFoodRequest extends FoodEvent {
  GetRandomFoodRequest();
}

class GetDetailFoodRequest extends FoodEvent {
  final String foodId;
  GetDetailFoodRequest(this.foodId);
}
