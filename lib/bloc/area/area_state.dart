part of 'area_bloc.dart';

@immutable
abstract class AreaState {}

class AreaInitial extends AreaState {}

//Start: Area Food
class GetAreaSuccess extends AreaState {
  GetAreaSuccess();
}

class GetAreaError extends AreaState {
  final String? errorMessage;
  GetAreaError({this.errorMessage});
}

class GetAreaLoading extends AreaState {}
//End: Area Food

//Start: List Food Per Area 
class GetFoodAreaSuccess extends AreaState {
  GetFoodAreaSuccess();
}

class GetFoodAreaError extends AreaState {
  final String? errorMessage;
  GetFoodAreaError({this.errorMessage});
}

class GetFoodAreaLoading extends AreaState {}
//End: List Food Per Area 
