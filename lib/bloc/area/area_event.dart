part of 'area_bloc.dart';

@immutable
abstract class AreaEvent {}

class GetAreaRequest extends AreaEvent {
  GetAreaRequest();
}

class GetFoodAreaRequest extends AreaEvent {
  final String name;
  GetFoodAreaRequest(this.name);
}