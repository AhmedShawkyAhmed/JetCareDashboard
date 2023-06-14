import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'equipment_state.dart';

class EquipmentCubit extends Cubit<EquipmentState> {
  EquipmentCubit() : super(EquipmentInitial());

  static EquipmentCubit get(context) => BlocProvider.of(context);
}
