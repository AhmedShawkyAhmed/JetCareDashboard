import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/globals.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/corporate/cubit/corporate_cubit.dart';
import 'package:jetboard/src/features/corporate/data/requests/corporate_order_request.dart';
import 'package:jetboard/src/features/items/cubit/items_cubit.dart';
import 'package:jetboard/src/features/items/data/models/item_model.dart';
import 'package:sizer/sizer.dart';

class AddCorporateView extends StatefulWidget {
  final CorporateCubit cubit;
  final ItemsCubit itemsCubit;

  const AddCorporateView({
    required this.cubit,
    required this.itemsCubit,
    super.key,
  });

  @override
  State<AddCorporateView> createState() => _AddCorporateViewState();
}

class _AddCorporateViewState extends State<AddCorporateView> {
  ItemModel? selectedItem;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  void _show() {
    showDialog<void>(
      context: NavigationService.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const DefaultText(
                  text: "Create Corporate Order",
                  align: TextAlign.center,
                ),
                SizedBox(
                  height: 2.h,
                ),
                DefaultTextField(
                  password: false,
                  controller: nameController,
                  height: 5.h,
                  haveShadow: true,
                  spreadRadius: 2,
                  blurRadius: 2,
                  horizontalPadding: 50,
                  color: AppColors.white,
                  shadowColor: AppColors.black.withOpacity(0.05),
                  hintText: 'Corporate Name',
                ),
                SizedBox(
                  height: 1.h,
                ),
                DefaultTextField(
                  password: false,
                  height: 5.h,
                  controller: emailController,
                  haveShadow: true,
                  spreadRadius: 2,
                  horizontalPadding: 50,
                  blurRadius: 2,
                  color: AppColors.white,
                  shadowColor: AppColors.black.withOpacity(0.05),
                  hintText: 'Email',
                ),
                SizedBox(
                  height: 1.h,
                ),
                DefaultTextField(
                  password: false,
                  height: 5.h,
                  controller: phoneController,
                  haveShadow: true,
                  horizontalPadding: 50,
                  spreadRadius: 2,
                  blurRadius: 2,
                  color: AppColors.white,
                  shadowColor: AppColors.black.withOpacity(0.05),
                  hintText: 'Phone Number',
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 1.h,
                    right: 50,
                    left: 50,
                  ),
                  child: SizedBox(
                    height: 20.h,
                    child: DefaultTextField(
                      password: false,
                      controller: messageController,
                      height: 20.h,
                      keyboardType: TextInputType.multiline,
                      fontSize: 3.sp,
                      haveShadow: true,
                      spreadRadius: 2,
                      blurRadius: 2,
                      maxLine: 7,
                      collapsed: true,
                      color: AppColors.white,
                      shadowColor: AppColors.black.withOpacity(0.05),
                      hintText: 'Description Message',
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: DefaultDropdown<ItemModel>(
                    hint: "Corporate Service",
                    showSearchBox: true,
                    selectedItem: selectedItem,
                    items: widget.itemsCubit.corporates ?? [],
                    onChanged: (val) {
                      setState(() {
                        selectedItem = val!;
                      });
                      printLog(selectedItem!.id.toString());
                    },
                  ),
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            DefaultAppButton(
              title: "Create",
              onTap: () {
                widget.cubit.addCorporateOrder(
                  request: CorporateOrderRequest(
                    userId: Globals.userData.id!,
                    itemId: selectedItem!.id!,
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    message: messageController.text,
                  ),
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
    widget.itemsCubit.getCorporates();
    super.initState();
  }

  @override
  void dispose() {
    selectedItem = null;
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppButton(
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
      title: "Create",
      onTap: () {
        _show();
      },
    );
  }
}
