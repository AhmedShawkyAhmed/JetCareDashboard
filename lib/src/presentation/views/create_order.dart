import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jetboard/src/business_logic/address_cubit/address_cubit.dart';
import 'package:jetboard/src/business_logic/area_cubit/area_cubit.dart';
import 'package:jetboard/src/business_logic/item_cubit/items_cubit.dart';
import 'package:jetboard/src/business_logic/orders_cubit/orders_cubit.dart';
import 'package:jetboard/src/business_logic/states_cubit/states_cubit.dart';
import 'package:jetboard/src/business_logic/clients_cubit/clients_cubit.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/data/models/area_model.dart';
import 'package:jetboard/src/data/models/cart_model.dart';
import 'package:jetboard/src/data/models/items_model.dart';
import 'package:jetboard/src/data/models/orders_model.dart';
import 'package:jetboard/src/data/network/requests/address_request.dart';
import 'package:jetboard/src/data/network/requests/order_request.dart';
import 'package:jetboard/src/data/network/requests/user_request.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/shared/views/indicator_view.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController spaceController = TextEditingController();
  TextEditingController shippingController = TextEditingController();
  TextEditingController dateController = TextEditingController();

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
              // primaryColorDark: Colors.teal,
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

  String period = "";
  int periodId = 0;
  String client = "";
  int clientId = 0;
  String address = "";
  int addressId = 0;
  bool newClient = true;
  int stateId = 0;
  int areaId = 0;
  int packageId = 0;
  num price = 0;
  num count = 0;
  double total = 0;
  double shipping = 0;
  List<CartModel> cart = [];
  List<int> cartItemsIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Center(
        child: Container(
          width: 70.w,
          height: 75.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              const DefaultText(
                text: "Create New Order",
                align: TextAlign.center,
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          DefaultAppButton(
                            width: 8.w,
                            height: 3.h,
                            haveShadow: true,
                            offset: const Offset(0, 0),
                            spreadRadius: 2,
                            blurRadius: 2,
                            radius: 5,
                            horizontalPadding: 0,
                            isGradient: !newClient,
                            gradientColors: const [
                              AppColors.green,
                              AppColors.lightGreen,
                            ],
                            fontSize: 3.sp,
                            title: "Current Client",
                            onTap: () {
                              setState(() {
                                newClient = false;
                                printLog(newClient.toString());
                              });
                            },
                          ),
                          SizedBox(width: 2.w),
                          DefaultAppButton(
                            width: 8.w,
                            height: 3.h,
                            haveShadow: true,
                            offset: const Offset(0, 0),
                            spreadRadius: 2,
                            blurRadius: 2,
                            radius: 5,
                            horizontalPadding: 0,
                            isGradient: newClient,
                            gradientColors: const [
                              AppColors.green,
                              AppColors.lightGreen,
                            ],
                            fontSize: 3.sp,
                            title: "New Client",
                            onTap: () {
                              setState(() {
                                newClient = true;
                                printLog(newClient.toString());
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      if (newClient) ...[
                        DefaultTextField(
                          password: false,
                          controller: nameController,
                          height: 5.h,
                          haveShadow: true,
                          spreadRadius: 2,
                          blurRadius: 2,
                          horizontalPadding: 50,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: 'Client Name',
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        DefaultTextField(
                          password: false,
                          height: 5.h,
                          controller: phoneController,
                          haveShadow: true,
                          spreadRadius: 2,
                          horizontalPadding: 50,
                          blurRadius: 2,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: 'Phone Number',
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        DefaultTextField(
                          password: false,
                          height: 5.h,
                          controller: emailController,
                          haveShadow: true,
                          horizontalPadding: 50,
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: 'Email',
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        DefaultTextField(
                          password: false,
                          height: 5.h,
                          controller: addressController,
                          haveShadow: true,
                          horizontalPadding: 50,
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: 'Address',
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            BlocBuilder<StatesCubit, StatesState>(
                              builder: (context, state) {
                                return StatesCubit.get(context)
                                            .allStatesResponse
                                            ?.statesList ==
                                        null
                                    ? SizedBox(
                                        height: 4.h,
                                        width: 12.w,
                                        child: Center(
                                          child: DefaultText(
                                              text: "No Governorate Found !",
                                              fontSize: 2.sp),
                                        ),
                                      )
                                    : SizedBox(
                                        width: 12.w,
                                        height: 4.h,
                                        child: DefaultDropdown<AreaModel>(
                                          hint: "Governorate",
                                          showSearchBox: true,
                                          itemAsString: (AreaModel? u) =>
                                              u?.nameAr ?? "",
                                          items: StatesCubit.get(context)
                                              .allStatesResponse!
                                              .statesList!,
                                          onChanged: (val) {
                                            setState(() {
                                              AreaCubit.get(context)
                                                  .getAllAreas(
                                                      stateId: val!.id == 0
                                                          ? 0
                                                          : val.id);
                                              stateId =
                                                  (val.id == 0 ? 0 : val.id)!;
                                            });
                                          },
                                        ),
                                      );
                              },
                            ),
                            SizedBox(
                              width: 4.h,
                            ),
                            BlocBuilder<AreaCubit, AreaState>(
                              builder: (context, state) {
                                if (AreaCubit.get(context).areaList.isEmpty ||
                                    stateId == 0) {
                                  return SizedBox(
                                    height: 4.h,
                                    width: 12.w,
                                    child: Center(
                                      child: DefaultText(
                                          text: "Select Governorate First",
                                          fontSize: 2.sp),
                                    ),
                                  );
                                }
                                return SizedBox(
                                  height: 4.h,
                                  width: 12.w,
                                  child: DefaultDropdown<AreaModel>(
                                    hint: "Areas",
                                    showSearchBox: true,
                                    itemAsString: (AreaModel? u) =>
                                        u?.nameAr ?? "",
                                    items: AreaCubit.get(context).areaList,
                                    onChanged: (val) {
                                      setState(() {
                                        areaId = (val!.id == 0 ? 0 : val.id)!;
                                        printSuccess(areaId.toString());
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ]
                      else ...[
                        SizedBox(
                          width: 26.w,
                          height: 4.h,
                          child: DefaultDropdown<String>(
                            hint: "Client",
                            showSearchBox: true,
                            selectedItem: client,
                            items: OrdersCubit.get(context).clients,
                            onChanged: (val) {
                              setState(() {
                                client = val!;
                                clientId = OrdersCubit.get(context)
                                    .clientsResponse!
                                    .userModel![OrdersCubit.get(context)
                                        .clients
                                        .indexOf(val)]
                                    .id;
                                phoneController.text = OrdersCubit.get(context)
                                    .clientsResponse!
                                    .userModel![OrdersCubit.get(context)
                                        .clients
                                        .indexOf(val)]
                                    .phone;
                                AddressCubit.get(context).getMyAddresses(
                                  userId: clientId,
                                  afterSuccess: () {},
                                );
                                printLog(clientId.toString());
                              });
                            },
                          ),
                        ),
                        if (clientId != 0) ...[
                          SizedBox(
                            width: 26.w,
                            height: 4.h,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 1.h,
                              ),
                              child: BlocBuilder<AddressCubit, AddressState>(
                                builder: (context, state) {
                                  return AddressCubit.get(context)
                                          .address
                                          .isEmpty
                                      ? DefaultAppButton(
                                          width: 26.w,
                                          height: 4.h,
                                          haveShadow: false,
                                          horizontalPadding: 0,
                                          offset: const Offset(0, 0),
                                          buttonColor: AppColors.primary,
                                          textColor: AppColors.white,
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          radius: 6,
                                          isGradient: false,
                                          fontSize: 3.sp,
                                          title: "Add Address",
                                          onTap: () {
                                            showDialog<void>(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor:
                                                      AppColors.white,
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        DefaultTextField(
                                                          password: false,
                                                          height: 5.h,
                                                          controller:
                                                              addressController,
                                                          haveShadow: true,
                                                          horizontalPadding: 50,
                                                          spreadRadius: 2,
                                                          blurRadius: 2,
                                                          color:
                                                              AppColors.white,
                                                          shadowColor: AppColors
                                                              .black
                                                              .withOpacity(
                                                                  0.05),
                                                          hintText: 'Address',
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            BlocBuilder<
                                                                StatesCubit,
                                                                StatesState>(
                                                              builder: (context,
                                                                  state) {
                                                                return StatesCubit.get(context)
                                                                            .allStatesResponse
                                                                            ?.statesList ==
                                                                        null
                                                                    ? SizedBox(
                                                                        height:
                                                                            4.h,
                                                                        width:
                                                                            10.w,
                                                                        child:
                                                                            Center(
                                                                          child: DefaultText(
                                                                              text: "No Governorate Found !",
                                                                              fontSize: 2.sp),
                                                                        ),
                                                                      )
                                                                    : SizedBox(
                                                                        width:
                                                                            10.w,
                                                                        height:
                                                                            4.h,
                                                                        child: DefaultDropdown<
                                                                            AreaModel>(
                                                                          hint:
                                                                              "Governorate",
                                                                          showSearchBox:
                                                                              true,
                                                                          itemAsString: (AreaModel? u) =>
                                                                              u?.nameAr ??
                                                                              "",
                                                                          items: StatesCubit.get(context)
                                                                              .allStatesResponse!
                                                                              .statesList!,
                                                                          onChanged:
                                                                              (val) {
                                                                            setState(() {
                                                                              AreaCubit.get(context).getAllAreas(stateId: val!.id == 0 ? 0 : val.id);
                                                                              stateId = (val.id == 0 ? 0 : val.id)!;
                                                                            });
                                                                          },
                                                                        ),
                                                                      );
                                                              },
                                                            ),
                                                            SizedBox(
                                                              width: 4.h,
                                                            ),
                                                            BlocBuilder<
                                                                AreaCubit,
                                                                AreaState>(
                                                              builder: (context,
                                                                  state) {
                                                                if (AreaCubit.get(
                                                                            context)
                                                                        .areaList
                                                                        .isEmpty ||
                                                                    stateId ==
                                                                        0) {
                                                                  return SizedBox(
                                                                    height: 4.h,
                                                                    width: 10.w,
                                                                    child:
                                                                        Center(
                                                                      child: DefaultText(
                                                                          text:
                                                                              "Select Governorate First",
                                                                          fontSize:
                                                                              2.sp),
                                                                    ),
                                                                  );
                                                                }
                                                                return SizedBox(
                                                                  height: 4.h,
                                                                  width: 10.w,
                                                                  child: DefaultDropdown<
                                                                      AreaModel>(
                                                                    hint:
                                                                        "Areas",
                                                                    showSearchBox:
                                                                        true,
                                                                    itemAsString:
                                                                        (AreaModel?
                                                                                u) =>
                                                                            u?.nameAr ??
                                                                            "",
                                                                    items: AreaCubit.get(
                                                                            context)
                                                                        .areaList,
                                                                    onChanged:
                                                                        (val) {
                                                                      setState(
                                                                          () {
                                                                        areaId = (val!.id ==
                                                                                0
                                                                            ? 0
                                                                            : val.id)!;
                                                                        printSuccess(
                                                                            areaId.toString());
                                                                      });
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actionsAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  actions: <Widget>[
                                                    DefaultAppButton(
                                                      title: "Save",
                                                      onTap: () {
                                                        if (addressController
                                                                .text ==
                                                            "") {
                                                          DefaultToast.showMyToast(
                                                              "Please Enter the Address");
                                                        } else if (stateId ==
                                                            0) {
                                                          DefaultToast.showMyToast(
                                                              "Please Select Governorate");
                                                        } else if (areaId ==
                                                            0) {
                                                          DefaultToast.showMyToast(
                                                              "Please Select Area");
                                                        } else {
                                                          AddressCubit.get(
                                                                  context)
                                                              .addAddress(
                                                            addressRequest:
                                                                AddressRequest(
                                                              userId: clientId,
                                                              phone:
                                                                  phoneController
                                                                      .text,
                                                              latitude: "0.0",
                                                              longitude: "0.0",
                                                              stateId: stateId,
                                                              areaId: areaId, address: addressController.text,
                                                            ),
                                                            afterSuccess: () {
                                                              AddressCubit.get(
                                                                      context)
                                                                  .getMyAddresses(
                                                                userId:
                                                                    clientId,
                                                                afterSuccess:
                                                                    () {
                                                                      addressController.clear();
                                                                      stateId = 0;
                                                                      areaId = 0;
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              );
                                                            },
                                                          );
                                                        }
                                                      },
                                                      width: 10.w,
                                                      height: 4.h,
                                                      fontSize: 3.sp,
                                                      textColor:
                                                          AppColors.white,
                                                      buttonColor: AppColors.primary,
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
                                                        addressController
                                                            .clear();
                                                        stateId = 0;
                                                        areaId = 0;
                                                        Navigator.pop(context);
                                                      },
                                                      width: 10.w,
                                                      height: 4.h,
                                                      fontSize: 3.sp,
                                                      textColor:
                                                          AppColors.mainColor,
                                                      buttonColor:
                                                          AppColors.lightGrey,
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
                                          items:
                                              AddressCubit.get(context).address,
                                          onChanged: (val) {
                                            setState(() {
                                              address = val!;
                                              addressId = AddressCubit.get(
                                                      context)
                                                  .addressResponse!
                                                  .address![
                                                      AddressCubit.get(context)
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
                          ),
                        ] else ...[
                          Padding(
                            padding: EdgeInsets.only(
                              top: 1.h,
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
                      ],
                      SizedBox(
                        height: 1.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          selectDate(context);
                        },
                        child: DefaultTextField(
                          controller: dateController,
                          height: 5.h,
                          haveShadow: true,
                          enabled: false,
                          spreadRadius: 2,
                          blurRadius: 2,
                          horizontalPadding: 50,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: "Choose Date",
                          password: false,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        width: 26.w,
                        height: 4.h,
                        child: DefaultDropdown<String>(
                          hint: "Period",
                          showSearchBox: true,
                          selectedItem: period,
                          items: OrdersCubit.get(context).periods,
                          onChanged: (val) {
                            setState(() {
                              period = val!;
                              periodId = OrdersCubit.get(context)
                                  .periodResponse!
                                  .periodModel![OrdersCubit.get(context)
                                      .periods
                                      .indexOf(val)]
                                  .id!;
                              printLog(periodId.toString());
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1.h, right: 50, left: 50),
                        child: SizedBox(
                          height: 14.h,
                          child: DefaultTextField(
                            password: false,
                            controller: messageController,
                            height: 20.h,
                            keyboardType: TextInputType.multiline,
                            fontSize: 3.sp,
                            haveShadow: true,
                            spreadRadius: 2,
                            blurRadius: 2,
                            maxLine: 7,
                            collapsed: true,
                            color: AppColors.white,
                            shadowColor: AppColors.black.withOpacity(0.05),
                            hintText: 'Comment',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          DefaultAppButton(
                            title: "Create",
                            onTap:newClient? () {
                              if (nameController.text == "") {
                                DefaultToast.showMyToast(
                                    "Please Enter Client Name");
                              } else if (phoneController.text == "") {
                                DefaultToast.showMyToast(
                                    "Please Enter Phone Number");
                              } else if (addressController.text == "") {
                                DefaultToast.showMyToast(
                                    "Please Enter the Address");
                              } else if (stateId == 0) {
                                DefaultToast.showMyToast(
                                    "Please Select Governorate");
                              } else if (areaId == 0) {
                                DefaultToast.showMyToast("Please Select Area");
                              } else if (shippingController.text == "") {
                                DefaultToast.showMyToast(
                                    "Please Enter the Shipping Cost");
                              } else if (dateController.text == "") {
                                DefaultToast.showMyToast("Please Select Date");
                              } else if (periodId == 0) {
                                DefaultToast.showMyToast(
                                    "Please Select Period");
                              } else if (cartItemsIds.isEmpty) {
                                DefaultToast.showMyToast("Please Select Items");
                              } else {
                                IndicatorView.showIndicator();
                                ClientsCubit.get(context).addClient(
                                  userRequest: UserRequset(
                                    phone: phoneController.text,
                                    email: emailController.text == ""
                                        ? "empty"
                                        : emailController.text,
                                    password: "12345678",
                                    role: "client",
                                    name: nameController.text,
                                  ),
                                  onError: (){
                                    Navigator.pop(context);
                                  },
                                  afterSuccess: () {
                                    AddressCubit.get(context).addAddress(
                                      addressRequest: AddressRequest(
                                        userId: ClientsCubit.get(context)
                                            .addUserResponse!
                                            .userModell!
                                            .id,
                                        stateId: stateId,
                                        areaId: areaId,
                                        address: addressController.text,
                                        phone: phoneController.text,
                                        latitude: "0",
                                        longitude: "0",
                                      ),
                                      afterSuccess: () {
                                        for (int c = 0;
                                            c < cartItemsIds.length;
                                            c++) {
                                          OrdersCubit.get(context).addToCart(
                                            userId: ClientsCubit.get(context)
                                                .addUserResponse!
                                                .userModell!
                                                .id,
                                            count: cart[c].count.toInt(),
                                            price: cart[c].price.toDouble(),
                                            itemId: cart[c].id,
                                            afterSuccess: () {
                                              cart.removeAt(0);
                                              if (cart.isEmpty) {
                                                OrdersCubit.get(context)
                                                    .createOrder(
                                                  orderRequest: OrderRequest(
                                                    userId:
                                                    ClientsCubit.get(context)
                                                            .addUserResponse!
                                                            .userModell!
                                                            .id,
                                                    total: (total + shipping)
                                                        .toString(),
                                                    price: total.toString(),
                                                    comment:
                                                        messageController.text,
                                                    shipping:
                                                        shipping.toString(),
                                                    addressId: AddressCubit.get(
                                                            context)
                                                        .addAddressResponse!
                                                        .addressModel!
                                                        .id!,
                                                    periodId: periodId,
                                                    date: dateController.text,
                                                  ),
                                                  afterSuccess: () {
                                                    OrdersCubit.get(context)
                                                        .getOrders();
                                                    nameController.clear();
                                                    emailController.clear();
                                                    phoneController.clear();
                                                    messageController.clear();
                                                    addressController.clear();
                                                    shippingController.clear();
                                                    stateId = 0;
                                                    areaId = 0;
                                                    periodId = 0;
                                                    period = "";
                                                    client = "";
                                                    clientId = 0;
                                                    address = "";
                                                    addressId = 0;
                                                    cartItemsIds.clear();
                                                    cart.clear();
                                                    price = 0;
                                                    count = 0;
                                                    total = 0;
                                                    shipping = 0;
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              }
                                            },
                                          );
                                        }
                                      },
                                    );
                                  },
                                );
                              }
                            }:(){
                              if (clientId == 0) {
                                DefaultToast.showMyToast(
                                    "Please Select Client");
                              } else if (addressId == 0) {
                                DefaultToast.showMyToast(
                                    "Please Select Address");
                              } else if (shippingController.text == "") {
                                DefaultToast.showMyToast(
                                    "Please Enter the Shipping Cost");
                              } else if (dateController.text == "") {
                                DefaultToast.showMyToast("Please Select Date");
                              } else if (periodId == 0) {
                                DefaultToast.showMyToast(
                                    "Please Select Period");
                              } else if (cartItemsIds.isEmpty) {
                                DefaultToast.showMyToast("Please Select Items");
                              }else{

                                IndicatorView.showIndicator();
                                for (int c = 0;
                                c < cartItemsIds.length;
                                c++) {
                                  OrdersCubit.get(context).addToCart(
                                    userId: clientId,
                                    count: cart[c].count.toInt(),
                                    price: cart[c].price.toDouble(),
                                    itemId: cart[c].id,
                                    afterSuccess: () {
                                      cart.removeAt(0);
                                      if (cart.isEmpty) {
                                        OrdersCubit.get(context)
                                            .createOrder(
                                          orderRequest: OrderRequest(
                                            userId:clientId,
                                            total: (total + shipping)
                                                .toString(),
                                            price: total.toString(),
                                            comment:
                                            messageController.text,
                                            shipping:
                                            shipping.toString(),
                                            addressId: addressId,
                                            periodId: periodId,
                                            date: dateController.text,
                                          ),
                                          afterSuccess: () {
                                            OrdersCubit.get(context)
                                                .getOrders();
                                            nameController.clear();
                                            emailController.clear();
                                            phoneController.clear();
                                            messageController.clear();
                                            addressController.clear();
                                            shippingController.clear();
                                            stateId = 0;
                                            areaId = 0;
                                            periodId = 0;
                                            period = "";
                                            client = "";
                                            clientId = 0;
                                            address = "";
                                            addressId = 0;
                                            cartItemsIds.clear();
                                            cart.clear();
                                            price = 0;
                                            count = 0;
                                            total = 0;
                                            shipping = 0;
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                        );
                                      }
                                    },
                                  );
                                }
                              }
                            },
                            width: 10.w,
                            height: 4.h,
                            fontSize: 3.sp,
                            textColor: AppColors.white,
                            buttonColor: AppColors.primary,
                            isGradient: false,
                            radius: 10,
                          ),
                          SizedBox(width: 2.w),
                          DefaultAppButton(
                            title: "Cancel",
                            onTap: () {
                              nameController.clear();
                              emailController.clear();
                              phoneController.clear();
                              messageController.clear();
                              addressController.clear();
                              shippingController.clear();
                              stateId = 0;
                              areaId = 0;
                              periodId = 0;
                               period = "";
                               client = "";
                               clientId = 0;
                               address = "";
                               addressId = 0;
                              cartItemsIds.clear();
                              cart.clear();
                              price = 0;
                              count = 0;
                              total = 0;
                              shipping = 0;
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
                      )
                    ],
                  ),
                  Column(
                    children: [
                      BlocBuilder<ItemsCubit, ItemsState>(
                        builder: (context, state) {
                          return ItemsCubit.get(context)
                                      .itemsResponse
                                      ?.itemsModel ==
                                  null
                              ? SizedBox(
                                  height: 4.h,
                                  width: 30.w,
                                  child: Center(
                                    child: DefaultText(
                                        text: "No Items Found !",
                                        fontSize: 2.sp),
                                  ),
                                )
                              : SizedBox(
                                  width: 30.w,
                                  height: 4.h,
                                  child: DefaultDropdown<ItemsModel>(
                                    hint: "Items",
                                    showSearchBox: true,
                                    itemAsString: (ItemsModel? u) =>
                                        ("${u?.price} EGP - ${u?.nameAr} "),
                                    items: ItemsCubit.get(context)
                                        .itemsResponse!
                                        .itemsModel!,
                                    onChanged: (val) {
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: AppColors.white,
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  const DefaultText(
                                                    text:
                                                        "Enter Space or Count !!",
                                                    align: TextAlign.center,
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  DefaultTextField(
                                                    controller: spaceController,
                                                    hintText: "Space or Count ",
                                                    height: 5.h,
                                                    password: false,
                                                    haveShadow: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actionsAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            actions: <Widget>[
                                              DefaultAppButton(
                                                title: "Add",
                                                onTap: () {
                                                  setState(() {
                                                    count = int.parse(
                                                        spaceController.text);
                                                    total = total +
                                                        double.parse((count *
                                                                val!.price!)
                                                            .toString());
                                                    cartItemsIds.add(val.id!);
                                                    cart.add(
                                                      CartModel(
                                                        id: val.id!,
                                                        userId: 1,
                                                        count: count,
                                                        status: "cart",
                                                        price: val.price!,
                                                        item: Package(
                                                          nameAr: val.nameAr,
                                                        ),
                                                      ),
                                                    );
                                                  });
                                                  spaceController.clear();
                                                  Navigator.pop(context);
                                                },
                                                width: 10.w,
                                                height: 4.h,
                                                fontSize: 3.sp,
                                                textColor: AppColors.white,
                                                buttonColor: AppColors.primary,
                                                isGradient: false,
                                                radius: 10,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              DefaultAppButton(
                                                title: "Cancel",
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                width: 10.w,
                                                height: 4.h,
                                                fontSize: 3.sp,
                                                textColor: AppColors.mainColor,
                                                buttonColor:
                                                    AppColors.lightGrey,
                                                isGradient: false,
                                                radius: 10,
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                );
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      // BlocBuilder<PackagesCubit, PackagesState>(
                      //   builder: (context, state) {
                      //     return PackagesCubit.get(context)
                      //                     .getPackagesResponse
                      //                     ?.packagesModel ==
                      //                 null ||
                      //             PackagesCubit.get(context)
                      //                 .getPackagesResponse!
                      //                 .packagesModel!
                      //                 .isEmpty
                      //         ? SizedBox(
                      //             height: 4.h,
                      //             width: 30.w,
                      //             child: Center(
                      //               child: DefaultText(
                      //                   text: "No Package Found !",
                      //                   fontSize: 2.sp),
                      //             ),
                      //           )
                      //         : SizedBox(
                      //             width: 30.w,
                      //             height: 4.h,
                      //             child: DefaultDropdown<PackagesModel>(
                      //               hint: "Items",
                      //               showSearchBox: true,
                      //               itemAsString: (PackagesModel? u) =>
                      //                   u?.nameAr ?? "",
                      //               items: PackagesCubit.get(context)
                      //                   .getPackagesResponse!
                      //                   .packagesModel!,
                      //               onChanged: (val) {
                      //                 setState(() {
                      //                   packageId = (val!.id == 0 ? 0 : val.id);
                      //                   cart.add(
                      //                     CartModel(
                      //                       id: val.id,
                      //                       userId: 1,
                      //                       count: 1,
                      //                       status: "cart",
                      //                       price: val.price,
                      //                       package: Package(
                      //                         nameAr: val.nameAr,
                      //                       ),
                      //                     ),
                      //                   );
                      //                 });
                      //               },
                      //             ),
                      //           );
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 1.h,
                      // ),
                      Container(
                        height: 35.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.mainColor.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(10)),
                        child: cart.isEmpty
                            ? Center(
                                child: DefaultText(
                                    text: "Cart is Empty !", fontSize: 3.sp),
                              )
                            : ListView.builder(
                                itemCount: cart.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                    top: 1.h,
                                    left: 0.5.w,
                                    right: 0.5.w,
                                    bottom: 1.h,
                                  ),
                                  child: RowData(
                                    rowHeight: 5.h,
                                    data: [
                                      SizedBox(
                                        width: 15.w,
                                        child: Text(
                                          cart[index].item == null
                                              ? cart[index].package!.nameAr!
                                              : cart[index].item!.nameAr!,
                                          style: TextStyle(fontSize: 2.sp),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                        child: Text(
                                          '${cart[index].price} * ${cart[index].count} = ${cart[index].count * cart[index].price} EGP',
                                          style: TextStyle(fontSize: 2.sp),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            cart.removeAt(index);
                                          });
                                        },
                                        icon: const Icon(Icons.delete),
                                        color: AppColors.darkRed,
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      DefaultTextField(
                        password: false,
                        controller: shippingController,
                        height: 5.h,
                        haveShadow: true,
                        spreadRadius: 2,
                        blurRadius: 2,
                        horizontalPadding: 1,
                        width: 30.w,
                        color: AppColors.white,
                        shadowColor: AppColors.black.withOpacity(0.05),
                        hintText: 'Shipping Cost',
                        onChange: (value) {
                          setState(() {
                            shipping = double.parse(
                                shippingController.text == ""
                                    ? "0"
                                    : shippingController.text);
                          });
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                            child: DefaultText(
                                text: "Price :",
                                align: TextAlign.left,
                                fontSize: 3.sp),
                          ),
                          SizedBox(
                            width: 10.w,
                            child: DefaultText(
                                text: "$total EGP",
                                align: TextAlign.right,
                                fontSize: 3.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                            child: DefaultText(
                                text: "Shipping :",
                                align: TextAlign.left,
                                fontSize: 3.sp),
                          ),
                          SizedBox(
                            width: 10.w,
                            child: DefaultText(
                                text: "$shipping EGP",
                                align: TextAlign.right,
                                fontSize: 3.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                            child: DefaultText(
                                text: "Total :",
                                align: TextAlign.left,
                                fontSize: 3.sp),
                          ),
                          SizedBox(
                            width: 10.w,
                            child: DefaultText(
                                text: "${total + shipping} EGP",
                                align: TextAlign.right,
                                fontSize: 3.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
