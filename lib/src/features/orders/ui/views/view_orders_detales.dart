import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/core/utils/enums.dart';
import 'package:jetboard/src/features/crew/cubit/crew_cubit.dart';
import 'package:jetboard/src/features/orders/cubit/orders_cubit.dart';
import 'package:jetboard/src/features/orders/data/models/order_model.dart';
import 'package:jetboard/src/features/orders/ui/views/order_extra_fees.dart';
import 'package:sizer/sizer.dart';

class ViewOrdersDetails extends StatefulWidget {
  final OrdersCubit cubit;
  final OrderModel orderModel;

  const ViewOrdersDetails({
    super.key,
    required this.cubit,
    required this.orderModel,
  });

  @override
  State<ViewOrdersDetails> createState() => _ViewOrdersDetailsState();
}

class _ViewOrdersDetailsState extends State<ViewOrdersDetails> {
  CrewCubit crewCubit = CrewCubit(instance());

  @override
  void initState() {
    if (widget.orderModel.crew == null) {
      crewCubit.getCrewOfAreas(
        areaId: widget.orderModel.address!.area!.id!,
        periodId: widget.orderModel.period!.id!,
        date: widget.orderModel.date!,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => crewCubit,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 3.h,
          ),
          padding: EdgeInsets.only(
            left: 1.w,
            top: 1.h,
            bottom: 2.h,
          ),
          height: 78.h,
          width: 90.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  NavigationService.pop();
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
              const Spacer(),
              Row(
                children: [
                  Column(
                    children: [
                      if (widget.orderModel.status != OrderStatus.canceled) ...[
                        if (widget.orderModel.crew == null) ...[
                          SizedBox(
                            height: 10.h,
                            width: 30.w,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 2.h,
                                left: 1.w,
                                right: 1.w,
                                bottom: 1.h,
                              ),
                              child: RowData(
                                rowHeight: 5.h,
                                data: [
                                  Center(
                                    child: SizedBox(
                                      width: 25.w,
                                      child: BlocBuilder<CrewCubit, CrewState>(
                                        builder: (context, state) {
                                          if (crewCubit.crewOfArea!.isEmpty) {
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
                                            width: 25.w,
                                            height: 4.h,
                                            child: DefaultDropdown<UserModel>(
                                              hint: "Crew",
                                              showSearchBox: true,
                                              itemAsString: (UserModel? u) =>
                                                  "${u?.name ?? ""}  -  ${u?.phone ?? ""}",
                                              items: crewCubit.crewOfArea!,
                                              onChanged: (val) {
                                                setState(() {
                                                  widget.cubit.assignOrder(
                                                    orderId:
                                                        widget.orderModel.id!,
                                                    crewId: val!.id!,
                                                    date:
                                                        widget.orderModel.date!,
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
                            width: 30.w,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 2.h,
                                left: 1.w,
                                right: 1.w,
                                bottom: 1.h,
                              ),
                              child: RowData(
                                rowHeight: 5.h,
                                data: [
                                  SizedBox(
                                    width: 25.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            const DefaultText(
                                              text: "Crew Name:",
                                            ),
                                            SizedBox(
                                              width: 0.5.w,
                                            ),
                                            DefaultText(
                                              text: widget.orderModel.crew ==
                                                      null
                                                  ? "No Crew"
                                                  : "${widget.orderModel.crew!.name}",
                                              align: TextAlign.right,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const DefaultText(
                                              text: "Crew Phone:",
                                            ),
                                            SizedBox(
                                              width: 0.5.w,
                                            ),
                                            DefaultText(
                                              text: widget.orderModel.crew ==
                                                      null
                                                  ? "No Crew"
                                                  : "${widget.orderModel.crew!.phone}",
                                              align: TextAlign.right,
                                            ),
                                          ],
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
                        height: 40.h,
                        width: 30.w,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 2.h,
                            left: 1.w,
                            right: 1.w,
                            bottom: 1.h,
                          ),
                          child: RowData(
                            rowHeight: 5.h,
                            data: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 2.h,
                                ),
                                width: 25.w,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                            text:
                                                "${widget.orderModel.user!.name}",
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
                                            text: widget.orderModel.date
                                                .toString(),
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
                                                DateTime.parse(widget
                                                    .orderModel.date
                                                    .toString())),
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
                                            text:
                                                "${widget.orderModel.price} EGP",
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
                                            OrderExtraFees(
                                              cubit: widget.cubit,
                                              orderModel: widget.orderModel,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                          child: DefaultText(
                                            text:
                                                "${widget.orderModel.extra} EGP",
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
                                          text: "Transportation",
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                          child: DefaultText(
                                            text:
                                                "${widget.orderModel.shipping} EGP",
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
                                            text:
                                                "${widget.orderModel.total} EGP",
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
                        ),
                      ),
                      SizedBox(
                        height: 13.h,
                        width: 30.w,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 2.h,
                            left: 1.w,
                            right: 1.w,
                            bottom: 1.h,
                          ),
                          child: RowData(
                            rowHeight: 6.h,
                            data: [
                              const DefaultText(
                                text: "Address",
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 20.w,
                                child: DefaultText(
                                  text:
                                      "${widget.orderModel.address!.address} ,"
                                      "${widget.orderModel.address!.area!.nameAr} ,"
                                      "${widget.orderModel.address!.state!.nameAr}",
                                  align: TextAlign.right,
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 63.h,
                        width: 48.w,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 2.h,
                            left: 1.w,
                            right: 1.w,
                            bottom: 1.h,
                          ),
                          child: RowData(
                            rowHeight: 5.h,
                            data: [
                              SizedBox(
                                height: 63.h,
                                width: 44.w,
                                child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  itemCount:
                                      widget.orderModel.cart?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 5,
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
                                                  style: TextStyle(
                                                    fontSize: 3.sp,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Text(
                                                  widget.orderModel.cart?[index]
                                                              .package ==
                                                          null
                                                      ? widget
                                                              .orderModel
                                                              .cart![index]
                                                              .item
                                                              ?.nameAr ??
                                                          ""
                                                      : widget
                                                              .orderModel
                                                              .cart![index]
                                                              .package
                                                              ?.nameAr ??
                                                          "",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 3.sp,
                                                  ),
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
                                                  style: TextStyle(
                                                    fontSize: 3.sp,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Text(
                                                  widget.orderModel.cart![index]
                                                      .count
                                                      .toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 3.sp,
                                                  ),
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
                                                  style: TextStyle(
                                                    fontSize: 3.sp,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Text(
                                                  widget.orderModel.cart![index]
                                                      .price
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 3.sp,
                                                  ),
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
                        ),
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
