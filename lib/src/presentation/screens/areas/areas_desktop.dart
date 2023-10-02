import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/area_cubit/area_cubit.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/states_cubit/states_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/data/models/area_model.dart';
import 'package:jetboard/src/data/network/requests/area_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/loading_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_dropdown.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';
import 'package:sizer/sizer.dart';

class AreaDesktop extends StatefulWidget {
  const AreaDesktop({super.key});

  @override
  State<AreaDesktop> createState() => _AreaDesktopState();
}

class _AreaDesktopState extends State<AreaDesktop> {
  TextEditingController search = TextEditingController();
  final TextEditingController nameEn = TextEditingController();
  final TextEditingController nameAr = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController discount = TextEditingController();
  final TextEditingController transportation = TextEditingController();
  int stateId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: EdgeInsets.only(
                  top: 5.h,
                  left: 3.w,
                  right: 50,
                ),
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
                      hintText: 'Name',
                      spreadRadius: 2,
                      blurRadius: 2,
                      shadowColor: AppColors.black.withOpacity(0.05),
                      haveShadow: true,
                      controller: search,
                      onChange: (value) {
                        if (value == "") {
                          AreaCubit.get(context).getArea();
                        }
                      },
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          AreaCubit.get(context).getArea(keyword: search.text);
                          printResponse(search.text);
                        },
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    BlocBuilder<StatesCubit, StatesState>(
                      builder: (context, state) {
                        return StatesCubit.get(context)
                                    .allStatesResponse
                                    ?.statesList ==
                                null
                            ? const SizedBox()
                            : SizedBox(
                                width: 8.w,
                                height: 5.h,
                                child: DefaultDropdown<AreaModel>(
                                  hint: "Governorate",
                                  showSearchBox: true,
                                  itemAsString: (AreaModel? u) =>
                                      u?.nameAr ?? "",
                                  items: StatesCubit.get(context)
                                      .allStatesResponse!
                                      .statesList!,
                                  onChanged: (val) {
                                    setState(() {
                                      AreaCubit.get(context).getAllAreas(
                                          stateId: val!.id == 0 ? 0 : val.id);
                                      selectedState = val;
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
                      offset: const Offset(0, 0),
                      spreadRadius: 2,
                      blurRadius: 2,
                      radius: 10,
                      gradientColors: const [
                        AppColors.green,
                        AppColors.lightgreen,
                      ],
                      fontSize: 4.sp,
                      haveShadow: false,
                      title: "Add",
                      onTap: () {
                        setState(() {
                          GlobalCubit.get(context).isedit = false;
                          nameEn.clear();
                          nameAr.clear();
                          price.clear();
                          discount.clear();
                          transportation.clear();
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
                                        text: "Add New Area",
                                        align: TextAlign.center),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 2.h,
                                        left: 3.w,
                                        right: 3.w,
                                      ),
                                      child: DefaultTextField(
                                        validator: nameEn.text,
                                        password: false,
                                        controller: nameEn,
                                        height: 7.h,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
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
                                        validator: nameAr.text,
                                        password: false,
                                        controller: nameAr,
                                        height: 7.h,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
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
                                        validator: price.text,
                                        password: false,
                                        height: 7.h,
                                        controller: price,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
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
                                        validator: transportation.text,
                                        password: false,
                                        height: 7.h,
                                        controller: transportation,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
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
                                        validator: discount.text,
                                        password: false,
                                        height: 7.h,
                                        controller: discount,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
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
                                        child: DefaultDropdown<String>(
                                          hint: "Governorate",
                                          showSearchBox: true,
                                          selectedItem: dropState,
                                          items: StatesCubit.get(context)
                                              .statesList,
                                          onChanged: (val) {
                                            setState(
                                              () {
                                                dropState = val!;
                                                stateId = StatesCubit.get(
                                                        context)
                                                    .allStatesResponse!
                                                    .statesList![
                                                        StatesCubit.get(context)
                                                            .statesList
                                                            .indexOf(val)]
                                                    .id!;
                                                printSuccess(
                                                    stateId.toString());
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
                                    if(price.text.isNotEmpty && discount.text.isNotEmpty && transportation.text.isNotEmpty){
                                      AreaCubit.get(context).addArea(
                                        areaRequest: AreaRequest(
                                          stateId: stateId,
                                          nameEn: nameEn.text,
                                          nameAr: nameAr.text,
                                          price: double.parse(price.text),
                                          discount: double.parse(discount.text),
                                          transportation:
                                          double.parse(transportation.text),
                                        ),
                                      );
                                      nameEn.clear();
                                      nameAr.clear();
                                      price.clear();
                                      discount.clear();
                                      transportation.clear();
                                      Navigator.pop(context);
                                    }else{
                                      DefaultToast.showMyToast("برجاء إدخال البيانات الناقصة");
                                    }
                                  },
                                  haveShadow: false,
                                  gradientColors: const [
                                    AppColors.green,
                                    AppColors.lightgreen,
                                  ],
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
              BlocBuilder<AreaCubit, AreaState>(
                builder: (context, state) {
                  if (AreaCubit.get(context).getAreaResponse?.areaModel ==
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
                  } else if (AreaCubit.get(context)
                      .getAreaResponse!
                      .areaModel!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Areas Found !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return SizedBox(
                    height: 90.h,
                    child: ListView.builder(
                      itemCount: AreaCubit.get(context).listCount,
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
                                      AreaCubit.get(context)
                                          .areaList[index]
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
                                    AreaCubit.get(context)
                                        .areaList[index]
                                        .nameAr
                                        .toString(),
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
                                    'Price',
                                    style: TextStyle(fontSize: 3.sp),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    AreaCubit.get(context)
                                        .areaList[index]
                                        .price
                                        .toString(),
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
                                    'Transportation',
                                    style: TextStyle(fontSize: 3.sp),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    AreaCubit.get(context)
                                        .areaList[index]
                                        .transportation
                                        .toString(),
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
                                    'Discount',
                                    style: TextStyle(fontSize: 3.sp),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    AreaCubit.get(context)
                                        .areaList[index]
                                        .discount
                                        .toString(),
                                    style: TextStyle(fontSize: 3.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                              child: CircleAvatar(
                                backgroundColor: AreaCubit.get(context)
                                            .areaList[index]
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
                              value: AreaCubit.get(context)
                                          .areaList[index]
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
                                AreaCubit.get(context).switched(index);
                                AreaCubit.get(context).updateAreaStatus(
                                  index: index,
                                  areaRequest: AreaRequest(
                                    id: AreaCubit.get(context)
                                        .areaList[index]
                                        .id,
                                    active: AreaCubit.get(context)
                                            .areaList[index]
                                            .active!
                                            .isOdd
                                        ? 1
                                        : 0,
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  GlobalCubit.get(context).isedit = true;
                                  nameEn.text = AreaCubit.get(context)
                                      .areaList[index]
                                      .nameEn!;
                                  nameAr.text = AreaCubit.get(context)
                                      .areaList[index]
                                      .nameAr!;
                                  price.text = AreaCubit.get(context)
                                      .areaList[index]
                                      .price
                                      .toString();
                                  discount.text = AreaCubit.get(context)
                                      .areaList[index]
                                      .discount
                                      .toString();
                                  transportation.text = AreaCubit.get(context)
                                      .areaList[index]
                                      .transportation
                                      .toString();
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
                                              text: "Update Area",
                                              align: TextAlign.center,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 2.h,
                                                left: 3.w,
                                                right: 3.w,
                                              ),
                                              child: DefaultTextField(
                                                validator: nameEn.text,
                                                password: false,
                                                controller: nameEn,
                                                height: 7.h,
                                                haveShadow: true,
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                color: AppColors.white,
                                                shadowColor: AppColors.black
                                                    .withOpacity(0.05),
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
                                                validator: nameAr.text,
                                                password: false,
                                                controller: nameAr,
                                                height: 7.h,
                                                haveShadow: true,
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                color: AppColors.white,
                                                shadowColor: AppColors.black
                                                    .withOpacity(0.05),
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
                                                validator: price.text,
                                                password: false,
                                                height: 7.h,
                                                controller: price,
                                                haveShadow: true,
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                color: AppColors.white,
                                                shadowColor: AppColors.black
                                                    .withOpacity(0.05),
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
                                                validator: transportation.text,
                                                password: false,
                                                height: 7.h,
                                                controller: transportation,
                                                haveShadow: true,
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                color: AppColors.white,
                                                shadowColor: AppColors.black
                                                    .withOpacity(0.05),
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
                                                validator: discount.text,
                                                password: false,
                                                height: 7.h,
                                                controller: discount,
                                                haveShadow: true,
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                color: AppColors.white,
                                                shadowColor: AppColors.black
                                                    .withOpacity(0.05),
                                                hintText: 'Discount',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      actions: <Widget>[
                                        DefaultAppButton(
                                          title: 'Save',
                                          radius: 10,
                                          width: 8.w,
                                          height: 5.h,
                                          fontSize: 3.sp,
                                          onTap: () {
                                            AreaCubit.get(context).updateArea(
                                              index: index,
                                              areaRequest: AreaRequest(
                                                id: AreaCubit.get(context)
                                                    .areaList[index]
                                                    .id,
                                                nameEn: nameEn.text,
                                                nameAr: nameAr.text,
                                                price: double.parse(price.text),
                                                discount:
                                                    double.parse(discount.text),
                                                transportation: double.parse(
                                                    transportation.text),
                                              ),
                                            );
                                            nameEn.clear();
                                            nameAr.clear();
                                            price.clear();
                                            discount.clear();
                                            transportation.clear();
                                            Navigator.pop(context);
                                          },
                                          haveShadow: false,
                                          gradientColors: const [
                                            AppColors.green,
                                            AppColors.lightgreen,
                                          ],
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
                              icon: const Icon(
                                Icons.edit,
                                color: AppColors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            IconButton(
                              onPressed: () {
                                AreaCubit.get(context).deleteArea(
                                    areaModel:
                                        AreaCubit.get(context).areaList[index]);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: AppColors.red,
                              ),
                            ),
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
