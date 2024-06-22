import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/areas/cubit/areas_cubit.dart';
import 'package:jetboard/src/features/areas/data/models/area_model.dart';
import 'package:jetboard/src/features/states/data/models/state_model.dart';
import 'package:jetboard/src/features/areas/data/requests/area_request.dart';
import 'package:sizer/sizer.dart';

class AddAreaView extends StatefulWidget {
  final String title;
  final AreasCubit cubit;
  final AreaModel? area;

  const AddAreaView({
    required this.title,
    required this.cubit,
    this.area,
    super.key,
  });

  @override
  State<AddAreaView> createState() => _AddAreaViewState();
}

class _AddAreaViewState extends State<AddAreaView> {
  TextEditingController nameEnController = TextEditingController();
  TextEditingController nameArController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController transportationController = TextEditingController();
  int stateId = 0;
  StateModel? selectedState;

  @override
  void initState() {
    if (widget.area != null) {
      nameEnController.text = widget.area!.nameEn!;
      nameArController.text = widget.area!.nameAr!;
      priceController.text = widget.area!.price.toString();
      discountController.text = widget.area!.discount.toString();
      transportationController.text = widget.area!.transportation.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    nameEnController.clear();
    nameArController.clear();
    priceController.clear();
    discountController.clear();
    transportationController.clear();
    super.dispose();
  }

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
                DefaultText(
                  text: "${widget.title} Area",
                  align: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: DefaultTextField(
                    validator: nameEnController.text,
                    password: false,
                    controller: nameEnController,
                    height: 7.h,
                    haveShadow: true,
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: 'English Name',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: DefaultTextField(
                    validator: nameArController.text,
                    password: false,
                    controller: nameArController,
                    height: 7.h,
                    haveShadow: true,
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: 'Arabic Name',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: DefaultTextField(
                    validator: priceController.text,
                    password: false,
                    height: 7.h,
                    controller: priceController,
                    haveShadow: true,
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: 'Price',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: DefaultTextField(
                    validator: transportationController.text,
                    password: false,
                    height: 7.h,
                    controller: transportationController,
                    haveShadow: true,
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: 'Transportation',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: DefaultTextField(
                    validator: discountController.text,
                    password: false,
                    height: 7.h,
                    controller: discountController,
                    haveShadow: true,
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: 'Discount',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: SizedBox(
                    height: 4.h,
                    child: DefaultDropdown<StateModel>(
                      hint: "Governorate",
                      showSearchBox: true,
                      selectedItem: selectedState,
                      items: widget.cubit.states ?? [],
                      onChanged: (val) {
                        setState(
                          () {
                            selectedState = val!;
                            stateId = widget.cubit
                                .states![widget.cubit.states!.indexOf(val)].id!;
                            printSuccess(stateId.toString());
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            DefaultAppButton(
              title: 'Add',
              radius: 10,
              width: 8.w,
              height: 5.h,
              fontSize: 3.sp,
              onTap: () {
                if (widget.area == null) {
                  widget.cubit.addArea(
                    request: AreaRequest(
                      stateId: stateId,
                      nameEn: nameEnController.text,
                      nameAr: nameArController.text,
                      price: double.parse(priceController.text),
                      discount: double.parse(discountController.text),
                      transportation:
                          double.parse(transportationController.text),
                    ),
                  );
                } else {
                  widget.cubit.updateArea(
                    request: AreaRequest(
                      id: widget.area!.id,
                      nameEn: nameEnController.text,
                      nameAr: nameArController.text,
                      price: double.parse(priceController.text),
                      discount: double.parse(discountController.text),
                      transportation:
                          double.parse(transportationController.text),
                    ),
                  );
                }
              },
              haveShadow: false,
              gradientColors: const [
                AppColors.green,
                AppColors.lightGreen,
              ],
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
    return DefaultAppButton(
      width: 8.w,
      height: 5.h,
      offset: const Offset(0, 0),
      spreadRadius: 2,
      blurRadius: 2,
      radius: 10,
      gradientColors: const [
        AppColors.green,
        AppColors.lightGreen,
      ],
      fontSize: 4.sp,
      haveShadow: false,
      title: "Add",
      onTap: () {
        _show();
      },
    );
  }
}
