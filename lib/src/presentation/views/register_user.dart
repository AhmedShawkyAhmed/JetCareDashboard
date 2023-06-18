import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/users_cubit/users_cubit.dart';
import 'package:jetboard/src/data/network/requests/user_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:jetboard/src/presentation/widgets/indicator_view.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Center(
        child: Container(
          width: 30.w,
          height: 38.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              const DefaultText(
                text: "Add New Moderator",
                align: TextAlign.center,
              ),
              SizedBox(
                height: 2.h,
              ),
              DefaultTextField(
                validator: fullName.text,
                password: false,
                controller: fullName,
                height: 5.h,
                haveShadow: true,
                spreadRadius: 2,
                blurRadius: 2,
                horizontalPadding: 50,
                color: AppColors.white,
                shadowColor: AppColors.black.withOpacity(0.05),
                hintText: 'Full Name',
              ),
              SizedBox(
                height: 1.h,
              ),
              DefaultTextField(
                validator: phone.text,
                password: false,
                height: 5.h,
                controller: phone,
                haveShadow: true,
                spreadRadius: 2,
                horizontalPadding: 50,
                blurRadius: 2,
                color: AppColors.white,
                shadowColor: AppColors.black.withOpacity(0.05),
                hintText: 'Phone',
              ),
              SizedBox(
                height: 1.h,
              ),
              DefaultTextField(
                validator: email.text,
                password: false,
                height: 5.h,
                controller: email,
                haveShadow: true,
                horizontalPadding: 50,
                spreadRadius: 2,
                blurRadius: 2,
                color: AppColors.white,
                shadowColor: AppColors.black.withOpacity(0.05),
                hintText: 'Email',
              ),
              SizedBox(
                height: 1.h,
              ),
              DefaultTextField(
                validator: password.text,
                password: UsersCubit.get(context).pass,
                controller: password,
                haveShadow: true,
                height: 5.h,
                horizontalPadding: 50,
                spreadRadius: 2,
                blurRadius: 2,
                suffix: IconButton(
                  onPressed: () {
                    UsersCubit.get(context).isPassword();
                  },
                  icon: Icon(
                    UsersCubit.get(context).pass
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.darkGrey.withOpacity(0.7),
                  ),
                ),
                color: AppColors.white,
                shadowColor: AppColors.black.withOpacity(0.05),
                hintText: 'Password',
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocBuilder<UsersCubit, UsersState>(
  builder: (context, state) {
    return DefaultAppButton(
                    title: "Save",
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
                      } else {
                        IndicatorView.showIndicator(
                            context);
                        UsersCubit.get(context).addUser(
                          userRequest: UserRequset(
                            name: fullName.text,
                            phone: phone.text,
                            email: email.text,
                            password: password.text,
                            role: "moderator",
                          ),
                          onError: () {
                            Navigator.pop(context);
                          },
                          afterSuccess: () {
                            UsersCubit.get(context)
                                .getUser();
                            Navigator.pop(context);
                            Navigator.pop(context);
                            fullName.clear();
                            phone.clear();
                            email.clear();
                            password.clear();
                          },
                        );
                      }
                    },
                    width: 10.w,
                    height: 4.h,
                    fontSize: 3.sp,
                    textColor: AppColors.white,
                    buttonColor: AppColors.pc,
                    isGradient: false,
                    radius: 10,
                  );
  },
),
                  const SizedBox(
                    width: 10,
                  ),
                  DefaultAppButton(
                    title: "Cancel",
                    onTap: () {
                      Navigator.pop(context);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
