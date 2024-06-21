import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/features/info/cubit/info_cubit.dart';
import 'package:jetboard/src/features/info/data/models/info_model.dart';
import 'package:jetboard/src/features/info/data/requests/info_request.dart';
import 'package:sizer/sizer.dart';

class AddInfoView extends StatefulWidget {
  final String title;
  final InfoCubit cubit;
  final InfoModel? info;

  const AddInfoView({
    required this.title,
    required this.cubit,
    this.info,
    super.key,
  });

  @override
  State<AddInfoView> createState() => _AddInfoViewState();
}

class _AddInfoViewState extends State<AddInfoView> {
  InfoModel? selectedItem;
  TextEditingController titleArController = TextEditingController();
  TextEditingController titleEnController = TextEditingController();
  TextEditingController contentArController = TextEditingController();
  TextEditingController contentEnController = TextEditingController();

  @override
  void initState() {
    if (widget.info != null) {
      titleEnController.text = widget.info!.titleEn ?? "";
      contentEnController.text = widget.info!.contentEn ?? "";
      titleArController.text = widget.info!.titleAr ?? "";
      contentArController.text = widget.info!.contentAr ?? "";
      selectedItem = widget.info!;
    }
    super.initState();
  }

  @override
  void dispose() {
    selectedItem = null;
    titleArController.clear();
    titleEnController.clear();
    contentArController.clear();
    contentEnController.clear();
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
                DefaultText(
                  text: "${widget.title} Info",
                  align: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: DefaultTextField(
                    validator: titleArController.text,
                    password: false,
                    controller: titleArController,
                    height: 5.h,
                    fontSize: 3.sp,
                    haveShadow: true,
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: 'Arabic Name',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: DefaultTextField(
                    validator: titleEnController.text,
                    password: false,
                    controller: titleEnController,
                    height: 5.h,
                    fontSize: 3.sp,
                    haveShadow: true,
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: 'English Name',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: DefaultTextField(
                    validator: contentArController.text,
                    password: false,
                    height: 5.h,
                    fontSize: 3.sp,
                    controller: contentArController,
                    haveShadow: true,
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: 'ContentAr',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: DefaultTextField(
                    validator: contentEnController.text,
                    password: false,
                    height: 5.h,
                    fontSize: 3.sp,
                    controller: contentEnController,
                    haveShadow: true,
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: 'ContentEn',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: DefaultDropdown<InfoModel>(
                    hint: "Info Type",
                    showSearchBox: true,
                    selectedItem: selectedItem ?? widget.cubit.types!.first,
                    items: widget.cubit.types ?? [],
                    onChanged: (val) {
                      setState(() {
                        selectedItem = val!;
                      });
                    },
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
                if (widget.info == null) {
                  widget.cubit.addInfo(
                    request: InfoRequest(
                      titleEn: titleEnController.text,
                      contentEn: contentEnController.text,
                      titleAr: titleArController.text,
                      contentAr: contentArController.text,
                      type: selectedItem!.type!,
                    ),
                  );
                } else {
                  widget.cubit.updateInfo(
                    request: InfoRequest(
                      id: widget.info!.id,
                      titleEn: titleEnController.text,
                      contentEn: contentEnController.text,
                      titleAr: titleArController.text,
                      contentAr: contentArController.text,
                      type: selectedItem!.type!,
                    ),
                  );
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
    return DefaultAppButton(
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
    );
  }
}
