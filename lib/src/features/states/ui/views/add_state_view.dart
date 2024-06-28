import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/features/states/cubit/states_cubit.dart';
import 'package:jetboard/src/features/states/data/models/state_model.dart';
import 'package:jetboard/src/features/states/data/requests/state_request.dart';
import 'package:sizer/sizer.dart';

class AddStateView extends StatefulWidget {
  final StatesCubit cubit;
  final StateModel? stateModel;

  const AddStateView({
    required this.cubit,
     this.stateModel,
    super.key,
  });

  @override
  State<AddStateView> createState() => _AddStateViewState();
}

class _AddStateViewState extends State<AddStateView> {
  TextEditingController nameArController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();

  @override
  void dispose() {
    nameArController.clear();
    nameEnController.clear();
    super.dispose();
  }

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
                  text: "Add Governorate",
                  align: TextAlign.center,
                ),
                SizedBox(
                  height: 2.h,
                ),
                DefaultTextField(
                  controller: nameArController,
                  hintText: "Arabic Name",
                  height: 5.h,
                  password: false,
                  haveShadow: false,
                ),
                SizedBox(
                  height: 1.h,
                ),
                DefaultTextField(
                  controller: nameEnController,
                  hintText: "English Name",
                  height: 5.h,
                  password: false,
                  haveShadow: false,
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            DefaultAppButton(
              title: "Save",
              onTap: () {
                widget.cubit.addState(
                  request: StateRequest(
                    nameAr: nameArController.text,
                    nameEn: nameEnController.text,
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
  Widget build(BuildContext context) {
    return widget.stateModel == null
        ? DefaultAppButton(
      width: 8.w,
      height: 5.h,
      haveShadow: false,
      offset: const Offset(0, 0),
      spreadRadius: 2,
      blurRadius: 2,
      radius: 10,
      gradientColors: const [
        AppColors.green,
        AppColors.lightGreen,
      ],
      fontSize: 4.sp,
      title: "Add",
      onTap: () {
        _show();
      },
    )
        : IconButton(
      onPressed: () {
        _show();
      },
      icon: const Icon(Icons.edit),
      color: AppColors.grey,
    );
  }
}
