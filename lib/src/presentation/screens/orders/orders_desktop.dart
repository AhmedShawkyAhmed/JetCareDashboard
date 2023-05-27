import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/end_drawer_order.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/views/view_orders_detales.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_dropdown.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../../../business_logic/orders_cubit/orders_cubit.dart';
import '../../../constants/constants_variables.dart';
import '../../views/loading_view.dart';
import '../../widgets/default_text_field.dart';

class OrdersDesktop extends StatefulWidget {
  const OrdersDesktop({super.key});

  @override
  State<OrdersDesktop> createState() => _OrdersDesktopState();
}

class _OrdersDesktopState extends State<OrdersDesktop> {
  TextEditingController search = TextEditingController();
  String dropdownvalue = 'Item 1';

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  int currentIndex = 0;
  List<bool> isChecked = List.generate(2000, (index) => false);
  List<int> itemsId = [];
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubitO = OrdersCubit.get(context);
    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      key: scaffoldkey,
      endDrawer: const EndDrawerOrder(),
      backgroundColor: AppColors.green,
      body: Container(
        height: 100.h,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 5.h, left: 3.w, right: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextField(
                      password: false,
                      width: 25.w,
                      height: 5.h,
                      fontSize: 3.sp,
                      color: AppColors.white,
                      bottom: 0.5.h,
                      hintText: 'Order Number or Name',
                      spreadRadius: 2,
                      blurRadius: 2,
                      shadowColor: AppColors.black.withOpacity(0.05),
                      haveShadow: true,
                      controller: search,
                      onChange: (value){
                        if(value == ""){
                          cubitO.getOrders();
                        }
                      },
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          cubitO.getOrders(keyword: search.text);
                          printResponse(search.text);
                        },
                        color: AppColors.black,
                      ),
                    ),
                    const Spacer(),
                    // DefaultAppButton(
                    //   width: 8.w,
                    //   height: 5.h,
                    //   haveShadow: true,
                    //   offset: const Offset(0, 0),
                    //   spreadRadius: 2,
                    //   blurRadius: 2,
                    //   radius: 10,
                    //   gradientColors: const [
                    //     AppColors.green,
                    //     AppColors.lightgreen,
                    //   ],
                    //   fontSize: 5.sp,
                    //   title: "Create",
                    //   onTap: () {
                    //     scaffoldkey.currentState!.openEndDrawer();
                    //   },
                    // ),
                  ],
                ),
              ),
              BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  if (OrdersCubit.get(context).getOrdersResponse?.ordersModel ==
                      null) {
                    return Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: SizedBox(
                        height: 79.h,
                        child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                                top: 0.5.h, left: 3.2.w, right: 2.5),
                            child: LoadingView(
                              width: 90.w,
                              height: 5.h,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (OrdersCubit.get(context)
                      .getOrdersResponse!
                      .ordersModel!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Orders Found !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: SizedBox(
                      height: 90.h,
                      child: ListView.builder(
                        itemCount: cubitO.listCount,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                            top: 2.h,
                            left: 3.2.w,
                            right: 2.5.w,
                            bottom: 1.h,
                          ),
                          child: RowData(
                            rowHeight: 8.h,
                            data: [
                              SizedBox(
                                width: 8.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Number',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      cubitO.ordersList[index].id.toString(),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Client',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      cubitO.ordersList[index].user!.name
                                          .toString(),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ordered At',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      cubitO.ordersList[index].createdAt
                                          .toString()
                                          .substring(0, 10),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Date',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      cubitO.ordersList[index].date.toString(),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                child: SizedBox(
                                  width: 10.w,
                                  child: DefaultDropdown<String>(
                                    hint: "Status",
                                    showSearchBox: true,
                                    selectedItem: status == ""
                                        ? cubitO.ordersList[index].status
                                        : status,
                                    items: orderStatus,
                                    onChanged: (val) {
                                      setState(() {
                                        OrdersCubit.get(context).updateOrderStatus(
                                          orderId: cubitO.ordersList[index].id,
                                          status: val!,
                                          afterSuccess: () {
                                            setState(() {
                                              OrdersCubit.get(context)
                                                  .ordersList[index]
                                                  .status = val;
                                            });
                                            NotificationCubit.get(context).notifyUser(
                                              id: cubitO.ordersList[index].user!.id!,
                                              title: "الطلبات",
                                              message: "تم تغيير حالة طلبك رقم ${cubitO.ordersList[index].id} إلي $val",
                                              afterSuccess: () {
                                                NotificationCubit.get(context).saveNotification(
                                                  id: cubitO.ordersList[index].user!.id!,
                                                  title: "الطلبات",
                                                  message: "تم تغيير حالة طلبك رقم ${cubitO.ordersList[index].id} إلي $val",
                                                  afterSuccess: () {

                                                  },
                                                );
                                              },
                                            );
                                          },
                                        );
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Crew',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      cubitO.ordersList[index].status ==
                                              'canceled'
                                          ? "Order Canceled"
                                          : cubitO.ordersList[index].crew ==
                                                  null
                                              ? 'No Crew'
                                              : cubitO
                                                  .ordersList[index].crew!.name
                                                  .toString(),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                                child: CircleAvatar(
                                  backgroundColor: cubitO
                                                  .ordersList[index].status ==
                                              'rejected' ||
                                          cubitO.ordersList[index].status ==
                                              'canceled'
                                      ? AppColors.red
                                      : cubitO.ordersList[index].status ==
                                                  'accepted' ||
                                              cubitO.ordersList[index].status ==
                                                  'confirmed'
                                          ? AppColors.blue
                                          : cubitO.ordersList[index].status ==
                                                  'completed'
                                              ? AppColors.green
                                              : cubitO.ordersList[index]
                                                          .status ==
                                                      'assigned'
                                                  ? AppColors.orange
                                                  : AppColors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ViewOrdersDetails(
                                          orderModel: cubitO.ordersList[index],
                                        );
                                      });
                                },
                                icon: const Icon(Icons.remove_red_eye),
                                color: AppColors.grey,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (OrdersCubit.get(context)
                                            .ordersList[index]
                                            .adminComment !=
                                        null) {
                                      commentController.text =
                                          OrdersCubit.get(context)
                                              .ordersList[index]
                                              .adminComment!;
                                    }
                                  });
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: AppColors.white,
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              DefaultTextField(
                                                width: 50.w,
                                                height: 20.h,
                                                hintText: "Write your Comment",
                                                textColor: AppColors.mainColor,
                                                maxLength: 10000,
                                                fontSize: 4.sp,
                                                validator: "",
                                                maxLine: 5,
                                                controller: commentController,
                                                password: false,
                                                haveShadow: false,
                                                color: AppColors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        actions: <Widget>[
                                          DefaultAppButton(
                                            title: "Save",
                                            onTap: () {
                                              OrdersCubit.get(context)
                                                  .updateAdminComment(
                                                orderId:
                                                    cubitO.ordersList[index].id,
                                                comment: commentController.text,
                                                afterSuccess: () {
                                                  setState(() {
                                                    OrdersCubit.get(context)
                                                            .ordersList[index]
                                                            .adminComment =
                                                        commentController.text;
                                                  });
                                                  commentController.clear();
                                                  Navigator.pop(context);
                                                },
                                              );
                                            },
                                            width: 10.w,
                                            height: 4.h,
                                            fontSize: 3.sp,
                                            textColor: AppColors.white,
                                            buttonColor: AppColors.pc,
                                            isGradient: false,
                                            radius: 10,
                                          ),
                                          DefaultAppButton(
                                            title: "Cancel",
                                            onTap: () {
                                              commentController.clear();
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
                                icon: const Icon(Icons.comment),
                                color: AppColors.grey,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: AppColors.white,
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const <Widget>[
                                              DefaultText(
                                                  text:
                                                      "Are you Sure you want to Delete this Order !!")
                                            ],
                                          ),
                                        ),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        actions: <Widget>[
                                          DefaultAppButton(
                                            title: "Delete",
                                            onTap: () {
                                              Navigator.pop(context);
                                              OrdersCubit.get(context)
                                                  .deleteOrder(
                                                orderId:
                                                    cubitO.ordersList[index].id,
                                                afterSuccess: () {
                                                  setState(() {
                                                    OrdersCubit.get(context)
                                                        .ordersList
                                                        .removeAt(index);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              );
                                            },
                                            width: 10.w,
                                            height: 4.h,
                                            fontSize: 3.sp,
                                            textColor: AppColors.white,
                                            buttonColor: AppColors.darkRed,
                                            isGradient: false,
                                            radius: 10,
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
                                            buttonColor: AppColors.lightGrey,
                                            isGradient: false,
                                            radius: 10,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.delete),
                                color: AppColors.darkRed,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
