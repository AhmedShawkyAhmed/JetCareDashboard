import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jetboard/src/business_logic/address_cubit/address_cubit.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/orders_cubit/orders_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/data/network/requests/address_request.dart';
import 'package:jetboard/src/data/network/requests/order_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_dropdown.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class EndDrawerOrder extends StatefulWidget {
  const EndDrawerOrder({
    super.key,
  });

  @override
  State<EndDrawerOrder> createState() => _EndDrawerOrderState();
}

class _EndDrawerOrderState extends State<EndDrawerOrder> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  final TextEditingController link = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String type = "";
  String address = "";
  int addressId = 0;
  String period = "";
  int periodId = 0;
  String client = "";
  int clientId = 0;
  String package = "";
  int packageId = 0;
  String item = "";
  int itemId = 0;
  double total = 0;
  double count = 1;
  double packagePrice = 0;
  double itemPrice = 0;
  String orderType = "";
  DateTime now = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime(now.year, now.month, now.day + 1),
      firstDate: DateTime(now.year, now.month, now.day + 1),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.teal,
              primaryColorDark: Colors.teal,
              accentColor: Colors.teal,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      dateController.text = DateFormat('yyyy-MM-dd', 'en_US').format(picked);
      printSuccess(dateController.text);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cubit = GlobalCubit.get(context);
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2.0,
        sigmaY: 2.0,
      ),
      child: SingleChildScrollView(
      ),
    );
  }
}
