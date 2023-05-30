import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/ads_cubit/ads_cubit.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/data/models/ads_model.dart';
import 'package:jetboard/src/data/network/requests/ads_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class EndDrawerWidgetAds extends StatefulWidget {
  EndDrawerWidgetAds({
    super.key,
    this.endDrawerWidth,
    this.heightBackButton,
    this.widthBackButton,
    this.fontTitle,
    this.fontAllTextField,
    this.heightButton,
    this.widthButton,
    this.fontButton,
    this.index,
    this.adsModel,
    required this.isEdit,
  });

  double? endDrawerWidth;
  double? heightBackButton, widthBackButton, fontTitle, fontAllTextField;
  double? heightButton, widthButton, fontButton;
  int? index;
  AdsModel? adsModel;
  bool isEdit;

  @override
  State<EndDrawerWidgetAds> createState() => _EndDrawerWidgetAdsState();
}

class _EndDrawerWidgetAdsState extends State<EndDrawerWidgetAds> {
  final TextEditingController nameControllerEn = TextEditingController();
  final TextEditingController nameControllerAr = TextEditingController();
  final TextEditingController link = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      nameControllerEn.text = widget.adsModel?.nameEn ?? "";
      nameControllerAr.text = widget.adsModel?.nameAr ?? "";
      link.text = widget.adsModel?.link ?? "";
      imageApp = widget.adsModel?.image ?? "";
      printSuccess(widget.adsModel!.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cubit = GlobalCubit.get(context);
    var cubita = AdsCubit.get(context);
    return BlocBuilder<AdsCubit, AdsState>(
      builder: (context, state) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: Container(
            height: 100.h,
            width: widget.endDrawerWidth ?? 23.w,
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.only( left: 1.w, top: 3.h),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: InkWell(
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
                                  Icons.arrow_back_ios,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            cubit.isedit ? 'Update Ads' : 'Add New Ads',
                            style:
                                TextStyle(fontSize: widget.fontTitle ?? 6.sp),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
                        child: DefaultTextField(
                          validator: nameControllerAr.text,
                          password: false,
                          controller: nameControllerAr,
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
                        padding:
                        EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
                        child: DefaultTextField(
                          validator: nameControllerEn.text,
                          password: false,
                          controller: nameControllerEn,
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
                        padding: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
                        child: DefaultTextField(
                          validator: link.text,
                          password: false,
                          height: 7.h,
                          fontSize: widget.fontAllTextField ?? 4.sp,
                          controller: link,
                          haveShadow: true,
                          spreadRadius: 2,
                          blurRadius: 2,
                          color: AppColors.white,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          hintText: 'Link',
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
                          child: Container(
                            height: 20.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.grey),
                                borderRadius: BorderRadius.circular(20)),
                            child: cubit.isedit
                                ? Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: imageApp == null
                                              ? cubita.fileResult == null
                                                  ? Container()
                                                  : Image.memory(
                                                      cubita.fileResult!.files
                                                          .first.bytes!,
                                                      fit: BoxFit.fitWidth,
                                                      width: 100.w,
                                                    )
                                              : Image.network(
                                                  imageDomain + imageApp!,
                                                  fit: BoxFit.fitWidth,
                                                  width: 100.w,
                                                )),
                                      Container(
                                        height: 4.h,
                                        width: 3.w,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                            color: AppColors.green),
                                        child: IconButton(
                                            onPressed: () {
                                              cubita.pickImage();
                                              imageApp = null;
                                              printSuccess(
                                                  cubita.fileResult.toString());
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: AppColors.white,
                                            )),
                                      )
                                    ],
                                  )
                                : cubita.fileResult == null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.image),
                                          TextButton(
                                              onPressed: () {
                                                cubita.pickImage();
                                              },
                                              child: const Text('Select Image'))
                                        ],
                                      )
                                    : Stack(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.memory(
                                                cubita.fileResult!.files.first
                                                    .bytes!,
                                                fit: BoxFit.fitWidth,
                                                width: 100.w,
                                              )),
                                          Container(
                                            height: 4.h,
                                            width: 3.w,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20)),
                                                color: AppColors.green),
                                            child: IconButton(
                                                onPressed: () {
                                                  cubita.pickImage();
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: AppColors.white,
                                                )),
                                          )
                                        ],
                                      ),
                          )),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 3.w, right: 3.w, top: 5.h),
                        child: Container(
                          alignment: Alignment.center,
                          child: DefaultAppButton(
                            title: cubit.isedit ? 'Update' : 'Add',
                            radius: 10,
                            width: widget.widthButton ?? 8.w,
                            height: widget.heightButton ?? 5.h,
                            fontSize: widget.fontButton ?? 4.sp,
                            onTap: cubit.isedit
                                ? () {
                                    cubita.updateAds(
                                      index: widget.index!,
                                      adsRequest: AdsRequest(
                                        id: widget.adsModel!.id,
                                        nameEn: nameControllerEn.text,
                                        nameAr: nameControllerAr.text,
                                        link: link.text,
                                      ),
                                    );
                                    nameControllerEn.clear();
                                    nameControllerAr.clear();
                                    link.clear();
                                    cubita.fileResult = null;
                                    Navigator.pop(context);
                                  }
                                : () {
                                    var formdata = formKey.currentState;
                                    if (formdata!.validate()) {
                                      cubita.addAds(
                                          adsRequest: AdsRequest(
                                        nameEn: nameControllerEn.text,
                                        nameAr: nameControllerAr.text,
                                        link: link.text,
                                      ));
                                      nameControllerEn.clear();
                                      nameControllerAr.clear();
                                      link.clear();
                                      cubita.fileResult = null;
                                      Navigator.pop(context);
                                    } else {
                                      print('not valid');
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
