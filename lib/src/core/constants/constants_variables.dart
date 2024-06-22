import 'package:jetboard/src/data/models/settings_model.dart';

String dropItemsInfo = '';
String? imageApp;
String role = "All";
String package = "All";
String item = "All";
String dropItemsItem = '';
String dropState = '';
String? imageItems;
int areaId = 0;
int registerAreaId = 0;
//List<String> crews = [];
List<int> userId = [];
int selectedMonth = DateTime.now().month - 1;
String year = (DateTime.now().year).toString();
String status = "";
List<String> orderStatus = [
  'accepted',
  'confirmed',
  'completed',
  'unassigned',
  'canceled'
];
SettingsModel? settingsModelGlobal;

List<String> yearList = [
  (DateTime.now().year - 4).toString(),
  (DateTime.now().year - 3).toString(),
  (DateTime.now().year - 2).toString(),
  (DateTime.now().year - 1).toString(),
  (DateTime.now().year).toString(),
  (DateTime.now().year + 1).toString(),
];
List<String> monthList = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];
