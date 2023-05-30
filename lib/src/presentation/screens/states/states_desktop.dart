import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/states_cubit/states_cubit.dart';
import 'package:jetboard/src/data/network/requests/area_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/loading_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class StatesDesktop extends StatefulWidget {
  const StatesDesktop({super.key});

  @override
  State<StatesDesktop> createState() => _StatesDesktopState();
}

class _StatesDesktopState extends State<StatesDesktop> {
  TextEditingController search = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController nameEn = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      backgroundColor: AppColors.green,
      body: Container(
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
                padding: EdgeInsets.only(top: 5.h, left: 3.w, right: 50),
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
                      hintText: 'Name',
                      spreadRadius: 2,
                      blurRadius: 2,
                      shadowColor: AppColors.black.withOpacity(0.05),
                      haveShadow: true,
                      controller: search,
                      onChange: (value) {
                        if (value == "") {
                          StatesCubit.get(context).getAllStates();
                        }
                      },
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          StatesCubit.get(context)
                              .getAllStates(keyword: search.text);
                        },
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    const Spacer(),
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
                        showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: AppColors.white,
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    const DefaultText(text: "Add New State !!"),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    DefaultTextField(
                                      controller: nameAr,
                                      hintText: "Arabic Name",
                                      height: 5.h,
                                      password: false,
                                      haveShadow: false,
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    DefaultTextField(
                                      controller: nameEn,
                                      hintText: "English Name",
                                      height: 5.h,
                                      password: false,
                                      haveShadow: false,
                                    ),
                                  ],
                                ),
                              ),
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                              actions: <Widget>[
                                DefaultAppButton(
                                  title: "Save",
                                  onTap: () {
                                    StatesCubit.get(context).addState(
                                        areaRequest: AreaRequest(
                                          nameAr: nameAr.text,
                                          nameEn: nameEn.text,
                                        ),
                                        afterSuccess: () {
                                          Navigator.pop(context);

                                          StatesCubit.get(context)
                                              .getAllStates();
                                        });
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
                    )
                  ],
                ),
              ),
              BlocBuilder<StatesCubit, StatesState>(
                builder: (context, state) {
                  if (StatesCubit.get(context).allStatesResponse?.statesList ==
                      null) {
                    return SizedBox(
                      height: 79.h,
                      child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(
                                  top: 2.h,
                                  left: 3.2.w,
                                  right: 2.5.w,
                                  bottom: 0.5.h,
                                ),
                                child: LoadingView(
                                  width: 90.w,
                                  height: 5.h,
                                ),
                              )),
                    );
                  } else if (StatesCubit.get(context)
                      .allStatesResponse!
                      .statesList!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No States Found !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return SizedBox(
                    height: 90.h,
                    child: ListView.builder(
                      itemCount: StatesCubit.get(context)
                          .allStatesResponse!
                          .statesList!
                          .length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                          top: 2.h,
                          left: 3.2.w,
                          right: 2.5.w,
                          bottom: 1.h,
                        ),
                        child: RowData(
                          rowHeight: 7.h,
                          data: [
                            Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'English Name',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      StatesCubit.get(context)
                                          .allStatesResponse!
                                          .statesList![index]
                                          .nameEn
                                          .toString(),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Arabic Name',
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      StatesCubit.get(context)
                                          .allStatesResponse!
                                          .statesList![index]
                                          .nameAr
                                          .toString(),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 3.h,
                              child: CircleAvatar(
                                backgroundColor: StatesCubit.get(context)
                                            .allStatesResponse!
                                            .statesList![index]
                                            .active ==
                                        1
                                    ? AppColors.green
                                    : AppColors.red,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Switch(
                                value: StatesCubit.get(context)
                                            .allStatesResponse!
                                            .statesList![index]
                                            .active ==
                                        1
                                    ? true
                                    : false,
                                activeColor: AppColors.green,
                                activeTrackColor: AppColors.lightgreen,
                                inactiveThumbColor: AppColors.red,
                                inactiveTrackColor: AppColors.lightGrey,
                                splashRadius: 3.0,
                                onChanged: (value) {
                                  StatesCubit.get(context).switched(index);
                                  StatesCubit.get(context).changeStateStatus(
                                    id: StatesCubit.get(context)
                                        .allStatesResponse!
                                        .statesList![index]
                                        .id,
                                    active: StatesCubit.get(context)
                                            .allStatesResponse!
                                            .statesList![index]
                                            .active
                                            .isOdd
                                        ? 1
                                        : 0,
                                  );
                                }),
                            SizedBox(
                              width: 1.w,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            IconButton(
                                onPressed: () {
                                  StatesCubit.get(context).deleteState(
                                      id: StatesCubit.get(context)
                                          .allStatesResponse!
                                          .statesList![index]
                                          .id,
                                      afterSuccess: () {
                                        StatesCubit.get(context).getAllStates();
                                      });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.red,
                                )),
                            SizedBox(
                              width: 3.w,
                            ),
                          ],
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
    );
  }
}
