import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/packages_cubit/packages_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/data/network/requests/packages_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/endDrawer_packages.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../views/add_items.dart';
import '../../views/loading_view.dart';
import '../../views/view_items.dart';
import '../../widgets/default_app_button.dart';
import '../../widgets/default_text_field.dart';

class PackagesDesktop extends StatefulWidget {
  const PackagesDesktop({super.key});

  @override
  State<PackagesDesktop> createState() => _PackagesDesktopState();
}

class _PackagesDesktopState extends State<PackagesDesktop> {
  TextEditingController search = TextEditingController();
  String dropdownvalue = 'Item 1';

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  int currentIndex = 0;
  List<bool> isChecked = List.generate(2000, (index) => false);
  List<int> itemsId = [];

  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    var cubitP = PackagesCubit.get(context);
    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      key: scaffoldkey,
      endDrawer: BlocBuilder<PackagesCubit, PackagesState>(
        builder: (context, state) {
          return EndDrawerWidgetPackages(
            index: currentIndex,
            isEdit: cubit.isedit,
            packagesModel: cubitP.packageList.isEmpty
                ? null
                : cubitP.packageList[currentIndex],
          );
        },
      ),
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
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          cubitP.getPackages(keyword: search.text);
                          printResponse(search.text);
                        },
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    BlocBuilder<PackagesCubit, PackagesState>(
                      builder: (context, state) {
                        return PackagesCubit.get(context).categoryTypes.isEmpty
                            ? const SizedBox()
                            : Container(
                                alignment: Alignment.centerLeft,
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
                                width: 6.w,
                                child: DropdownButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 4.sp,
                                  ),
                                  underline: const SizedBox(),
                                  value: cubitP.categoryTypes.first,
                                  items: cubitP.categoryTypes
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropdownvalue = value!;
                                      cubitP.getPackages(type: value);
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
              BlocBuilder<PackagesCubit, PackagesState>(
                builder: (context, state) {
                  if (PackagesCubit.get(context)
                          .getPackagesResponse
                          ?.packagesModel ==
                      null) {
                    return Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: SizedBox(
                        height: 79.h,
                        child: ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.5.h, left: 3.2.w, right: 2.5),
                                  child: LoadingView(
                                    width: 90.w,
                                    height: 5.h,
                                  ),
                                )),
                      ),
                    );
                  } else if (PackagesCubit.get(context)
                      .getPackagesResponse!
                      .packagesModel!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Packages Yet !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: SizedBox(
                      height: 90.h,
                      child: ListView.builder(
                        itemCount: cubitP.listCount,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                              top: 2.h, left: 3.2.w, right: 2.5.w, bottom: 1.h),
                          child: RowData(
                            rowHeight: 8.h,
                            data: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'NameEn',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        cubitP.packageList[index].nameEn
                                            .toString(),
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'NameAr',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        cubitP.packageList[index].nameAr
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
                                        'Price',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        cubitP.packageList[index].price
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
                                        'Type',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        cubitP.packageList[index].type
                                            .toString(),
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Image.network(
                                    imageDomain +
                                        cubitP.packageList[index].image,
                                    height: 6.h,
                                  )),
                              SizedBox(
                                width: 2.w,
                              ),
                              SizedBox(
                                height: 3.h,
                                child: CircleAvatar(
                                  backgroundColor:
                                      cubitP.packageList[index].active == 1
                                          ? AppColors.green
                                          : AppColors.red,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Switch(
                                  value: cubitP.packageList[index].active == 1
                                      ? true
                                      : false,
                                  activeColor: AppColors.green,
                                  activeTrackColor: AppColors.lightgreen,
                                  inactiveThumbColor: AppColors.red,
                                  inactiveTrackColor: AppColors.lightGrey,
                                  splashRadius: 3.0,
                                  onChanged: (value) {
                                    cubitP.switched(index);
                                    cubitP.updatePackagesStatus(
                                      indexs: index,
                                      packagesRequest: PackagesRequest(
                                        id: cubitP.packageList[index].id,
                                        active: cubitP
                                                .packageList[index].active.isOdd
                                            ? 1
                                            : 0,
                                      ),
                                    );
                                  }),
                              SizedBox(
                                width: 1.w,
                              ),
                              IconButton(
                                  onPressed: () {
                                    currentIndex = index;
                                    cubit.isedit = true;
                                    scaffoldkey.currentState!.openEndDrawer();
                                    printSuccess(currentIndex.toString());
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.grey,
                                  )),
                              SizedBox(
                                width: 2.w,
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AddItems(
                                          packageId:
                                              cubitP.packageList[index].id,
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: AppColors.grey,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    PackagesCubit.get(context).getPackageInfo(
                                      id: cubitP.packageList[index].id,
                                      afterSuccess: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return ViewItems(
                                              items: PackagesCubit.get(context)
                                                      .packageDetailsResponse!
                                                      .items ??
                                                  [],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.remove_red_eye,
                                    color: AppColors.grey,
                                  )),
                              SizedBox(
                                width: 2.w,
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubitP.deletePackages(
                                        packagesModel:
                                            cubitP.packageList[index]);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.red,
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
    );
  }
}
