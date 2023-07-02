import 'package:jetboard/src/data/models/equipment_schedule_model.dart';

import '../../models/equipment_model.dart';

class EquipmentScheduleRequest {
  int? id;
  String? date;
  String? returned;
  String? createdAt;
  Crew? crew;
  EquipmentModel? equipment;

  EquipmentScheduleRequest({
    int? id,
    String? date,
    String? returned,
    String? createdAt,
    Crew? crew,
    EquipmentModel? equipment,
  });
}
