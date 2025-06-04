part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class GetCategoryRequest extends CategoryEvent {
  GetCategoryRequest();
}
