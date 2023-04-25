import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jetboard/src/business_logic/area_cubit/area_cubit.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_drop_down_menu.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
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
  String crewName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        padding: EdgeInsets.only(left: 1.w, top: 1.h),
        height: 50.h,
        width: 60.w,
        child: Column(
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
                  'Orders Data',
                  style: TextStyle(fontSize: 5.sp),
                ),
              ],
            ),
            SizedBox(
              height: 35.h,
              width: 60.w,
              child: BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 2.h, left: 3.2.w, right: 2.5.w, bottom: 1.h),
                    child: RowData(
                      rowHeight: 5.h,
                      data: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 1.w, vertical: 2.h),
                          width: 20.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const DefaultText(
                                    text: "Order Name",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text: widget.orderModel.package == null
                                          ? "${widget.orderModel.item!.nameAr}"
                                          : "${widget.orderModel.package!.nameAr}",
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
                                    text: "Order Number",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text: widget.orderModel.id.toString(),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const DefaultText(
                                    text: "Space",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text: widget.orderModel.space == null
                                          ? "No Space"
                                          : "${widget.orderModel.space!.from} - ${widget.orderModel.space!.to} M²",
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
                                    text: "Address",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text:
                                          "${widget.orderModel.address!.floor},"
                                          " ${widget.orderModel.address!.building},"
                                          " ${widget.orderModel.address!.street},"
                                          " ${widget.orderModel.address!.area},"
                                          " ${widget.orderModel.address!.district}",
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
                              horizontal: 3.w, vertical: 2.h),
                          width: 20.w,
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
                                    text: "Total",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text: "${widget.orderModel.total}",
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
                                    text: "Crew Name",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text: widget.orderModel.crew == null
                                          ? "No Crew"
                                          : "${widget.orderModel.crew!.name}",
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
                                    text: "Crew Phone",
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                    child: DefaultText(
                                      text: widget.orderModel.crew == null
                                          ? "No Crew"
                                          : "${widget.orderModel.crew!.phone}",
                                      align: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              if(widget.orderModel.status != "canceled")...[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    BlocBuilder<AreaCubit, AreaState>(
                                      builder: (context, state) {
                                        if (AreaCubit.get(context).areasCount ==
                                            0) {
                                          return const DefaultText(
                                            text: "No Areas",
                                            align: TextAlign.right,
                                          );
                                        }
                                        return SizedBox(
                                          width: 7.w,
                                          child: DefaultDropDownMenu(
                                            height: 4.h,
                                            hint: "Areas",
                                            type: "area",
                                            list: AreaCubit.get(context).areas,
                                            value: AreaCubit.get(context)
                                                .areas
                                                .first,
                                            orderId: widget.orderModel.id,
                                          ),
                                        );
                                      },
                                    ),
                                    BlocBuilder<GlobalCubit, GlobalState>(
                                      builder: (context, state) {
                                        if (crews.isEmpty) {
                                          return const DefaultText(
                                            text: "No Crew",
                                            align: TextAlign.right,
                                          );
                                        }
                                        return SizedBox(
                                          width: 7.w,
                                          child: DefaultDropDownMenu(
                                            height: 4.h,
                                            hint: "Crew",
                                            type: "crew",
                                            list:crews,
                                            value: crews
                                                .first,
                                            orderId: widget.orderModel.id,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
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
    );
  }
}
