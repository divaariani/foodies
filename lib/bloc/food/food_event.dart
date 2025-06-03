part of 'food_bloc.dart';

@immutable
abstract class FoodEvent {}

class GetRandomFoodRequest extends FoodEvent {
  GetRandomFoodRequest();
}
