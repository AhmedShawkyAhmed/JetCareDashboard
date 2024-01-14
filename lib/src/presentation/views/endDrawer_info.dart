import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/info_cubit/info_cubit.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/data/models/info_model.dart';
import 'package:jetboard/src/data/network/requests/info_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_drop_down_menu.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class EndDrawerWidgetInfo extends StatefulWidget {
  EndDrawerWidgetInfo({super.key, 
    this.endDrawerWidth,
    this.heightBackButton,
    this.widthBackButton,
    this.fontTitle,
    this.fontAllTextField,
    this.heightButton,
    this.widthButton,
    this.fontButton,
    this.index,
    this.infoModel,
    required this.isEdit,
  });
  InfoModel? infoModel;
  bool isEdit;
  double? endDrawerWidth;
  double? heightBackButton, widthBackButton, fontTitle, fontAllTextField;
  double? heightButton, widthButton, fontButton;
  int? index;

  @override
  State<EndDrawerWidgetInfo> createState() => _EndDrawerWidgetInfoState();
}

class _EndDrawerWidgetInfoState extends State<EndDrawerWidgetInfo> {
  final TextEditingController titleEn = TextEditingController();
  final TextEditingController contentEn = TextEditingController();
  final TextEditingController titleAr = TextEditingController();
  final TextEditingController contentAr = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      titleEn.text = widget.infoModel?.titleEn ?? "";
      contentEn.text = widget.infoModel?.contentEn ?? "";
      titleAr.text = widget.infoModel?.titleAr ?? "";
      contentAr.text = widget.infoModel?.contentAr ?? "";
      dropItemsItem = widget.infoModel?.type ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cubit = GlobalCubit.get(context);
    var cubiti = InfoCubit.get(context);

    return BlocBuilder<InfoCubit, InfoState>(
      builder: (context, state) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: SingleChildScrollView(
            child: Container(
              height: 100.h,
              width: widget.endDrawerWidth ?? 23.w,
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.only(bottom: 35.h, left: 1.w, top: 3.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: GestureDetector(
                              onTap: (() {
                                Navigator.pop(context);
                                cubit.isShadowE();
                              }),
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: size.width == 600 ? 1.5.w : 1.h),
                                alignment: Alignment.center,
                                height: widget.heightBackButton ?? 4.h,
                                width: widget.widthBackButton ?? 2.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        AppColors.green,
                                        AppColors.lightgreen,
                                      ]),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            cubit.isEdit ? 'Update Info' : 'Add New Info',
                            style:
                                TextStyle(fontSize: widget.fontTitle ?? 6.sp),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 7.h, left: 3.w, right: 3.w),
                        child: DefaultTextField(
                          validator: titleEn.text,
                          password: false,
                          controller: titleEn,
                          height: 7.h,
                          fontSize: widget.fontAllTextField ?? 4.sp,
                          haveShadow: true,
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: 'English Name',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          //vertical: 3.h,
                        ),
                        child: DefaultTextField(
                          validator: contentEn.text,
                          password: false,
                          height: 7.h,
                          fontSize: widget.fontAllTextField ?? 4.sp,
                          controller: contentEn,
                          haveShadow: true,
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: 'ContentEn',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          //vertical: 3.h,
                        ),
                        child: DefaultTextField(
                          validator: titleAr.text,
                          password: false,
                          controller: titleAr,
                          height: 7.h,
                          fontSize: widget.fontAllTextField ?? 4.sp,
                          haveShadow: true,
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: 'Arabic Name',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          //vertical: 3.h,
                        ),
                        child: DefaultTextField(
                          validator: contentAr.text,
                          password: false,
                          height: 7.h,
                          fontSize: widget.fontAllTextField ?? 4.sp,
                          controller: contentAr,
                          haveShadow: true,
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: 'ContentAr',
                        ),
                      ),
                      InfoCubit.get(context).infoTypes.isEmpty
                          ? const SizedBox()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                //vertical: 3.h,
                              ),
                              child: DefaultDropDownMenu(
                                height: 6.h,
                                value: dropItemsItem == ''
                                    ? InfoCubit.get(context).infoTypes.first
                                    : dropItemsItem,
                                hint: 'type',
                                list: InfoCubit.get(context).infoTypes,
                              ),
                            ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 3.w, right: 3.w, top: 5.h),
                        child: Container(
                          alignment: Alignment.center,
                          child: DefaultAppButton(
                            title: cubit.isEdit ? 'Update' : 'Add',
                            radius: 10,
                            width: widget.widthButton ?? 8.w,
                            height: widget.heightButton ?? 5.h,
                            fontSize: widget.fontButton ?? 4.sp,
                            onTap: cubit.isEdit
                                ? () {
                                    cubiti.updateInfo(
                                        index: widget.index!,
                                        infoRequest: InfoRequest(
                                          id: widget.infoModel!.id,
                                          titleEn: titleEn.text,
                                          contentEn: contentEn.text,
                                          titleAr: titleAr.text,
                                          contentAr: contentAr.text,
                                          type: dropItemsItem,
                                        ));
                                    titleEn.clear();
                                    contentEn.clear();
                                    titleAr.clear();
                                    contentAr.clear();
                                    Navigator.pop(context);
                                  }
                                : () {
                                    var formdata = formKey.currentState;
                                    if (formdata!.validate()) {
                                      cubiti.addInfo(
                                          infoRequest: InfoRequest(
                                        titleEn: titleEn.text,
                                        contentEn: contentEn.text,
                                        titleAr: titleAr.text,
                                        contentAr: contentAr.text,
                                        type: dropItemsItem,
                                      ));
                                      titleEn.clear();
                                      contentEn.clear();
                                      titleAr.clear();
                                      contentAr.clear();
                                      Navigator.pop(context);
                                    } else {
                                      DefaultToast.showMyToast("Not Valid");
                                    }
                                  },
                            haveShadow: false,
                            gradientColors: const [
                              AppColors.green,
                              AppColors.lightgreen,
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
