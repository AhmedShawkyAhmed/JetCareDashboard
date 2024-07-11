import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/features/items/cubit/items_cubit.dart';
import 'package:jetboard/src/features/items/data/models/item_model.dart';
import 'package:sizer/sizer.dart';

class AddItemToOrderView extends StatefulWidget {
  final ItemsCubit itemsCubit;
  final Function(ItemModel item,int count) onSave;

  const AddItemToOrderView({
    required this.itemsCubit,
    required this.onSave,
    super.key,
  });

  @override
  State<AddItemToOrderView> createState() => _AddItemToOrderViewState();
}

class _AddItemToOrderViewState extends State<AddItemToOrderView> {
  TextEditingController spaceController = TextEditingController();
  _show(ItemModel item) {
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
                  text: "Enter Space or Count !!",
                  align: TextAlign.center,
                ),
                SizedBox(
                  height: 2.h,
                ),
                DefaultTextField(
                  controller: spaceController,
                  hintText: "Space or Count ",
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
              title: "Add",
              onTap: () {
                widget.onSave(item,int.parse(spaceController.text));
                spaceController.clear();
                NavigationService.pop();
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
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.w,
      height: 4.h,
      child: DefaultDropdown<ItemModel>(
        hint: "Items",
        showSearchBox: true,
        itemAsString: (ItemModel? u) => ("${u?.price} EGP - ${u?.nameAr} "),
        items: widget.itemsCubit.items!,
        onChanged: (val) {
          _show(val!);
        },
      ),
    );
  }
}
