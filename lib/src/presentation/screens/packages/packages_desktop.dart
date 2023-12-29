import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/packages_cubit/packages_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/constants/end_points.dart';
import 'package:jetboard/src/data/network/requests/packages_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
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
  TextEditingController nameEn = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController descriptionEn = TextEditingController();
  TextEditingController descriptionAr = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController hasShipping = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var offersCubit = PackagesCubit.get(context);
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
                padding: EdgeInsets.only(top: 5.h, left: 3.w, right: 50),
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
                          offersCubit.getPackages();
                        }
                      },
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          offersCubit.getPackages(keyword: search.text);
                          printResponse(search.text);
                        },
                        color: AppColors.black,
                      ),
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
                          descriptionEn.clear();
                          nameAr.clear();
                          descriptionAr.clear();
                          price.clear();
                          hasShipping.clear();
                          imageApp = null;
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
                                        text: "Add New Package",
                                        align: TextAlign.center),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: DefaultTextField(
                                        validator: nameAr.text,
                                        password: false,
                                        controller: nameAr,
                                        height: 5.h,
                                        fontSize: 3.sp,
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
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: DefaultTextField(
                                        validator: nameEn.text,
                                        password: false,
                                        controller: nameEn,
                                        height: 5.h,
                                        fontSize: 3.sp,
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
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: SizedBox(
                                        height: 20.h,
                                        child: DefaultTextField(
                                          validator: descriptionAr.text,
                                          password: false,
                                          controller: descriptionAr,
                                          height: 20.h,
                                          keyboardType: TextInputType.multiline,
                                          fontSize: 3.sp,
                                          haveShadow: true,
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          maxLine: 7,
                                          collapsed: true,
                                          color: AppColors.white,
                                          shadowColor:
                                              AppColors.black.withOpacity(0.05),
                                          hintText: 'Arabic Description',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: DefaultTextField(
                                        validator: descriptionEn.text,
                                        password: false,
                                        controller: descriptionEn,
                                        height: 20.h,
                                        keyboardType: TextInputType.multiline,
                                        fontSize: 3.sp,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        maxLine: 7,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: 'English Description',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: DefaultTextField(
                                        validator: price.text,
                                        password: false,
                                        height: 7.h,
                                        fontSize: 4.sp,
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
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: DefaultTextField(
                                        validator: hasShipping.text,
                                        password: false,
                                        height: 7.h,
                                        fontSize: 4.sp,
                                        controller: hasShipping,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: AppColors.white,
                                        shadowColor:
                                        AppColors.black.withOpacity(0.05),
                                        hintText: 'Has Shipping',
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 2.h, left: 3.w, right: 3.w),
                                        child: BlocBuilder<PackagesCubit,
                                            PackagesState>(
                                          builder: (context, state) {
                                            return Container(
                                              height: 20.h,
                                              width: 20.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: GlobalCubit.get(context).isedit
                                                  ? Stack(
                                                      children: [
                                                        ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: imageApp ==
                                                                    null
                                                                ? offersCubit.fileResult ==
                                                                        null
                                                                    ? Container()
                                                                    : Image
                                                                        .memory(
                                                                        offersCubit
                                                                            .fileResult!
                                                                            .files
                                                                            .first
                                                                            .bytes!,
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                        width:
                                                                            100.w,
                                                                      )
                                                                : Image.network(
                                                              EndPoints.imageDomain +
                                                                        imageApp!,
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                    width:
                                                                        100.w,
                                                                  )),
                                                        Container(
                                                          height: 4.h,
                                                          width: 3.w,
                                                          decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20)),
                                                              color: AppColors
                                                                  .green),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                offersCubit
                                                                    .pickImage();
                                                                imageApp = null;
                                                                printSuccess(offersCubit
                                                                    .fileResult
                                                                    .toString());
                                                              },
                                                              icon: const Icon(
                                                                Icons.edit,
                                                                color: AppColors
                                                                    .white,
                                                              )),
                                                        )
                                                      ],
                                                    )
                                                  : offersCubit.fileResult == null
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                                Icons.image),
                                                            TextButton(
                                                                onPressed: () {
                                                                  offersCubit
                                                                      .pickImage();
                                                                },
                                                                child: const Text(
                                                                    'Select Image'))
                                                          ],
                                                        )
                                                      : Stack(
                                                          children: [
                                                            ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child: Image
                                                                    .memory(
                                                                  offersCubit
                                                                      .fileResult!
                                                                      .files
                                                                      .first
                                                                      .bytes!,
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                  width: 100.w,
                                                                )),
                                                            Container(
                                                              height: 4.h,
                                                              width: 3.w,
                                                              decoration: const BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              20)),
                                                                  color: AppColors
                                                                      .green),
                                                              child: IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    offersCubit
                                                                        .pickImage();
                                                                  },
                                                                  icon:
                                                                      const Icon(
                                                                    Icons.edit,
                                                                    color: AppColors
                                                                        .white,
                                                                  )),
                                                            )
                                                          ],
                                                        ),
                                            );
                                          },
                                        )),
                                  ],
                                ),
                              ),
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                              actions: <Widget>[
                                DefaultAppButton(
                                  title: "Save",
                                  onTap: () {
                                    offersCubit.addPackages(
                                        packagesRequest: PackagesRequest(
                                      nameEn: nameEn.text,
                                      descriptionEn: descriptionEn.text,
                                      nameAr: nameAr.text,
                                      descriptionAr: descriptionAr.text,
                                      price: double.parse(price.text),
                                      hasShipping: int.parse(hasShipping.text == "" ? "0":hasShipping.text),
                                      type: "package",
                                    ),);
                                    nameEn.clear();
                                    descriptionEn.clear();
                                    nameAr.clear();
                                    descriptionAr.clear();
                                    price.clear();
                                    hasShipping.clear();
                                    offersCubit.fileResult = null;
                                    Navigator.pop(context);
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
              BlocBuilder<PackagesCubit, PackagesState>(
                builder: (context, state) {
                  if (offersCubit
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
                  } else if (offersCubit
                      .getPackagesResponse!
                      .packagesModel!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Offers Found !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: SizedBox(
                      height: 90.h,
                      child: ListView.builder(
                        itemCount: offersCubit.listCount,
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
                                        'English Name',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        offersCubit.packageList[index].nameEn
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
                                        'Arabic Name',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        offersCubit.packageList[index].nameAr
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
                                        offersCubit.packageList[index].price
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
                                        offersCubit.packageList[index].type
                                            .toString(),
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Image.network(
                                    EndPoints.imageDomain +
                                        offersCubit.packageList[index].image,
                                    height: 6.h,
                                  )),
                              SizedBox(
                                width: 2.w,
                              ),
                              SizedBox(
                                height: 3.h,
                                child: CircleAvatar(
                                  backgroundColor:
                                      offersCubit.packageList[index].active == 1
                                          ? AppColors.green
                                          : AppColors.red,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Switch(
                                  value: offersCubit.packageList[index].active == 1
                                      ? true
                                      : false,
                                  activeColor: AppColors.green,
                                  activeTrackColor: AppColors.lightgreen,
                                  inactiveThumbColor: AppColors.red,
                                  inactiveTrackColor: AppColors.lightGrey,
                                  splashRadius: 3.0,
                                  onChanged: (value) {
                                    offersCubit.switched(index);
                                    offersCubit.updatePackagesStatus(
                                      indexs: index,
                                      packagesRequest: PackagesRequest(
                                        id: offersCubit.packageList[index].id,
                                        active: offersCubit
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
                                    setState(() {
                                      GlobalCubit.get(context).isedit = true;
                                      nameEn.text =
                                          offersCubit.packageList[index].nameEn;
                                      descriptionEn.text = offersCubit
                                          .packageList[index].descriptionEn;
                                      nameAr.text =
                                          offersCubit.packageList[index].nameAr;
                                      descriptionAr.text = offersCubit
                                          .packageList[index].descriptionAr;
                                      price.text = offersCubit
                                          .packageList[index].price
                                          .toString();
                                      hasShipping.text = offersCubit
                                          .packageList[index].hasShipping
                                          .toString();
                                      imageApp =
                                          offersCubit.packageList[index].image;
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
                                                    text: "Update Package",
                                                    align: TextAlign.center),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.h,
                                                      left: 3.w,
                                                      right: 3.w),
                                                  child: DefaultTextField(
                                                    validator: nameAr.text,
                                                    password: false,
                                                    controller: nameAr,
                                                    height: 5.h,
                                                    fontSize: 3.sp,
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
                                                      right: 3.w),
                                                  child: DefaultTextField(
                                                    validator: nameEn.text,
                                                    password: false,
                                                    controller: nameEn,
                                                    height: 5.h,
                                                    fontSize: 3.sp,
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
                                                      right: 3.w),
                                                  child: SizedBox(
                                                    height: 20.h,
                                                    child: DefaultTextField(
                                                      validator:
                                                          descriptionAr.text,
                                                      password: false,
                                                      controller: descriptionAr,
                                                      height: 20.h,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      fontSize: 3.sp,
                                                      haveShadow: true,
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      maxLine: 7,
                                                      collapsed: true,
                                                      color: AppColors.white,
                                                      shadowColor: AppColors
                                                          .black
                                                          .withOpacity(0.05),
                                                      hintText:
                                                          'Arabic Description',
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.h,
                                                      left: 3.w,
                                                      right: 3.w),
                                                  child: DefaultTextField(
                                                    validator:
                                                        descriptionEn.text,
                                                    password: false,
                                                    controller: descriptionEn,
                                                    height: 20.h,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    fontSize: 3.sp,
                                                    haveShadow: true,
                                                    spreadRadius: 2,
                                                    blurRadius: 2,
                                                    maxLine: 7,
                                                    color: AppColors.white,
                                                    shadowColor: AppColors.black
                                                        .withOpacity(0.05),
                                                    hintText:
                                                        'English Description',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.h,
                                                      left: 3.w,
                                                      right: 3.w),
                                                  child: DefaultTextField(
                                                    validator: price.text,
                                                    password: false,
                                                    height: 7.h,
                                                    fontSize: 4.sp,
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
                                                      right: 3.w),
                                                  child: DefaultTextField(
                                                    validator: hasShipping.text,
                                                    password: false,
                                                    height: 7.h,
                                                    fontSize: 4.sp,
                                                    controller: hasShipping,
                                                    haveShadow: true,
                                                    spreadRadius: 2,
                                                    blurRadius: 2,
                                                    color: AppColors.white,
                                                    shadowColor: AppColors.black
                                                        .withOpacity(0.05),
                                                    hintText: 'Has Shipping',
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.h,
                                                        left: 3.w,
                                                        right: 3.w),
                                                    child: BlocBuilder<
                                                        PackagesCubit,
                                                        PackagesState>(
                                                      builder:
                                                          (context, state) {
                                                        return Container(
                                                          height: 20.h,
                                                          width: 20.w,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      AppColors
                                                                          .grey),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: GlobalCubit.get(context).isedit
                                                              ? Stack(
                                                                  children: [
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                20),
                                                                        child: imageApp ==
                                                                                null
                                                                            ? offersCubit.fileResult == null
                                                                                ? Container()
                                                                                : Image.memory(
                                                                                    offersCubit.fileResult!.files.first.bytes!,
                                                                                    fit: BoxFit.fitWidth,
                                                                                    width: 100.w,
                                                                                  )
                                                                            : Image.network(
                                                                          EndPoints.imageDomain + imageApp!,
                                                                                fit: BoxFit.fitWidth,
                                                                                width: 100.w,
                                                                              )),
                                                                    Container(
                                                                      height:
                                                                          4.h,
                                                                      width:
                                                                          3.w,
                                                                      decoration: const BoxDecoration(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(20),
                                                                              bottomRight: Radius.circular(20)),
                                                                          color: AppColors.green),
                                                                      child: IconButton(
                                                                          onPressed: () {
                                                                            offersCubit.pickImage();
                                                                            imageApp =
                                                                                null;
                                                                            printSuccess(offersCubit.fileResult.toString());
                                                                          },
                                                                          icon: const Icon(
                                                                            Icons.edit,
                                                                            color:
                                                                                AppColors.white,
                                                                          )),
                                                                    )
                                                                  ],
                                                                )
                                                              : offersCubit.fileResult ==
                                                                      null
                                                                  ? Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        const Icon(
                                                                            Icons.image),
                                                                        TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              offersCubit.pickImage();
                                                                            },
                                                                            child:
                                                                                const Text('Select Image'))
                                                                      ],
                                                                    )
                                                                  : Stack(
                                                                      children: [
                                                                        ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                            child: Image.memory(
                                                                              offersCubit.fileResult!.files.first.bytes!,
                                                                              fit: BoxFit.fitWidth,
                                                                              width: 100.w,
                                                                            )),
                                                                        Container(
                                                                          height:
                                                                              4.h,
                                                                          width:
                                                                              3.w,
                                                                          decoration: const BoxDecoration(
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                                                              color: AppColors.green),
                                                                          child: IconButton(
                                                                              onPressed: () {
                                                                                offersCubit.pickImage();
                                                                              },
                                                                              icon: const Icon(
                                                                                Icons.edit,
                                                                                color: AppColors.white,
                                                                              )),
                                                                        )
                                                                      ],
                                                                    ),
                                                        );
                                                      },
                                                    )),
                                              ],
                                            ),
                                          ),
                                          actionsAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          actions: <Widget>[
                                            DefaultAppButton(
                                              title: "Save",
                                              onTap: () {
                                                offersCubit.updatePackages(
                                                  index: index,
                                                  packagesRequest:
                                                      PackagesRequest(
                                                    id: offersCubit
                                                        .packageList[index].id,
                                                    nameEn: nameEn.text,
                                                    descriptionEn:
                                                        descriptionEn.text,
                                                    nameAr: nameAr.text,
                                                    descriptionAr:
                                                        descriptionAr.text,
                                                    price: double.parse(
                                                        price.text),
                                                        hasShipping: int.parse(hasShipping.text == "" ? "0":hasShipping.text),
                                                    type: "package",
                                                  ),
                                                );
                                                nameEn.clear();
                                                descriptionEn.clear();
                                                nameAr.clear();
                                                descriptionAr.clear();
                                                price.clear();
                                                hasShipping.clear();
                                                offersCubit.fileResult = null;
                                                Navigator.pop(context);
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
                                              offersCubit.packageList[index].id,
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
                                    offersCubit.getPackageInfo(
                                      id: offersCubit.packageList[index].id,
                                      afterSuccess: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return ViewItems(
                                              items: offersCubit
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
                                    offersCubit.deletePackages(
                                        packagesModel:
                                            offersCubit.packageList[index]);
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
