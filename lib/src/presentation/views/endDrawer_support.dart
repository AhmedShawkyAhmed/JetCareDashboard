import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_drop_down_menu.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class EndDrawerWidgetSupport extends StatelessWidget {
  EndDrawerWidgetSupport({super.key, 
    this.endDrawerWidth,
    this.heightBackButton,
    this.widthBackButton,
    this.fontTitle,
    this.fontAllTextField,
    this.heightButton,
    this.widthButton,
    this.fontButton,
  });
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  double? endDrawerWidth;
  double? heightBackButton, widthBackButton, fontTitle, fontAllTextField;
  double? heightButton, widthButton, fontButton;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cubit = GlobalCubit.get(context);
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: SingleChildScrollView(
            child: Container(
              height: 100.h,
              width:endDrawerWidth ?? 23.w,
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h, left: 1.w,top: 3.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 3.w),
                          child: GestureDetector(
                            onTap: (() {
                              Navigator.pop(context);
                              cubit.isShadowE();
                            }),
                            child: Container(
                              padding: EdgeInsets.only(left: size.width == 600 ? 1.5.w : 1.h),
                              alignment: Alignment.center,
                              height:heightBackButton ?? 4.h,
                              width:widthBackButton ?? 2.w,
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
                          cubit.isEdit ? 'Update Support' : 'Add New Support',
                          style: TextStyle(fontSize:fontTitle ?? 6.sp),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 7.h, left: 3.w, right: 3.w),
                      child: DefaultTextField(
                        password: false,
                        controller: fullName,
                        height: 6.h,
                        fontSize:fontAllTextField ?? 4.sp,
                        haveShadow: true,
                        spreadRadius: 2,
                        blurRadius: 2,
                        color: AppColors.white,
                        shadowColor: AppColors.black.withOpacity(0.05),
                        hintText: 'Client Name',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        //vertical: 3.h,
                      ),
                      child: DefaultTextField(
                        password: false,
                        height: 6.h,
                        fontSize:fontAllTextField ?? 4.sp,
                        controller: phone,
                        haveShadow: true,
                        spreadRadius: 2,
                        blurRadius: 2,
                        color: AppColors.white,
                        shadowColor: AppColors.black.withOpacity(0.05),
                        hintText: 'Email',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        //vertical: 3.h,
                      ),
                      child: DefaultTextField(
                        password: false,
                        height: 6.h,
                        fontSize:fontAllTextField ?? 4.sp,
                        controller: email,
                        haveShadow: true,
                        spreadRadius: 2,
                        blurRadius: 2,
                        color: AppColors.white,
                        shadowColor: AppColors.black.withOpacity(0.05),
                        hintText: 'Subject',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        //vertical: 3.h,
                      ),
                      child: DefaultTextField(
                        password: false,
                        height: 6.h,
                        fontSize:fontAllTextField ?? 4.sp,
                        controller: email,
                        haveShadow: true,
                        spreadRadius: 2,
                        blurRadius: 2,
                        color: AppColors.white,
                        shadowColor: AppColors.black.withOpacity(0.05),
                        hintText: 'Message',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        //vertical: 3.h,
                      ),
                      child: DefaultDropDownMenu(
                        height: 6.h,
                        value: list.first,
                        hint: 'Status',
                        list: list,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 5.h),
                      child: Container(
                        alignment: Alignment.center,
                        child: DefaultAppButton(
                          title: cubit.isEdit ? 'Update' : 'Add',
                          radius: 10,
                          width:widthButton ?? 8.w,
                          height:heightButton ?? 5.h,
                          fontSize:fontButton ?? 4.sp,
                          onTap: () {},
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
