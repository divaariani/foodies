part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

//Start: Category Food
class GetCategorySuccess extends CategoryState {
  GetCategorySuccess();
}

class GetCategoryError extends CategoryState {
  final String? errorMessage;
  GetCategoryError({this.errorMessage});
}

class GetCategoryLoading extends CategoryState {}
//End: Category Food
