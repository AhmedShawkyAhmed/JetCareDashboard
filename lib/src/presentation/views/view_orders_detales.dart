import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_dropdown.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';
import '../../business_logic/orders_cubit/orders_cubit.dart';
import '../../data/models/orders_model.dart';
import '../styles/app_colors.dart';

class ViewOrdersDetails extends StatefulWidget {
  final OrdersModel orderModel;

  const ViewOrdersDetails({
    super.key,
    required this.orderModel,
  });

  @override
  State<ViewOrdersDetails> createState() => _ViewOrdersDetailsState();
}

class _ViewOrdersDetailsState extends State<ViewOrdersDetails> {
  TextEditingController priceController = TextEditingController();
  String crewName = "";

  @override
  void initState() {
    if (widget.orderModel.crew == null) {
      GlobalCubit.get(context).getCrews(
        areaId: widget.orderModel.address!.area!.id,
        periodId: widget.orderModel.period!.id!,
        date: widget.orderModel.date!,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
        padding: EdgeInsets.only(left: 1.w, top: 1.h),
        height: 90.h,
        width: 60.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
              color: AppColors.darkGrey.withOpacity(0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Orders Data #${widget.orderModel.id.toString()}',
                  style: TextStyle(fontSize: 5.sp),
                ),
              ],
            ),
            if (widget.orderModel.status != "canceled") ...[
              if (widget.orderModel.crew == null) ...[
                SizedBox(
                  height: 10.h,
                  width: 60.w,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 2.h, left: 2.5.w, right: 2.5.w, bottom: 1.h),
                    child: RowData(
                      rowHeight: 5.h,
                      data: [
                        Center(
                          child: SizedBox(
                            width: 50.w,
                            child:
                                BlocBuilder<GlobalCubit, GlobalState>(
                                  builder: (context, state) {
                                    if (GlobalCubit.get(context).crews.isEmpty) {
                                      return Center(
                                        child: SizedBox(
                                          width: 30.w,
                                          child: const DefaultText(
                                            text: "No Crew",
                                            align: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }
                                    return SizedBox(
                                      width: 50.w,
                                      height: 4.h,
                                      child: DefaultDropdown<User>(
                                        hint: "Crew",
                                        showSearchBox: true,
                                        itemAsString: (User? u) => "${u?.name ?? ""}  -  ${u?.phone ?? ""}",
                                        items: GlobalCubit.get(context).crews,
                                        onChanged: (val) {
                                          setState(() {
                                            OrdersCubit.get(context).assignOrder(
                                              id: widget.orderModel.id,
                                              crewId: val!.id!,
                                              date: widget.orderModel.date!,
                                              afterSuccess: () {
                                                Navigator.pop(context);
                                                userId.clear();
                                                areaId = 0;
                                              },
                                            );
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                SizedBox(
                  height: 10.h,
                  width: 60.w,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 2.h, left: 2.5.w, right: 2.5.w, bottom: 1.h),
                    child: RowData(
                      rowHeight: 5.h,
                      data: [
                        SizedBox(
                          width: 50.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const DefaultText(
                                text: "Crew Name:",
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              DefaultText(
                                text: widget.orderModel.crew == null
                                    ? "No Crew"
                                    : "${widget.orderModel.crew!.name}",
                                align: TextAlign.right,
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              const DefaultText(
                                text: "Crew Phone:",
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              DefaultText(
                                text: widget.orderModel.crew == null
                                    ? "No Crew"
                                    : "${widget.orderModel.crew!.phone}",
                                align: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
            SizedBox(
              height: 30.h,
              width: 60.w,
              child: BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 2.h, left: 2.5.w, right: 2.5.w, bottom: 1.h),
                    child: RowData(
                      rowHeight: 5.h,
                      data: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 0.5.w, vertical: 2.h),
                          width: 22.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const DefaultText(
                                    text: "Client Name",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text: "${widget.orderModel.user!.name}",
                                      align: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const DefaultText(
                                    text: "Client Phone",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text:
                                          "${widget.orderModel.address!.phone}",
                                      align: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const DefaultText(
                                    text: "Ordered At",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text: widget.orderModel.createdAt
                                          .toString()
                                          .substring(0, 10),
                                      align: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const DefaultText(
                                    text: "Date",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text: widget.orderModel.date.toString(),
                                      align: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const DefaultText(
                                    text: "Day",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text: DateFormat('EEEE').format(
                                          DateTime.parse(widget.orderModel.date
                                              .toString())),
                                      align: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 1.w, vertical: 2.h),
                          width: 22.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const DefaultText(
                                    text: "Period",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text:
                                          "${widget.orderModel.period!.from} - ${widget.orderModel.period!.to}",
                                      align: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const DefaultText(
                                    text: "Price",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text: "${widget.orderModel.price} EGP",
                                      align: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const DefaultText(
                                        text: "Extra",
                                      ),
                                      SizedBox(
                                        width: 0.5.w,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    AppColors.white,
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      const DefaultText(
                                                        text:
                                                            "Add Extra Price to The Order !!",
                                                        align: TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      DefaultTextField(
                                                        width: 20.w,
                                                        controller:
                                                            priceController,
                                                        hintText: "Extra Price",
                                                        height: 5.h,
                                                        password: false,
                                                        haveShadow: false,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actionsAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                actions: <Widget>[
                                                  DefaultAppButton(
                                                    title: "Send",
                                                    onTap: () {
                                                      OrdersCubit.get(context)
                                                          .updateExtras(
                                                        orderId: widget
                                                            .orderModel.id,
                                                        extra: double.parse(
                                                            priceController
                                                                        .text ==
                                                                    ""
                                                                ? "0"
                                                                : priceController
                                                                    .text),
                                                        afterSuccess: () {
                                                          setState(() {
                                                            widget.orderModel
                                                                    .extra =
                                                                double.parse(priceController
                                                                            .text ==
                                                                        ""
                                                                    ? "0"
                                                                    : priceController
                                                                        .text);
                                                            widget.orderModel
                                                                .total = widget
                                                                    .orderModel.price! +
                                                                widget
                                                                    .orderModel
                                                                    .shipping! +
                                                                widget
                                                                    .orderModel
                                                                    .extra!;
                                                          });
                                                          Navigator.pop(
                                                              context);
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
                                        child: Icon(
                                          Icons.edit,
                                          size: 3.sp,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text: "${widget.orderModel.extra} EGP",
                                      align: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const DefaultText(
                                    text: "Shipping",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text: "${widget.orderModel.shipping} EGP",
                                      align: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const DefaultText(
                                    text: "Total",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text: "${widget.orderModel.total} EGP",
                                      align: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10.h,
              width: 60.w,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 2.h, left: 2.5.w, right: 2.5.w, bottom: 1.h),
                child: RowData(
                  rowHeight: 5.h,
                  data: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const DefaultText(
                          text: "Address",
                        ),
                        SizedBox(
                          width: 47.w,
                          child: DefaultText(
                            text: "${widget.orderModel.address!.address} ,"
                                "${widget.orderModel.address!.area!.nameAr} ,"
                                "${widget.orderModel.address!.state!.nameAr}",
                            align: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
              width: 60.w,
              child: BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 2.h, left: 2.5.w, right: 2.5.w, bottom: 1.h),
                    child: RowData(
                      rowHeight: 5.h,
                      data: [
                        SizedBox(
                          height: 30.h,
                          width: 50.w,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: widget.orderModel.cart?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 10,
                                ),
                                child: RowData(
                                  rowHeight: 6.h,
                                  data: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Name',
                                            style: TextStyle(fontSize: 3.sp),
                                          ),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Text(
                                            widget.orderModel.cart?[index]
                                                        .package ==
                                                    null
                                                ? widget.orderModel.cart![index]
                                                        .item?.nameAr ??
                                                    ""
                                                : widget.orderModel.cart![index]
                                                        .package?.nameAr ??
                                                    "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 3.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Space / Count',
                                            style: TextStyle(fontSize: 3.sp),
                                          ),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Text(
                                            widget.orderModel.cart![index].count
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 3.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Price',
                                            style: TextStyle(fontSize: 3.sp),
                                          ),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Text(
                                            widget.orderModel.cart![index].price
                                                .toString(),
                                            style: TextStyle(fontSize: 3.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
