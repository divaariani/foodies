part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class GetCategoryRequest extends CategoryEvent {
  GetCategoryRequest();
}

class GetFoodCategoryRequest extends CategoryEvent {
  final String name;
  GetFoodCategoryRequest(this.name);
}
