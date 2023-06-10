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
        child: Container(
          height: 100.h,
          width: 23.w,
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.h, left: 1.w, top: 3.h),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: InkWell(
                          onTap: (() {
                            Navigator.pop(context);
                            cubit.isShadowE();
                          }),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: size.width == 600 ? 1.5.w : 1.h),
                            alignment: Alignment.center,
                            height: 4.h,
                            width: 2.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    AppColors.green,
                                    AppColors.lightgreen,
                                  ]),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Create Order',
                        style: TextStyle(fontSize: 6.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () {
                      selectDate(context);
                    },
                    child: DefaultTextField(
                      controller: dateController,
                      height: 4.h,
                      horizontalPadding: 50,
                      hintText: "Choose Date",
                      readOnly: false,
                      password: false,
                      haveShadow: false,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  DefaultDropdown<String>(
                    hint: "Client",
                    showSearchBox: true,
                    selectedItem: client,
                    items: GlobalCubit.get(context).clients,
                    onChanged: (val) {
                      setState(() {
                        client = val!;
                        clientId = GlobalCubit.get(context)
                            .clientsResponse!
                            .userModel![
                                GlobalCubit.get(context).clients.indexOf(val)]
                            .id;
                        phoneController.text = GlobalCubit.get(context)
                            .clientsResponse!
                            .userModel![
                                GlobalCubit.get(context).clients.indexOf(val)]
                            .phone;
                        AddressCubit.get(context).getMyAddresses(
                          userId: clientId,
                          afterSuccess: () {},
                        );
                        printLog(clientId.toString());
                      });
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  DefaultDropdown<String>(
                    hint: "Period",
                    showSearchBox: true,
                    selectedItem: period,
                    items: GlobalCubit.get(context).periods,
                    onChanged: (val) {
                      setState(() {
                        period = val!;
                        periodId = GlobalCubit.get(context)
                            .periodResponse!
                            .periodModel![
                                GlobalCubit.get(context).periods.indexOf(val)]
                            .id!;
                        printLog(periodId.toString());
                      });
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  DefaultDropdown<String>(
                    hint: "Order Type",
                    showSearchBox: true,
                    selectedItem: orderType != ""
                        ? orderType == "package"
                            ? "Package"
                            : "Item"
                        : null,
                    items: const ['Package', 'Item'],
                    onChanged: (val) {
                      setState(() {
                        total = 0;
                        if (val == 'Package') {
                          orderType = 'package';
                        } else if (val == 'Item') {
                          orderType = 'item';
                        }
                      });
                    },
                  ),
                  if (orderType == "package") ...[
                    SizedBox(
                      height: 2.h,
                    ),
                    DefaultDropdown<String>(
                      hint: "Package",
                      showSearchBox: true,
                      selectedItem: package,
                      items: GlobalCubit.get(context).packages,
                      onChanged: (val) {
                        setState(() {
                          package = val!;
                          packageId = GlobalCubit.get(context)
                              .packagesResponse!
                              .packagesModel![GlobalCubit.get(context)
                                  .packages
                                  .indexOf(val)]
                              .id;
                          packagePrice = GlobalCubit.get(context)
                              .packagesResponse!
                              .packagesModel![GlobalCubit.get(context)
                                  .packages
                                  .indexOf(val)]
                              .price;
                          total = packagePrice * count;
                          printLog(packageId.toString());
                        });
                      },
                    ),
                  ] else if (orderType == "item") ...[
                    SizedBox(
                      height: 2.h,
                    ),
                    DefaultDropdown<String>(
                      hint: "Items",
                      showSearchBox: true,
                      selectedItem: item,
                      items: GlobalCubit.get(context).items,
                      onChanged: (val) {
                        setState(() {
                          item = val!;
                          itemId = GlobalCubit.get(context)
                              .itemsResponse!
                              .itemsModel![
                                  GlobalCubit.get(context).items.indexOf(val)]
                              .id!;
                          itemPrice = GlobalCubit.get(context)
                              .itemsResponse!
                              .itemsModel![
                                  GlobalCubit.get(context).items.indexOf(val)]
                              .price!.toDouble();
                          total = itemPrice * count;
                          printLog(itemId.toString());
                        });
                      },
                    ),
                  ],
                  if (clientId != 0) ...[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 2.h,
                      ),
                      child: BlocBuilder<AddressCubit, AddressState>(
                        builder: (context, state) {
                          return AddressCubit.get(context).address.isEmpty
                              ? DefaultAppButton(
                                  height: 4.h,
                                  width: 300.w,
                                  haveShadow: false,
                                  horizontalPadding: 50,
                                  offset: const Offset(0, 0),
                                  buttonColor: AppColors.white,
                                  textColor: AppColors.pc,
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  radius: 10,
                                  isGradient: false,
                                  fontSize: 3.sp,
                                  title: "Add Address",
                                  onTap: () {
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: AppColors.white,
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                DefaultTextField(
                                                  width: 15.w,
                                                  height: 4.h,
                                                  hintText: "phone Number",
                                                  textColor:
                                                      AppColors.mainColor,
                                                  fontSize: 3.sp,
                                                  validator: "",
                                                  maxLine: 1,
                                                  controller: phoneController,
                                                  password: false,
                                                  haveShadow: false,
                                                  color: AppColors.white,
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                DefaultTextField(
                                                  width: 15.w,
                                                  height: 4.h,
                                                  hintText: "Floor Number",
                                                  textColor:
                                                      AppColors.mainColor,
                                                  fontSize: 3.sp,
                                                  validator: "",
                                                  maxLine: 1,
                                                  controller: floorController,
                                                  password: false,
                                                  haveShadow: false,
                                                  color: AppColors.white,
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                DefaultTextField(
                                                  width: 15.w,
                                                  height: 4.h,
                                                  hintText: "Building Name",
                                                  textColor:
                                                      AppColors.mainColor,
                                                  fontSize: 3.sp,
                                                  validator: "",
                                                  maxLine: 1,
                                                  controller:
                                                      buildingController,
                                                  password: false,
                                                  haveShadow: false,
                                                  color: AppColors.white,
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                DefaultTextField(
                                                  width: 15.w,
                                                  height: 4.h,
                                                  hintText: "Street Name",
                                                  textColor:
                                                      AppColors.mainColor,
                                                  fontSize: 3.sp,
                                                  validator: "",
                                                  maxLine: 1,
                                                  controller: streetController,
                                                  password: false,
                                                  haveShadow: false,
                                                  color: AppColors.white,
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                DefaultTextField(
                                                  width: 15.w,
                                                  height: 4.h,
                                                  hintText: "Area",
                                                  textColor:
                                                      AppColors.mainColor,
                                                  fontSize: 3.sp,
                                                  validator: "",
                                                  maxLine: 1,
                                                  controller: areaController,
                                                  password: false,
                                                  haveShadow: false,
                                                  color: AppColors.white,
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                DefaultTextField(
                                                  width: 15.w,
                                                  height: 4.h,
                                                  hintText: "District",
                                                  textColor:
                                                      AppColors.mainColor,
                                                  fontSize: 3.sp,
                                                  validator: "",
                                                  maxLine: 1,
                                                  controller:
                                                      districtController,
                                                  password: false,
                                                  haveShadow: false,
                                                  color: AppColors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                          actionsAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          actions: <Widget>[
                                            DefaultAppButton(
                                              title: "Save",
                                              onTap: () {
                                                if (phoneController.text ==
                                                    "") {
                                                  DefaultToast.showMyToast(
                                                      "Phone Number is Required");
                                                } else if (floorController
                                                        .text ==
                                                    "") {
                                                  DefaultToast.showMyToast(
                                                      "Floor Number is Required");
                                                } else if (buildingController
                                                        .text ==
                                                    "") {
                                                  DefaultToast.showMyToast(
                                                      "Building Name is Required");
                                                } else if (streetController
                                                        .text ==
                                                    "") {
                                                  DefaultToast.showMyToast(
                                                      "Street Name is Required");
                                                } else if (areaController
                                                        .text ==
                                                    "") {
                                                  DefaultToast.showMyToast(
                                                      "Area Name is Required");
                                                } else if (districtController
                                                        .text ==
                                                    "") {
                                                  DefaultToast.showMyToast(
                                                      "District Name is Required");
                                                } else {
                                                  // AddressCubit.get(context)
                                                  //     .addAddress(
                                                  //   addressRequest:
                                                  //       AddressRequest(
                                                  //     userId: clientId,
                                                  //     floor:
                                                  //         floorController.text,
                                                  //     phone:
                                                  //         phoneController.text,
                                                  //     building:
                                                  //         buildingController
                                                  //             .text,
                                                  //     street:
                                                  //         streetController.text,
                                                  //     area: areaController.text,
                                                  //     district:
                                                  //         districtController
                                                  //             .text,
                                                  //     latitude: "0.0",
                                                  //     longitude: "0.0",
                                                  //   ),
                                                  //   afterSuccess: () {
                                                  //     AddressCubit.get(context)
                                                  //         .getMyAddresses(
                                                  //       userId: clientId,
                                                  //       afterSuccess: () {
                                                  //         Navigator.pop(
                                                  //             context);
                                                  //       },
                                                  //     );
                                                  //   },
                                                  // );
                                                }
                                              },
                                              width: 10.w,
                                              height: 4.h,
                                              fontSize: 3.sp,
                                              textColor: AppColors.white,
                                              buttonColor: AppColors.pc,
                                              isGradient: false,
                                              radius: 10,
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            DefaultAppButton(
                                              title: "Cancel",
                                              onTap: () {
                                                phoneController.clear();
                                                floorController.clear();
                                                buildingController.clear();
                                                streetController.clear();
                                                areaController.clear();
                                                districtController.clear();
                                                Navigator.pop(context);
                                              },
                                              width: 10.w,
                                              height: 4.h,
                                              fontSize: 3.sp,
                                              textColor: AppColors.mainColor,
                                              buttonColor: AppColors.lightGrey,
                                              isGradient: false,
                                              radius: 10,
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                )
                              : DefaultDropdown<String>(
                                  hint: "Order Address",
                                  showSearchBox: true,
                                  selectedItem: address,
                                  items: AddressCubit.get(context).address,
                                  onChanged: (val) {
                                    setState(() {
                                      address = val!;
                                      addressId = AddressCubit.get(context)
                                          .addressResponse!
                                          .address![AddressCubit.get(context)
                                              .address
                                              .indexOf(val)]
                                          .id!;
                                      printLog(addressId.toString());
                                    });
                                  },
                                );
                        },
                      ),
                    ),
                  ]
                  else ...[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 2.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Select User to get Address',
                            style: TextStyle(
                              fontSize: 3.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(
                    height: 2.h,
                  ),
                  DefaultTextField(
                    validator: "",
                    controller: countController,
                    height: 4.h,
                    keyboardType: TextInputType.number,
                    horizontalPadding: 50,
                    hintText: "Space | Count",
                    password: false,
                    haveShadow: false,
                    onChange: (value) {
                      setState(() {
                        printLog(value);
                        count = double.parse(value == "" ? "1" : value);
                        if (orderType == "package") {
                          total = packagePrice * count;
                        } else {
                          total = itemPrice * count;
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total: $total',
                        style: TextStyle(fontSize: 4.sp),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 5.h),
                    child: Container(
                      alignment: Alignment.center,
                      child: DefaultAppButton(
                        title: 'Create',
                        radius: 10,
                        width: 8.w,
                        height: 5.h,
                        fontSize: 4.sp,
                        onTap: () {
                          if(dateController.text == ""){
                            DefaultToast.showMyToast("Date is Required");
                          }else if(clientId == 0){
                            DefaultToast.showMyToast("Client is Required");
                          }else if(addressId == 0){
                            DefaultToast.showMyToast("Address is Required");
                          }else if(periodId == 0){
                            DefaultToast.showMyToast("Period is Required");
                          }else if(countController.text == "" || count == 0){
                            DefaultToast.showMyToast("Space | Count is Required");
                          }else if(packageId == 0 && itemId == 0){
                            DefaultToast.showMyToast("Order is Required ( Package | Item )");
                          }else{
                            // OrdersCubit.get(context).createOrder(
                            //   orderRequest: OrderRequest(
                            //     userId: clientId,
                            //     total: total,
                            //     addressId: addressId,
                            //     date: dateController.text,
                            //     packageId: packageId,
                            //     itemId:itemId,
                            //     periodId: periodId,
                            //     extraIds: [],
                            //     comment: null,
                            //   ),
                            //   afterSuccess: () {
                            //     OrdersCubit.get(context).getOrders();
                            //     Navigator.pop(context);
                            //   },
                            // );
                          }
                        },
                        haveShadow: false,
                        gradientColors: const [
                          AppColors.green,
                          AppColors.lightgreen,
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
