import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/users_cubit/users_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/data/network/requests/user_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/end_drawer_users.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

import '../../views/loading_view.dart';
import '../../widgets/default_app_button.dart';
import '../../widgets/default_text.dart';
import '../../widgets/default_text_field.dart';

class UsersDesktop extends StatefulWidget {
  const UsersDesktop({super.key});

  @override
  State<UsersDesktop> createState() => _UsersDesktopState();
}

class _UsersDesktopState extends State<UsersDesktop> {
  TextEditingController search = TextEditingController();
  String dropdownvalue = 'All';
  int currentIndex = 0;

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    var cubitU = UsersCubit.get(context);

    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      backgroundColor: AppColors.green,
      key: scaffoldkey,
      endDrawer: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          return EndDrawerWidgetUsers(
            index: currentIndex,
            userModel:
                cubitU.userList.isEmpty ? null : cubitU.userList[currentIndex],
          );
        },
      ),
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
                        fontSize: 4.sp,
                        color: AppColors.white,
                        bottom: 0.5.h,
                        hintText: 'Phone Number',
                        spreadRadius: 2,
                        blurRadius: 2,
                        shadowColor: AppColors.black.withOpacity(0.05),
                        haveShadow: true,
                        controller: search,
                        suffix: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            cubitU.getUser(keyword: search.text);
                            //cubitU.getUser(type: '');
                            printResponse(search.text);
                          },
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      BlocBuilder<UsersCubit, UsersState>(
                        builder: (context, state) {
                          return UsersCubit.get(context).roleList.isEmpty
                              ? const SizedBox()
                              : Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            1, 1), // changes position of shadow
                                      )
                                    ],
                                  ),
                                  width: 4.w,
                                  child: DropdownButton(
                                    icon:  Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 4.sp,
                                    ),
                                    underline: const SizedBox(),
                                    value: cubitU.roleList.first,
                                    items: cubitU.roleList
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownvalue = value!;
                                        cubitU.getUser(type: value);
                                        // cubitU.getUser(keyword: "");
                                        printResponse(value);
                                      });
                                    },
                                  ),
                                );
                        },
                      ),
                      const Spacer(),
                      DefaultAppButton(
                        width: 8.w,
                        height: 5.h,
                        radius: 10,
                        isGradient: false,
                        haveShadow: true,
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                        buttonColor: AppColors.black,
                        fontSize: 5.sp,
                        title: "Export",
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      DefaultAppButton(
                        width: 8.w,
                        height: 5.h,
                        haveShadow: true,
                        offset: const Offset(0, 0),
                        spreadRadius: 2,
                        blurRadius: 2,
                        radius: 10,
                        gradientColors: const [
                          AppColors.green,
                          AppColors.lightgreen,
                        ],
                        fontSize: 5.sp,
                        title: "Add",
                        onTap: () {
                          cubit.isedit = false;
                          scaffoldkey.currentState!.openEndDrawer();
                        },
                      )
                    ],
                  ),
                ),
                BlocBuilder<UsersCubit, UsersState>(
                  builder: (context, state) {
                    if(UsersCubit.get(context).getUserResponse?.userModel == null){
                      return SizedBox(
                        height: 79.h,
                        child: ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(
                                  top: 0.5.h, left: 2.8.w, right: 37),
                              child: LoadingView(
                                width: 90.w,
                                height: 5.h,
                              ),
                            )),
                      );
                    }
                    else if (UsersCubit.get(context).userList.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: DefaultText(
                          text: "No Users Yet !",
                          fontSize: 5.sp,
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: SizedBox(
                        height: 90.h,
                        child: ListView.builder(
                          itemCount: UsersCubit.get(context).listCount,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                                top: 2.h,
                                left: 3.2.w,
                                right: 2.5.w,
                                bottom: 1.h),
                            child: RowData(
                              rowHeight: 8.h,
                              data: [
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Name',
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          cubitU.userList[index].name,
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Phone',
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          cubitU.userList[index].phone,
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Email',
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          cubitU.userList[index].email,
                                          style: TextStyle(
                                              fontSize: 2.5.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Rate',
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          cubitU.userList[index].rate
                                              .toString(),
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Role',
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          cubitU.userList[index].role,
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                      ],
                                    )),
                                
                                SizedBox(
                                  height: 2.5.h,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        cubitU.userList[index].active == 1
                                            ? AppColors.green
                                            : AppColors.red,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Switch(
                                    value: cubitU.userList[index].active == 1
                                        ? true
                                        : false,
                                    activeColor: AppColors.green,
                                    activeTrackColor: AppColors.lightgreen,
                                    inactiveThumbColor: AppColors.red,
                                    inactiveTrackColor: AppColors.lightGrey,
                                    splashRadius: 3.0,
                                    onChanged: (value) {
                                      cubitU.switched(index);
                                      cubitU.updateUserStatus(
                                        indexs: index,
                                        userRequset: UserRequset(
                                          id: cubitU.userList[index].id,
                                          active: cubitU
                                                  .userList[index].active.isEven
                                              ? 0
                                              : 1,
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  width: 1.w,
                                ),
                                // IconButton(
                                //     onPressed: () {
                                //       if(cubitU.userList[index].role == "crew"){
                                //         currentIndex = index;
                                //         cubit.isedit = true;
                                //         scaffoldkey.currentState!.openEndDrawer();
                                //       }else{
                                //         DefaultToast.showMyToast("You Can't Edit Client Account");
                                //       }
                                //     },
                                //     icon: const Icon(
                                //       Icons.edit,
                                //       color: AppColors.grey,
                                //       size: 20,
                                //     )),
                                SizedBox(
                                  width: 1.w,
                                ),
                                IconButton(
                                    onPressed: () {
                                      if(cubitU.userList[index].role == "crew"){
                                        cubitU.deleteUser(
                                            userModel: cubitU.userList[index]);
                                      }else{
                                        DefaultToast.showMyToast("You Can't Delete Client Account");
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: AppColors.red,
                                      size: 20,
                                    )),
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
