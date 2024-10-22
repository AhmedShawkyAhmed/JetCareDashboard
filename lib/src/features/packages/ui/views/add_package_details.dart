import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/features/packages/cubit/packages_cubit.dart';
import 'package:jetboard/src/features/packages/data/requests/package_details_request.dart';
import 'package:sizer/sizer.dart';

class AddPackageDetails extends StatefulWidget {
  final PackagesCubit cubit;
  final int packageId;

  const AddPackageDetails({
    required this.cubit,
    required this.packageId,
    super.key,
  });

  @override
  State<AddPackageDetails> createState() => _AddPackageDetailsState();
}

class _AddPackageDetailsState extends State<AddPackageDetails> {
  List<bool> isChecked = List.generate(2000, (index) => false);
  TextEditingController nameArController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  List<String> nameAr = [];
  List<String> nameEn = [];

  @override
  void dispose() {
    nameAr.clear();
    nameEn.clear();
    nameArController.clear();
    nameEnController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 18.w,
          vertical: 10.h,
        ),
        padding: EdgeInsets.only(top: 1.h),
        height: 80.h,
        width: 80.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Add Package Details',
              style: TextStyle(fontSize: 5.sp),
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DefaultTextField(
                  controller: nameArController,
                  height: 5.h,
                  hintText: "Name Arabic",
                  password: false,
                  validator: "",
                  haveShadow: false,
                ),
                DefaultTextField(
                  controller: nameEnController,
                  hintText: "Name English",
                  height: 5.h,
                  password: false,
                  validator: "",
                  haveShadow: false,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      nameAr.add(nameArController.text);
                      nameEn.add(nameEnController.text);
                      nameArController.clear();
                      nameEnController.clear();
                    });
                  },
                  child: Container(
                    height: 5.h,
                    width: 5.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10.h),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.save,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 55.h,
              child: ListView.builder(
                itemCount: nameAr.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 2.h,
                      left: 2.w,
                      right: 2.w,
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
                                'NameAr',
                                style: TextStyle(fontSize: 3.sp),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Message'),
                                          content: Text(
                                            nameAr[index].toString(),
                                            style: TextStyle(fontSize: 3.sp),
                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                  nameAr[index],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 3.sp),
                                ),
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
                                'NameEn',
                                style: TextStyle(fontSize: 3.sp),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Message'),
                                        content: Text(
                                          nameEn[index].toString(),
                                          style: TextStyle(fontSize: 3.sp),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  nameEn[index],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 3.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              nameAr.removeAt(index);
                              nameEn.removeAt(index);
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DefaultAppButton(
                    width: 15.w,
                    height: 4.h,
                    haveShadow: true,
                    offset: const Offset(0, 0),
                    spreadRadius: 2,
                    blurRadius: 2,
                    radius: 10,
                    gradientColors: const [
                      AppColors.green,
                      AppColors.lightGreen,
                    ],
                    fontSize: 4.sp,
                    title: 'Save',
                    onTap: () {
                      widget.cubit.addPackageItem(
                        request: PackageDetailsRequest(
                          packageId: widget.packageId,
                          nameAr: nameAr,
                          nameEn: nameEn,
                        ),
                      );
                    },
                  ),
                  DefaultAppButton(
                    width: 15.w,
                    height: 4.h,
                    haveShadow: true,
                    offset: const Offset(0, 0),
                    spreadRadius: 2,
                    blurRadius: 2,
                    radius: 10,
                    isGradient: false,
                    fontSize: 4.sp,
                    title: 'Cancel',
                    onTap: () {
                      NavigationService.pop();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
