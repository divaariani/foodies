part of 'area_bloc.dart';

@immutable
abstract class AreaEvent {}

class GetAreaRequest extends AreaEvent {
  GetAreaRequest();
}
