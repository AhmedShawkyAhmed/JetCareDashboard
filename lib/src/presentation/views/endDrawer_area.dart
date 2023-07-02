import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/area_cubit/area_cubit.dart';
import 'package:jetboard/src/business_logic/states_cubit/states_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/data/models/area_model.dart';
import 'package:jetboard/src/data/network/requests/area_request.dart';
import 'package:jetboard/src/presentation/widgets/default_dropdown.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/global_cubit/global_cubit.dart';
import '../styles/app_colors.dart';
import '../widgets/default_app_button.dart';
import '../widgets/default_text_field.dart';

class EndDrawerWidgetArea extends StatefulWidget {
  EndDrawerWidgetArea({
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
    this.areaModel,
    required this.isEdit,
  });

  AreaModel? areaModel;
  bool isEdit;
  double? endDrawerWidth;
  double? heightBackButton, widthBackButton, fontTitle, fontAllTextField;
  double? heightButton, widthButton, fontButton;
  int? index;

  @override
  State<EndDrawerWidgetArea> createState() => _EndDrawerWidgetAreaState();
}

class _EndDrawerWidgetAreaState extends State<EndDrawerWidgetArea> {
  final TextEditingController nameEn = TextEditingController();
  final TextEditingController nameAr = TextEditingController();
  final TextEditingController price = TextEditingController();
  int stateId = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      nameEn.text = widget.areaModel?.nameEn ?? "";
      nameAr.text = widget.areaModel?.nameAr ?? "";
      price.text = widget.areaModel?.price.toString() ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cubit = GlobalCubit.get(context);
    var cubitA = AreaCubit.get(context);

    return BlocBuilder<AreaCubit, AreaState>(
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
              padding: EdgeInsets.only(bottom: 35.h, left: 1.w, top: 3.h),
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
                                Icons.close,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          cubit.isedit ? 'Update Info' : 'Add New Info',
                          style: TextStyle(fontSize: widget.fontTitle ?? 6.sp),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7.h, left: 3.w, right: 3.w),
                      child: DefaultTextField(
                        validator: nameEn.text,
                        password: false,
                        controller: nameEn,
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
                        validator: nameAr.text,
                        password: false,
                        controller: nameAr,
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
                      padding: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
                      child: DefaultTextField(
                        validator: price.text,
                        password: false,
                        height: 7.h,
                        fontSize: widget.fontAllTextField ?? 4.sp,
                        controller: price,
                        haveShadow: true,
                        spreadRadius: 2,
                        blurRadius: 2,
                        color: AppColors.white,
                        shadowColor: AppColors.black.withOpacity(0.05),
                        hintText: 'Price',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
                      child: SizedBox(
                        height: 4.h,
                        child: DefaultDropdown<String>(
                          hint: "States",
                          showSearchBox: true,
                          selectedItem: dropState,
                          items: StatesCubit.get(context).statesList,
                          onChanged: (val) {
                            setState(() {
                              dropState = val!;
                              stateId = StatesCubit.get(context)
                                  .allStatesResponse!
                                  .statesList![StatesCubit.get(context)
                                      .statesList
                                      .indexOf(val)]
                                  .id;
                              printSuccess(stateId.toString());
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 5.h),
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
                                  cubitA.updateArea(
                                      index: widget.index!,
                                      areaRequest: AreaRequest(
                                        id: widget.areaModel!.id,
                                        nameEn: nameEn.text,
                                        nameAr: nameAr.text,
                                        price: double.parse(price.text),
                                      ));
                                  nameEn.clear();
                                  nameAr.clear();
                                  price.clear();
                                  Navigator.pop(context);
                                }
                              : () {
                                  cubitA.addArea(
                                      areaRequest: AreaRequest(
                                    stateId: stateId,
                                    nameEn: nameEn.text,
                                    nameAr: nameAr.text,
                                    price: double.parse(price.text),
                                  ));
                                  nameEn.clear();
                                  nameAr.clear();
                                  price.clear();
                                  Navigator.pop(context);
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
        );
      },
    );
  }
}
