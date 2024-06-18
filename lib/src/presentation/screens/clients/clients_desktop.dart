import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/clients_cubit/clients_cubit.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/core/constants/constants_variables.dart';
import 'package:jetboard/src/data/network/requests/user_request.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/core/shared/views/indicator_view.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';
import 'package:sizer/sizer.dart';
import '../../views/loading_view.dart';
import '../../../core/shared/widgets/default_app_button.dart';
import '../../../core/shared/widgets/default_text.dart';
import '../../../core/shared/widgets/default_text_field.dart';

class ClientsDesktop extends StatefulWidget {
  const ClientsDesktop({super.key});

  @override
  State<ClientsDesktop> createState() => _ClientsDesktopState();
}

class _ClientsDesktopState extends State<ClientsDesktop> {
  TextEditingController search = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userCubit = ClientsCubit.get(context);
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
                            userCubit.getClients();
                          }
                        },
                        suffix: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            userCubit.getClients(keyword: search.text);
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
                          AppColors.lightGreen,
                        ],
                        fontSize: 4.sp,
                        title: "Add",
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: AppColors.white,
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      const DefaultText(
                                        text: "Add New Client",
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
                                        password: userCubit.pass,
                                        controller: password,
                                        haveShadow: true,
                                        height: 5.h,
                                        horizontalPadding: 50,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        suffix: IconButton(
                                          onPressed: () {
                                            userCubit.isPassword();
                                          },
                                          icon: Icon(
                                            userCubit.pass
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
                                        IndicatorView.showIndicator();
                                        userCubit.addClient(
                                          userRequest: UserRequset(
                                            name: fullName.text,
                                            phone: phone.text,
                                            email: email.text,
                                            password: password.text,
                                            role: "client",
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
                                            dropItemsItem = "";
                                          },
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
                      )
                    ],
                  ),
                ),
                BlocBuilder<ClientsCubit, ClientsState>(
                  builder: (context, state) {
                    if (userCubit.getUserResponse?.userModel == null) {
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
                    } else if (userCubit.clinetList.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: DefaultText(
                          text: "No Users Found !",
                          fontSize: 5.sp,
                        ),
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: SizedBox(
                        height: 90.h,
                        child: ListView.builder(
                          itemCount: userCubit.listCount,
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
                                        userCubit.clinetList[index].name,
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
                                        userCubit.clinetList[index].phone,
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
                                        userCubit.clinetList[index].email,
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
                                        userCubit.clinetList[index].rate
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
                                        userCubit.clinetList[index].active == 1
                                            ? AppColors.green
                                            : AppColors.red,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Switch(
                                  value: userCubit.clinetList[index].active == 1
                                      ? true
                                      : false,
                                  activeColor: AppColors.green,
                                  activeTrackColor: AppColors.lightGreen,
                                  inactiveThumbColor: AppColors.red,
                                  inactiveTrackColor: AppColors.lightGrey,
                                  splashRadius: 3.0,
                                  onChanged: (value) {
                                    userCubit.switched(index);
                                    userCubit.updateClientStatus(
                                      index: index,
                                      userRequest: UserRequset(
                                        id: userCubit.clinetList[index].id,
                                        active: userCubit
                                                .clinetList[index].active.isEven
                                            ? 0
                                            : 1,
                                      ),
                                    );
                                  },
                                ),
                                // SizedBox(
                                //   width: 1.w,
                                // ),
                                // IconButton(
                                //   onPressed: () {
                                //     int clientId = userCubit.clinetList[index].id;
                                //     IndicatorView.showIndicator();
                                //     // userCubit.getArea(
                                //     //   crewId: clientId,
                                //     //   afterSuccess: () {
                                //     //     Navigator.pop(context);
                                //     //     showDialog<void>(
                                //     //       context: context,
                                //     //       barrierDismissible: true,
                                //     //       builder: (BuildContext context) {
                                //     //         return CrewArea(
                                //     //           crewId: crewId,
                                //     //         );
                                //     //       },
                                //     //     );
                                //     //   },
                                //     // );
                                //   },
                                //   icon: const Icon(Icons.location_on),
                                //   color: AppColors.grey,
                                // ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      fullName.text = userCubit.clinetList[index].name;
                                      phone.text = userCubit.clinetList[index].phone;
                                      if(userCubit.clinetList[index].email != "empty"){
                                        email.text = userCubit.clinetList[index].email;
                                      }
                                    });
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: AppColors.white,
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                const DefaultText(
                                                  text: "Update Client",
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
                                              ],
                                            ),
                                          ),
                                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                                          actions: <Widget>[
                                            DefaultAppButton(
                                              title: "Update",
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
                                                } else {
                                                  IndicatorView.showIndicator();
                                                  userCubit.updateClient(
                                                    userRequest: UserRequset(
                                                      id: userCubit.clinetList[index].id,
                                                      name: fullName.text,
                                                      phone: phone.text == userCubit.clinetList[index].phone?null:phone.text,
                                                      email: email.text,
                                                      role: "client",
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
                                                    }, index: index,
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
                                                fullName.clear();
                                                phone.clear();
                                                email.clear();
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
                                  icon: const Icon(Icons.edit),
                                  color: AppColors.grey,
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(
                                          () {
                                        if (userCubit.clinetList[index]
                                            .adminComment !=
                                            null) {
                                          commentController.text =
                                          userCubit.clinetList[index]
                                              .adminComment!;
                                        }
                                      },
                                    );
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: AppColors.white,
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                DefaultTextField(
                                                  width: 50.w,
                                                  height: 20.h,
                                                  hintText: "Write your Comment",
                                                  textColor: AppColors.mainColor,
                                                  maxLength: 10000,
                                                  fontSize: 4.sp,
                                                  validator: "",
                                                  maxLine: 5,
                                                  controller: commentController,
                                                  password: false,
                                                  haveShadow: false,
                                                  color: AppColors.white,
                                                )
                                              ],
                                            ),
                                          ),
                                          actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          actions: <Widget>[
                                            DefaultAppButton(
                                              title: "Save",
                                              onTap: () {
                                                ClientsCubit.get(context)
                                                    .updateAdminComment(
                                                  userId:userCubit.clinetList[index]
                                                      .id,
                                                  comment: commentController.text,
                                                  afterSuccess: () {
                                                    setState(
                                                          () {
                                                        userCubit.clinetList[index]
                                                            .adminComment =
                                                            commentController
                                                                .text;
                                                      },
                                                    );
                                                    commentController.clear();
                                                    Navigator.pop(context);
                                                  },
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
                                            DefaultAppButton(
                                              title: "Cancel",
                                              onTap: () {
                                                commentController.clear();
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
                                  icon: const Icon(Icons.comment),
                                  color: AppColors.grey,
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
