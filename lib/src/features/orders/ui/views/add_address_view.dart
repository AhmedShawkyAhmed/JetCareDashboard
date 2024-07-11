import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/areas/cubit/areas_cubit.dart';
import 'package:jetboard/src/features/areas/data/models/area_model.dart';
import 'package:jetboard/src/features/clients/cubit/clients_cubit.dart';
import 'package:jetboard/src/features/clients/data/requests/address_request.dart';
import 'package:jetboard/src/features/orders/cubit/orders_cubit.dart';
import 'package:jetboard/src/features/states/data/models/state_model.dart';
import 'package:sizer/sizer.dart';

class AddAddressView extends StatefulWidget {
  final OrdersCubit ordersCubit;
  final AreasCubit areasCubit;
  final ClientsCubit clientsCubit;
  final UserModel client;

  const AddAddressView({
    required this.ordersCubit,
    required this.areasCubit,
    required this.clientsCubit,
    required this.client,
    super.key,
  });

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  TextEditingController addressController = TextEditingController();

  int stateId = 0;
  int areaId = 0;

  _show() {
    showDialog<void>(
      context: NavigationService.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 1.h,
                ),
                DefaultTextField(
                  password: false,
                  height: 5.h,
                  controller: addressController,
                  haveShadow: true,
                  horizontalPadding: 50,
                  spreadRadius: 2,
                  blurRadius: 2,
                  color: AppColors.white,
                  shadowColor: AppColors.black.withOpacity(0.05),
                  hintText: 'Address',
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<AreasCubit, AreasState>(
                      builder: (context, state) {
                        return widget.areasCubit.states == null
                            ? SizedBox(
                                height: 4.h,
                                width: 12.w,
                                child: Center(
                                  child: DefaultText(
                                    text: "No Governorate Found !",
                                    fontSize: 2.sp,
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 12.w,
                                height: 4.h,
                                child: DefaultDropdown<StateModel>(
                                  hint: "Governorate",
                                  showSearchBox: true,
                                  itemAsString: (StateModel? u) =>
                                      u?.nameAr ?? "",
                                  items: widget.areasCubit.states!,
                                  onChanged: (val) {
                                    setState(() {
                                      widget.areasCubit.getAreasOfState(
                                          stateId: val!.id == 0 ? 0 : val.id!);
                                      stateId = (val.id == 0 ? 0 : val.id)!;
                                    });
                                  },
                                ),
                              );
                      },
                    ),
                    SizedBox(
                      width: 4.h,
                    ),
                    BlocBuilder<AreasCubit, AreasState>(
                      builder: (context, state) {
                        if (widget.areasCubit.areasOfStates!.isEmpty ||
                            stateId == 0) {
                          return SizedBox(
                            height: 4.h,
                            width: 12.w,
                            child: Center(
                              child: DefaultText(
                                text: "Select Governorate First",
                                fontSize: 2.sp,
                              ),
                            ),
                          );
                        }
                        return SizedBox(
                          height: 4.h,
                          width: 12.w,
                          child: DefaultDropdown<AreaModel>(
                            hint: "Areas",
                            showSearchBox: true,
                            itemAsString: (AreaModel? u) => u?.nameAr ?? "",
                            items: widget.areasCubit.areasOfStates!,
                            onChanged: (val) {
                              setState(() {
                                areaId = (val!.id == 0 ? 0 : val.id)!;
                                printSuccess(areaId.toString());
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            DefaultAppButton(
              title: "Save",
              onTap: () {
                widget.clientsCubit.addAddress(
                  request: AddressRequest(
                    userId: widget.client.id!,
                    phone: widget.client.phone,
                    latitude: "0.0",
                    longitude: "0.0",
                    stateId: stateId,
                    areaId: areaId,
                    address: addressController.text,
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
              width: 20,
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
  void dispose() {
    addressController.clear();
    stateId = 0;
    areaId = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultAppButton(
      width: 26.w,
      height: 4.h,
      haveShadow: false,
      horizontalPadding: 0,
      offset: const Offset(0, 0),
      buttonColor: AppColors.primary,
      textColor: AppColors.white,
      spreadRadius: 2,
      blurRadius: 2,
      radius: 6,
      isGradient: false,
      fontSize: 3.sp,
      title: "Add Address",
      onTap: () {
        _show();
      },
    );
  }
}
