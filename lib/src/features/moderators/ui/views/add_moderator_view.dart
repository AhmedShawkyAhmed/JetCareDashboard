import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/features/moderators/cubit/moderators_cubit.dart';
import 'package:jetboard/src/core/shared/requests/register_request.dart';
import 'package:sizer/sizer.dart';

class AddModeratorView extends StatefulWidget {
  final ModeratorsCubit cubit;
  final String title;
  final UserModel? moderator;

  const AddModeratorView({
    required this.cubit,
    required this.title,
    this.moderator,
    super.key,
  });

  @override
  State<AddModeratorView> createState() => _AddModeratorViewState();
}

class _AddModeratorViewState extends State<AddModeratorView> {
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void _show() {
    showDialog<void>(
      context: NavigationService.context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: SingleChildScrollView(
            child: SizedBox(
              width: 30.w,
              child: ListBody(
                children: <Widget>[
                  DefaultText(
                    text: "${widget.title} Moderator",
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
                    password: widget.cubit.pass,
                    controller: password,
                    haveShadow: true,
                    height: 5.h,
                    spreadRadius: 2,
                    blurRadius: 2,
                    suffix: IconButton(
                      onPressed: () {
                        widget.cubit.isPassword();
                      },
                      icon: Icon(
                        widget.cubit.pass
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.darkGrey.withOpacity(0.7),
                      ),
                    ),
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: 'Password',
                  ),
                ],
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            DefaultAppButton(
              title: "Save",
              onTap: () {
                if (widget.moderator == null) {
                  widget.cubit.addModerator(
                    request: RegisterRequest(
                      name: fullName.text,
                      phone: phone.text,
                      email: email.text,
                      password: password.text,
                      role: "moderator",
                    ),
                  );
                } else {
                  widget.cubit.updateModerator(
                    request: UserModel(
                      id: widget.moderator!.id,
                      name: fullName.text,
                      phone: phone.text == widget.moderator!.phone
                          ? null
                          : phone.text,
                      email: email.text,
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
  void initState() {
    if (widget.moderator != null) {
      fullName.text = widget.moderator!.name!;
      phone.text = widget.moderator!.phone!;
      email.text = widget.moderator!.email!;
    }
    super.initState();
  }

  @override
  void dispose() {
    fullName.clear();
    phone.clear();
    email.clear();
    password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.moderator == null
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
