import 'package:jetboard/src/data/models/area_model.dart';

List<int> lol = [
  0,
  1,
  0,
  1,
  0,
  1,
  0,
  1,
  0,
  1,
];
String dropItemsInfo = '';
String? imageApp;
AreaModel selectedState = AreaModel(id: 0, nameEn: "All", nameAr: "الكل", active: 1);
String role = "All";
String package = "All";
String item = "All";
String dropItemsItem = '';
String dropState = '';
String? imageItems;
String imageDomain = "https://jetcare-api.ahmedshawky.fun/public/images/";
int areaId = 0;
int registerAreaId = 0;
//List<String> crews = [];
List<int> userId = [];
int selectedMonth = DateTime.now().month - 1;
String year = (DateTime.now().year).toString();
String status = "";
List<String> orderStatus = ['accepted','confirmed','completed','unassigned','canceled'];
List<String> month = [
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
