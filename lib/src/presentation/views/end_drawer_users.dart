import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/data/models/user_model.dart';
import 'package:jetboard/src/data/network/requests/user_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_dropdown.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/users_cubit/users_cubit.dart';
import '../../constants/constants_variables.dart';

class EndDrawerWidgetUsers extends StatefulWidget {
  EndDrawerWidgetUsers({
    super.key,
    // required this.fullName,
    // required this.phone,
    // required this.email,
    // required this.password,
    this.endDrawerWidth,
    this.heightBackButton,
    this.widthBackButton,
    this.fontTitle,
    this.fontAllTextField,
    this.heightButton,
    this.widthButton,
    this.fontButton,
    this.index,
    this.userModel,
  });

  UserModel? userModel;
  double? endDrawerWidth;
  double? heightBackButton, widthBackButton, fontTitle, fontAllTextField;
  double? heightButton, widthButton, fontButton;
  int? index;

  @override
  State<EndDrawerWidgetUsers> createState() => _EndDrawerWidgetUsersState();
}

class _EndDrawerWidgetUsersState extends State<EndDrawerWidgetUsers> {
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String type = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cubit = GlobalCubit.get(context);
    var cubitU = UsersCubit.get(context);
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: SingleChildScrollView(
            child: Container(
              width: widget.endDrawerWidth ?? 23.w,
              height: 100.h,
              color: AppColors.white,
              child: Padding(
                padding: EdgeInsets.only(bottom: 30.h, left: 2.w, top: 3.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 3.w),
                          child: InkWell(
                            onTap: (() {
                              Navigator.pop(context);
                              cubit.isShadowE();
                            }),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: size.width == 600 ? 1.5.w : 1.h),
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
                          'Add New User',
                          style: TextStyle(fontSize: widget.fontTitle ?? 6.sp),
                        ),
                      ],
                    ),
                    DefaultTextField(
                      validator: fullName.text,
                      password: false,
                      controller: fullName,
                      height: 6.h,
                      fontSize: widget.fontAllTextField ?? 4.sp,
                      haveShadow: true,
                      spreadRadius: 2,
                      blurRadius: 2,
                      horizontalPadding: 50,
                      color: AppColors.white,
                      shadowColor: AppColors.black.withOpacity(0.05),
                      hintText: 'Full Name',
                    ),
                    DefaultTextField(
                      validator: phone.text,
                      password: false,
                      height: 6.h,
                      fontSize: widget.fontAllTextField ?? 4.sp,
                      controller: phone,
                      haveShadow: true,
                      spreadRadius: 2,
                      horizontalPadding: 50,
                      blurRadius: 2,
                      color: AppColors.white,
                      shadowColor: AppColors.black.withOpacity(0.05),
                      hintText: 'Phone',
                    ),
                    DefaultTextField(
                      validator: email.text,
                      password: false,
                      height: 6.h,
                      fontSize: widget.fontAllTextField ?? 4.sp,
                      controller: email,
                      haveShadow: true,
                      horizontalPadding: 50,
                      spreadRadius: 2,
                      blurRadius: 2,
                      color: AppColors.white,
                      shadowColor: AppColors.black.withOpacity(0.05),
                      hintText: 'Email',
                    ),
                    cubit.isedit
                        ? const SizedBox()
                        : DefaultTextField(
                            validator: password.text,
                            password: cubitU.pass,
                            fontSize: widget.fontAllTextField ?? 4.sp,
                            controller: password,
                            haveShadow: true,
                            height: 6.h,
                            horizontalPadding: 50,
                            spreadRadius: 2,
                            blurRadius: 2,
                            suffix: IconButton(
                                onPressed: () {
                                  cubitU.isPassword();
                                },
                                icon: Icon(
                                  cubitU.pass
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.darkGrey.withOpacity(0.7),
                                )),
                            color: AppColors.white,
                            shadowColor: AppColors.black.withOpacity(0.05),
                            hintText: 'Password',
                          ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: DefaultDropdown<String>(
                        hint: "User Type",
                        showSearchBox: true,
                        selectedItem: type != ""
                            ? type == "client"
                                ? "Client"
                                : "Crew"
                            : null,
                        items: const ['Client', 'Crew'],
                        onChanged: (val) {
                          if (val == 'Client') {
                            type = 'client';
                          } else if (val == 'Crew') {
                            type = 'crew';
                          }
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 3.w,
                    //     //vertical: 3.h,
                    //   ),
                    //   child: BlocBuilder<AreaCubit, AreaState>(
                    //     builder: (context, state) {
                    //       if (AreaCubit.get(context).areasCount == 0) {
                    //         return const DefaultText(
                    //           text: "No Areas",
                    //           align: TextAlign.right,
                    //         );
                    //       }
                    //       return DefaultDropDownMenu(
                    //         height: 5.h,
                    //         hint: "Areas",
                    //         type: "newCrew",
                    //         list: AreaCubit.get(context).areas,
                    //         value: AreaCubit.get(context).areas.first,
                    //       );
                    //     },
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 5.h),
                      child: Container(
                        alignment: Alignment.center,
                        child: DefaultAppButton(
                          title: 'Add',
                          radius: 10,
                          width: widget.widthButton ?? 8.w,
                          height: widget.heightButton ?? 5.h,
                          fontSize: widget.fontButton ?? 4.sp,
                          onTap: () {
                            if (fullName.text == "") {
                              DefaultToast.showMyToast(
                                  "Please Enter the Full Name");
                            } else if (phone.text == "" ||
                                phone.text.length < 11) {
                              DefaultToast.showMyToast(
                                  "Please Enter Correct Phone Number");
                            } else if (email.text == "") {
                              DefaultToast.showMyToast(
                                  "Please Enter Correct Email Address");
                            } else if (password.text == "" ||
                                password.text.length < 8) {
                              DefaultToast.showMyToast(
                                  "Please Enter Password more than 8 Characters");
                            } else if (type == "") {
                              DefaultToast.showMyToast(
                                  "Please Select User Type");
                            } else {
                              cubitU.addUser(
                                  userRequset: UserRequset(
                                name: fullName.text,
                                phone: phone.text,
                                email: email.text,
                                password: password.text,
                                role: type,
                              ));
                              Navigator.pop(context);
                              fullName.clear();
                              phone.clear();
                              email.clear();
                              password.clear();
                              type = "";
                              dropItemsItem = "";
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
        );
      },
    );
  }
}
