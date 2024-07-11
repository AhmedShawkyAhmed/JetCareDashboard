import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/core/shared/requests/register_request.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/areas/cubit/areas_cubit.dart';
import 'package:jetboard/src/features/areas/data/models/area_model.dart';
import 'package:jetboard/src/features/clients/cubit/clients_cubit.dart';
import 'package:jetboard/src/features/clients/data/models/address_model.dart';
import 'package:jetboard/src/features/clients/data/requests/address_request.dart';
import 'package:jetboard/src/features/items/cubit/items_cubit.dart';
import 'package:jetboard/src/features/items/data/models/item_model.dart';
import 'package:jetboard/src/features/orders/cubit/orders_cubit.dart';
import 'package:jetboard/src/features/orders/data/models/cart_item_model.dart';
import 'package:jetboard/src/features/orders/data/requests/cart_request.dart';
import 'package:jetboard/src/features/orders/data/requests/order_request.dart';
import 'package:jetboard/src/features/orders/ui/views/add_address_view.dart';
import 'package:jetboard/src/features/orders/ui/views/add_item_to_order_view.dart';
import 'package:jetboard/src/features/packages/cubit/packages_cubit.dart';
import 'package:jetboard/src/features/packages/data/models/package_model.dart';
import 'package:jetboard/src/features/periods/cubit/period_cubit.dart';
import 'package:jetboard/src/features/periods/data/models/period_model.dart';
import 'package:jetboard/src/features/states/data/models/state_model.dart';
import 'package:sizer/sizer.dart';

class CreateOrderView extends StatefulWidget {
  final OrdersCubit ordersCubit;
  final ClientsCubit clientsCubit;
  final AreasCubit areasCubit;
  final PeriodCubit periodCubit;
  final ItemsCubit itemsCubit;
  final PackagesCubit packagesCubit;

  const CreateOrderView({
    required this.ordersCubit,
    required this.clientsCubit,
    required this.areasCubit,
    required this.periodCubit,
    required this.itemsCubit,
    required this.packagesCubit,
    super.key,
  });

  @override
  State<CreateOrderView> createState() => _CreateOrderViewState();
}

class _CreateOrderViewState extends State<CreateOrderView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController shippingController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime now = DateTime.now();

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: NavigationService.context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime(now.year, now.month, now.day + 1),
      firstDate: DateTime(now.year, now.month, now.day + 1),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.teal,
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

  PeriodModel? period;
  UserModel? client;
  AddressModel? address;
  bool newClient = true;
  int stateId = 0;
  int areaId = 0;
  int packageId = 0;
  num price = 0;
  num count = 0;
  double total = 0;
  double shipping = 0;
  List<CartItemModel> cart = [];
  List<int> cartItemsIds = [];

  @override
  void dispose() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    messageController.clear();
    addressController.clear();
    shippingController.clear();
    stateId = 0;
    areaId = 0;
    period = null;
    client = null;
    address = null;
    cartItemsIds.clear();
    cart.clear();
    price = 0;
    count = 0;
    total = 0;
    shipping = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  BlocBuilder<AreasCubit, AreasState>(
                    builder: (context, state) {
                      return widget.areasCubit.states == null
                          ? SizedBox(
                              height: 4.h,
                              width: 12.w,
                              child: Center(
                                child: DefaultText(
                                  text: "No Governorate Found !",
                                  fontSize: 2.sp,
                                ),
                              ),
                            )
                          : SizedBox(
                              width: 12.w,
                              height: 4.h,
                              child: DefaultDropdown<StateModel>(
                                hint: "Governorate",
                                showSearchBox: true,
                                itemAsString: (StateModel? u) =>
                                    u?.nameAr ?? "",
                                items: widget.areasCubit.states!,
                                onChanged: (val) {
                                  setState(() {
                                    widget.areasCubit.getAreasOfState(
                                        stateId: val!.id == 0 ? 0 : val.id!);
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
                  BlocBuilder<AreasCubit, AreasState>(
                    builder: (context, state) {
                      if (widget.areasCubit.areasOfStates!.isEmpty ||
                          stateId == 0) {
                        return SizedBox(
                          height: 4.h,
                          width: 12.w,
                          child: Center(
                            child: DefaultText(
                              text: "Select Governorate First",
                              fontSize: 2.sp,
                            ),
                          ),
                        );
                      }
                      return SizedBox(
                        height: 4.h,
                        width: 12.w,
                        child: DefaultDropdown<AreaModel>(
                          hint: "Areas",
                          showSearchBox: true,
                          itemAsString: (AreaModel? u) => u?.nameAr ?? "",
                          items: widget.areasCubit.areasOfStates!,
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
            ] else ...[
              BlocBuilder<ClientsCubit, ClientsState>(
                  builder: (context, state) {
                return SizedBox(
                  width: 26.w,
                  height: 4.h,
                  child: DefaultDropdown<UserModel>(
                    hint: "Client",
                    showSearchBox: true,
                    selectedItem: client,
                    itemAsString: (UserModel? u) => u?.name ?? "",
                    items: widget.clientsCubit.clients!,
                    onChanged: (val) {
                      setState(() {
                        client = val!;
                        phoneController.text = client?.phone ?? "";
                        widget.clientsCubit.getMyAddresses(
                          clientId: client!.id!,
                        );
                      });
                    },
                  ),
                );
              }),
              if (client!.id != 0) ...[
                SizedBox(
                  width: 26.w,
                  height: 4.h,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 1.h,
                    ),
                    child: BlocBuilder<ClientsCubit, ClientsState>(
                      builder: (context, state) {
                        return widget.clientsCubit.address.isEmpty
                            ? AddAddressView(
                                client: client!,
                                areasCubit: widget.areasCubit,
                                clientsCubit: widget.clientsCubit,
                                ordersCubit: widget.ordersCubit,
                              )
                            : DefaultDropdown<AddressModel>(
                                hint: "Order Address",
                                showSearchBox: true,
                                selectedItem: address,
                                itemAsString: (AddressModel? u) =>
                                    u?.address ?? "",
                                items: widget.clientsCubit.address,
                                onChanged: (val) {
                                  setState(() {
                                    address = val!;
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
                selectDate();
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
            BlocBuilder<PeriodCubit, PeriodState>(
              builder: (context, state) {
                return SizedBox(
                  width: 26.w,
                  height: 4.h,
                  child: DefaultDropdown<PeriodModel>(
                    hint: "Period",
                    showSearchBox: true,
                    selectedItem: period,
                    itemAsString: (PeriodModel? u) => "${u?.from} - ${u?.to}",
                    items: widget.periodCubit.periods ?? [],
                    onChanged: (val) {
                      setState(() {
                        period = val!;
                        printLog(period?.id.toString());
                      });
                    },
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 1.h,
                right: 50,
                left: 50,
              ),
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
                  onTap: () {
                    widget.clientsCubit.addClientForOrder(
                      ordersCubit: widget.ordersCubit,
                      isNewClient: newClient,
                      request: RegisterRequest(
                        phone: phoneController.text,
                        email: emailController.text == ""
                            ? "empty"
                            : emailController.text,
                        password: "12345678",
                        role: "client",
                        name: nameController.text,
                      ),
                      addressRequest: AddressRequest(
                        userId: 0,
                        stateId: stateId,
                        areaId: areaId,
                        address: addressController.text,
                        phone: phoneController.text,
                        latitude: "0",
                        longitude: "0",
                      ),
                      cartRequest: CartRequest(
                        userId: client!.id!,
                        cart: cart,
                      ),
                      orderRequest: OrderRequest(
                        userId: client!.id!,
                        total: (total + shipping).toString(),
                        price: total.toString(),
                        comment: messageController.text,
                        shipping: shipping,
                        addressId: address!.id!,
                        periodId: period!.id!,
                        date: dateController.text,
                        cart: cartItemsIds,
                      ),
                    );
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
                    NavigationService.pop();
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
            ),
          ],
        ),
        Column(
          children: [
            BlocBuilder<ItemsCubit, ItemsState>(
              builder: (context, state) {
                return widget.itemsCubit.items == null
                    ? SizedBox(
                        height: 4.h,
                        width: 30.w,
                        child: Center(
                          child: DefaultText(
                            text: "No Items Found !",
                            fontSize: 2.sp,
                          ),
                        ),
                      )
                    : AddItemToOrderView(
                        itemsCubit: widget.itemsCubit,
                        onSave: (item, space) {
                          setState(() {
                            count = space;
                            total = total +
                                double.parse((count * item.price!).toString());
                            cartItemsIds.add(item.id!);
                            cart.add(
                              CartItemModel(
                                id: item.id!,
                                userId: 1,
                                count: count,
                                status: "cart",
                                price: item.price!,
                                item: ItemModel(
                                  nameAr: item.nameAr,
                                ),
                              ),
                            );
                          });
                        },
                      );
              },
            ),
            SizedBox(
              height: 2.h,
            ),
            BlocBuilder<PackagesCubit, PackagesState>(
              builder: (context, state) {
                return widget.packagesCubit.packages == null ||
                        widget.packagesCubit.packages!.isEmpty
                    ? SizedBox(
                        height: 4.h,
                        width: 30.w,
                        child: Center(
                          child: DefaultText(
                            text: "No Package Found !",
                            fontSize: 2.sp,
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 30.w,
                        height: 4.h,
                        child: DefaultDropdown<PackageModel>(
                          hint: "Items",
                          showSearchBox: true,
                          itemAsString: (PackageModel? u) => u?.nameAr ?? "",
                          items: widget.packagesCubit.packages!,
                          onChanged: (val) {
                            setState(() {
                              packageId = (val!.id == 0 ? 0 : val.id!);
                              cart.add(
                                CartItemModel(
                                  id: val.id,
                                  userId: 1,
                                  count: 1,
                                  status: "cart",
                                  price: val.price!,
                                  package: PackageModel(
                                    nameAr: val.nameAr,
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      );
              },
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              height: 35.h,
              width: 30.w,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.mainColor.withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: cart.isEmpty
                  ? Center(
                      child: DefaultText(
                        text: "Cart is Empty !",
                        fontSize: 3.sp,
                      ),
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
                  shipping = double.parse(shippingController.text == ""
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
                    fontSize: 3.sp,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                  child: DefaultText(
                    text: "$total EGP",
                    align: TextAlign.right,
                    fontSize: 3.sp,
                  ),
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
                    fontSize: 3.sp,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                  child: DefaultText(
                    text: "$shipping EGP",
                    align: TextAlign.right,
                    fontSize: 3.sp,
                  ),
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
                    fontSize: 3.sp,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                  child: DefaultText(
                    text: "${total + shipping} EGP",
                    align: TextAlign.right,
                    fontSize: 3.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
