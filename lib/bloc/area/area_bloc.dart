import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/controllers/Area_controller.dart';
import 'package:foodies/models/food_model.dart';

part 'area_event.dart';
part 'area_state.dart';

class AreaBloc extends Bloc<AreaEvent, AreaState> {
  AreaBloc() : super(AreaInitial()) {
    on<GetAreaRequest>((event, emit) async {
      await _getArea(event, emit);
    });
  }

  List<FoodModel>? area;

  Future<void> _getArea(
      GetAreaRequest event, Emitter<AreaState> emit) async {
    AreaController controller = AreaController();
    emit(GetAreaLoading());
    try {
      List<FoodModel> data = await controller.getArea();
      area = data;
      emit(GetAreaSuccess());
    } catch (ex) {
      emit(GetAreaError(errorMessage: ex.toString()));
    }
  }
}
