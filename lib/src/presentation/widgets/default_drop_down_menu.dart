// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jetboard/src/business_logic/area_cubit/area_cubit.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/item_cubit/items_cubit.dart';
import 'package:jetboard/src/business_logic/notification_cubit/notification_cubit.dart';
import 'package:jetboard/src/business_logic/orders_cubit/orders_cubit.dart';
import 'package:jetboard/src/business_logic/packages_cubit/packages_cubit.dart';
import 'package:jetboard/src/core/constants/constants_variables.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class DefaultDropDownMenu extends StatefulWidget {
  String? value;
  String? hint;
  List<String> list;
  double? height;
  Color? color;
  Color? borderColor;
  String type;
  int? orderId;
  int? userId;
  int? index;
  Function(String?)? onChanged;

  DefaultDropDownMenu({
    required this.list,
    this.type = "data",
    this.onChanged,
    this.value,
    this.userId,
    this.borderColor,
    this.height,
    this.orderId,
    this.color,
    this.hint,
    this.index,
    super.key,
  });

  @override
  State<DefaultDropDownMenu> createState() => _DefaultDropDownMenuState();
}

class _DefaultDropDownMenuState extends State<DefaultDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 8.h,
      decoration: BoxDecoration(
        color: widget.color ?? AppColors.lightGrey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: widget.borderColor ?? AppColors.grey,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 5,
        ),
        child: DropdownButton<String>(
          value: widget.value,
          underline: const SizedBox(),
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 4.sp,
          ),
          hint: Text(
            widget.hint!,
          ),
          isExpanded: true,
          elevation: 1,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 2.sp,
            fontWeight: FontWeight.w300,
          ),
          onChanged: (String? value) {
            setState(() {
              widget.value = value!;
              if (widget.type == "newCrew") {
                if (AreaCubit.get(context)
                        .areaId[AreaCubit.get(context)
                            .areas
                            .indexOf(value.toString())]
                        .toString() ==
                    "0") {
                  DefaultToast.showMyToast("Please Select Correct Area");
                } else {
                  registerAreaId = AreaCubit.get(context).areaId[
                      AreaCubit.get(context).areas.indexOf(value.toString())];
                  printResponse(registerAreaId.toString());
                }
              } else if (widget.type == "year") {
                GlobalCubit.get(context).getStatistics(
                  month: (selectedMonth + 1).toString(),
                  year: value,
                  afterSuccess: () {},
                );
                year = value;
              } else if (widget.type == "status") {
                OrdersCubit.get(context).updateOrderStatus(
                  orderId: widget.orderId!,
                  status: value,
                  afterSuccess: () {
                    setState(() {
                      OrdersCubit.get(context)
                          .ordersList[widget.index!]
                          .status = value;
                    });
                    NotificationCubit.get(context).notifyUser(
                      id: widget.userId!,
                      title: "الطلبات",
                      message:
                          "تم تغيير حالة طلبك رقم ${widget.orderId!} إلي $value",
                      afterSuccess: () {
                        NotificationCubit.get(context).saveNotification(
                          id: widget.userId!,
                          title: "الطلبات",
                          message:
                              "تم تغيير حالة طلبك رقم ${widget.orderId!} إلي $value",
                          afterSuccess: () {},
                        );
                      },
                    );
                  },
                );
              }
              // else if (widget.type == "role") {
              //   UsersCubit.get(context).getUser(type: value == "All"?" ":value);
              //   role = value;
              // }
              else if (widget.type == "package") {
                PackagesCubit.get(context)
                    .getPackages(type: value == "All" ? " " : value);
                package = value;
              } else if (widget.type == "item") {
                ItemsCubit.get(context)
                    .getItems(type: value == "All" ? " " : value);
                item = value;
              } else {
                widget.onChanged;
              }
              dropItemsInfo = value;
              dropItemsItem = value;
            });
          },
          items: widget.list.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
