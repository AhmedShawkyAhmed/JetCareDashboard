import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/moderator_cubit/moderator_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/data/network/requests/user_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/moderator_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/indicator_view.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';
import '../../views/loading_view.dart';
import '../../widgets/default_app_button.dart';
import '../../widgets/default_text.dart';
import '../../widgets/default_text_field.dart';

class ModeratorsDesktop extends StatefulWidget {
  const ModeratorsDesktop({super.key});

  @override
  State<ModeratorsDesktop> createState() => _ModeratorsDesktopState();
}

class _ModeratorsDesktopState extends State<ModeratorsDesktop> {
  TextEditingController search = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var moderatorCubit = ModeratorCubit.get(context);
    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      backgroundColor: AppColors.green,
      body: SafeArea(
        child: Container(
          height: 100.h,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 3.h, left: 3.w, right: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextField(
                        password: false,
                        width: 25.w,
                        height: 5.h,
                        fontSize: 3.sp,
                        color: AppColors.white,
                        bottom: 0.5.h,
                        hintText: 'Name or Phone Number',
                        spreadRadius: 2,
                        blurRadius: 2,
                        shadowColor: AppColors.black.withOpacity(0.05),
                        haveShadow: true,
                        controller: search,
                        onChange: (value) {
                          if (value == "") {
                            moderatorCubit.getUser();
                          }
                        },
                        suffix: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            moderatorCubit.getUser(keyword: search.text);
                            printResponse(search.text);
                          },
                          color: AppColors.black,
                        ),
                      ),
                      const Spacer(),
                      DefaultAppButton(
                        width: 8.w,
                        height: 5.h,
                        haveShadow: false,
                        offset: const Offset(0, 0),
                        spreadRadius: 2,
                        blurRadius: 2,
                        radius: 10,
                        gradientColors: const [
                          AppColors.green,
                          AppColors.lightgreen,
                        ],
                        fontSize: 4.sp,
                        title: "Add",
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: AppColors.white,
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
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
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
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
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
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
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: 'Email',
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      DefaultTextField(
                                        validator: password.text,
                                        password: moderatorCubit.pass,
                                        controller: password,
                                        haveShadow: true,
                                        height: 5.h,
                                        horizontalPadding: 50,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        suffix: IconButton(
                                          onPressed: () {
                                            moderatorCubit.isPassword();
                                          },
                                          icon: Icon(
                                            moderatorCubit.pass
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: AppColors.darkGrey
                                                .withOpacity(0.7),
                                          ),
                                        ),
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: 'Password',
                                      ),
                                    ],
                                  ),
                                ),
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                actions: <Widget>[
                                  DefaultAppButton(
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
                                        IndicatorView.showIndicator(context);
                                        moderatorCubit.addUser(
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
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                BlocBuilder<ModeratorCubit, ModeratorState>(
                  builder: (context, state) {
                    if (moderatorCubit.getUserResponse?.userModel == null) {
                      return SizedBox(
                        height: 79.h,
                        child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                              top: 0.5.h,
                              left: 2.8.w,
                              right: 37,
                            ),
                            child: LoadingView(
                              width: 90.w,
                              height: 5.h,
                            ),
                          ),
                        ),
                      );
                    } else if (moderatorCubit.userList.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: DefaultText(
                          text: "No Moderators Found !",
                          fontSize: 5.sp,
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: SizedBox(
                        height: 90.h,
                        child: ListView.builder(
                          itemCount: moderatorCubit.listCount,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                              top: 2.h,
                              left: 3.2.w,
                              right: 2.5.w,
                              bottom: 1.h,
                            ),
                            child: RowData(
                              rowHeight: 8.h,
                              data: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Name',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        moderatorCubit.userList[index].name,
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Phone',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        moderatorCubit.userList[index].phone,
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Email',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        moderatorCubit.userList[index].email,
                                        style: TextStyle(
                                            fontSize: 2.5.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Rate',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        moderatorCubit.userList[index].rate
                                            .toString(),
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2.5.h,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        moderatorCubit.userList[index].active ==
                                                1
                                            ? AppColors.green
                                            : AppColors.red,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Switch(
                                  value:
                                      moderatorCubit.userList[index].active == 1
                                          ? true
                                          : false,
                                  activeColor: AppColors.green,
                                  activeTrackColor: AppColors.lightgreen,
                                  inactiveThumbColor: AppColors.red,
                                  inactiveTrackColor: AppColors.lightGrey,
                                  splashRadius: 3.0,
                                  onChanged: (value) {
                                    moderatorCubit.switched(index);
                                    moderatorCubit.updateUserStatus(
                                      index: index,
                                      userRequest: UserRequset(
                                        id: moderatorCubit.userList[index].id,
                                        active: moderatorCubit
                                                .userList[index].active.isEven
                                            ? 0
                                            : 1,
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                IconButton(
                                  onPressed: () {
                                    int crewId =
                                        moderatorCubit.userList[index].id;
                                    moderatorCubit.getSettings(
                                      moderatorId: crewId,
                                      afterSuccess: () {
                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return ModeratorView(
                                              crewId: crewId,
                                            );
                                          },
                                        );
                                        },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.desktop_access_disabled_outlined,
                                    color: AppColors.grey,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                IconButton(
                                  onPressed: () {
                                    moderatorCubit.deleteUser(
                                        userModel:
                                            moderatorCubit.userList[index]);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.red,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}