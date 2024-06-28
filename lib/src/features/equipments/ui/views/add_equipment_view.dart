import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/features/equipments/cubit/equipment_cubit.dart';
import 'package:sizer/sizer.dart';

class AddEquipmentView extends StatefulWidget {
  final EquipmentCubit cubit;

  const AddEquipmentView({
    required this.cubit,
    super.key,
  });

  @override
  State<AddEquipmentView> createState() => _AddEquipmentViewState();
}

class _AddEquipmentViewState extends State<AddEquipmentView> {
  TextEditingController codeController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  void _show() {
    showDialog<void>(
      context: NavigationService.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const DefaultText(
                  text: "Add New Equipment",
                  align: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 3.w,
                    right: 3.w,
                    top: 2.h,
                  ),
                  padding: EdgeInsets.only(left: 1.w),
                  height: 5.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white,
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset(1, 1) // changes position of shadow
                          ),
                    ],
                    border: Border.all(
                      color: AppColors.grey,
                      width: 1.5,
                    ),
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: 3.sp,
                    ),
                    cursorColor: AppColors.darkGrey,
                    maxLines: 1,
                    controller: codeController,
                    decoration: InputDecoration(
                      hintText: 'Code',
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(
                        color: AppColors.darkGrey.withOpacity(0.7),
                        fontSize: 3.sp,
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: AppColors.transparent,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 3.w,
                    right: 3.w,
                    top: 2.h,
                  ),
                  padding: EdgeInsets.only(left: 1.w),
                  height: 5.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(1, 1), // changes position of shadow
                      )
                    ],
                    border: Border.all(
                      color: AppColors.grey,
                      width: 1.5,
                    ),
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: 3.sp,
                    ),
                    cursorColor: AppColors.darkGrey,
                    maxLines: 1,
                    controller: nameController,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: AppColors.darkGrey.withOpacity(0.7),
                        fontSize: 3.sp,
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: AppColors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            DefaultAppButton(
              title: "Save",
              onTap: () {
                widget.cubit.addEquipment(
                  code: codeController.text,
                  name: nameController.text,
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
            const SizedBox(
              width: 10,
            ),
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
        );
      },
    );
  }

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppButton(
      width: 8.w,
      height: 5.h,
      offset: const Offset(0, 0),
      spreadRadius: 2,
      blurRadius: 2,
      radius: 10,
      gradientColors: const [
        AppColors.green,
        AppColors.lightGreen,
      ],
      fontSize: 4.sp,
      haveShadow: false,
      title: "Add",
      onTap: () {
        _show();
      },
    );
  }
}
