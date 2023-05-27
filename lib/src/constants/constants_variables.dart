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
String role = "All";
String package = "All";
String item = "All";
String dropItemsItem = '';
String? imageItems;
String imageDomain = "https://jetcare-api.ahmedshawky.fun/public/images/";
int areaId = 0;
int registerAreaId = 0;
List<String> crews = [];
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
