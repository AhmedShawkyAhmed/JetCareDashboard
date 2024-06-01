import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/ads_cubit/ads_cubit.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/core/constants/constants_variables.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/data/network/requests/ads_request.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/presentation/views/loading_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class AdsDesktop extends StatefulWidget {
  const AdsDesktop({super.key});

  @override
  State<AdsDesktop> createState() => _AdsDesktopState();
}

class _AdsDesktopState extends State<AdsDesktop> {
  TextEditingController search = TextEditingController();

  final TextEditingController nameControllerEn = TextEditingController();

  final TextEditingController nameControllerAr = TextEditingController();

  final TextEditingController link = TextEditingController();

  int currentIndex = 0;

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
                          AdsCubit.get(context).getAds();
                        }
                      },
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          AdsCubit.get(context).getAds(keyword: search.text);
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
                        AppColors.lightGreen,
                      ],
                      fontSize: 4.sp,
                      haveShadow: false,
                      title: "Add",
                      onTap: () {
                        setState(() {
                          GlobalCubit.get(context).isEdit = false;
                          nameControllerEn.clear();
                          nameControllerAr.clear();
                          link.clear();
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
                                        text: "Add New Ads",
                                        align: TextAlign.center),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: DefaultTextField(
                                        validator: nameControllerAr.text,
                                        password: false,
                                        controller: nameControllerAr,
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
                                        validator: nameControllerEn.text,
                                        password: false,
                                        controller: nameControllerEn,
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
                                      child: DefaultTextField(
                                        validator: link.text,
                                        password: false,
                                        height: 5.h,
                                        fontSize: 3.sp,
                                        controller: link,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: 'Link',
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 2.h, left: 3.w, right: 3.w),
                                        child:
                                            BlocBuilder<AdsCubit, AdsState>(
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
                                              child: GlobalCubit.get(context)
                                                      .isEdit
                                                  ? Stack(
                                                      children: [
                                                        ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: imageApp ==
                                                                    null
                                                                ? AdsCubit.get(context)
                                                                            .fileResult ==
                                                                        null
                                                                    ? Container()
                                                                    : Image
                                                                        .memory(
                                                                        AdsCubit.get(context)
                                                                            .fileResult!
                                                                            .files
                                                                            .first
                                                                            .bytes!,
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                        width:
                                                                            100.w,
                                                                      )
                                                                : Image
                                                                    .network(
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
                                                                  bottomRight:
                                                                      Radius.circular(
                                                                          20)),
                                                              color: AppColors
                                                                  .green),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                AdsCubit.get(
                                                                        context)
                                                                    .pickImage();
                                                                imageApp =
                                                                    null;
                                                                printSuccess(AdsCubit
                                                                        .get(
                                                                            context)
                                                                    .fileResult
                                                                    .toString());
                                                              },
                                                              icon:
                                                                  const Icon(
                                                                Icons.edit,
                                                                color:
                                                                    AppColors
                                                                        .white,
                                                              )),
                                                        )
                                                      ],
                                                    )
                                                  : AdsCubit.get(context)
                                                              .fileResult ==
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
                                                                  AdsCubit.get(
                                                                          context)
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
                                                                  AdsCubit.get(
                                                                          context)
                                                                      .fileResult!
                                                                      .files
                                                                      .first
                                                                      .bytes!,
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
                                                                      topLeft:
                                                                          Radius.circular(
                                                                              20),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              20)),
                                                                  color: AppColors
                                                                      .green),
                                                              child:
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        AdsCubit.get(context)
                                                                            .pickImage();
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .edit,
                                                                        color:
                                                                            AppColors.white,
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
                                    AdsCubit.get(context).addAds(
                                        adsRequest: AdsRequest(
                                      nameEn: nameControllerEn.text,
                                      nameAr: nameControllerAr.text,
                                      link: link.text,
                                    ));
                                    nameControllerEn.clear();
                                    nameControllerAr.clear();
                                    link.clear();
                                    AdsCubit.get(context).fileResult = null;
                                    Navigator.pop(context);
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
                    ),
                  ],
                ),
              ),
              BlocBuilder<AdsCubit, AdsState>(
                builder: (context, state) {
                  if (AdsCubit.get(context).getAdsResponse?.adsModel == null) {
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
                        ),
                      ),
                    );
                  }
                  else if (AdsCubit.get(context).getAdsResponse!.adsModel!.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Ads Found !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: SizedBox(
                      height: 90.h,
                      child: ListView.builder(
                        itemCount: AdsCubit.get(context).adsList.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                            top: 2.h,
                            left: 3.2.w,
                            right: 2.5.w,
                            bottom: 1.h,
                          ),
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
                                        'English Name',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        AdsCubit.get(context)
                                            .adsList[index]
                                            .nameEn,
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
                                        'Arabic Name',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        AdsCubit.get(context)
                                            .adsList[index]
                                            .nameAr,
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
                                        'Link',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      DefaultText(
                                        text: AdsCubit.get(context)
                                            .adsList[index]
                                            .link,
                                        maxLines: 1,
                                        fontSize: 3.sp,
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Image.network(
                                    EndPoints.imageDomain +
                                        AdsCubit.get(context)
                                            .adsList[index]
                                            .image,
                                    height: 6.h,
                                  )),
                              SizedBox(
                                width: 5.w,
                              ),
                              SizedBox(
                                height: 3.h,
                                child: CircleAvatar(
                                  backgroundColor: AdsCubit.get(context)
                                              .adsList[index]
                                              .active ==
                                          1
                                      ? AppColors.green
                                      : AppColors.red,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Switch(
                                  value: AdsCubit.get(context)
                                              .adsList[index]
                                              .active ==
                                          1
                                      ? true
                                      : false,
                                  activeColor: AppColors.green,
                                  activeTrackColor: AppColors.lightGreen,
                                  inactiveThumbColor: AppColors.red,
                                  inactiveTrackColor: AppColors.lightGrey,
                                  splashRadius: 3.0,
                                  onChanged: (value) {
                                    AdsCubit.get(context).switched(index);
                                    AdsCubit.get(context).updateAdsStatus(
                                      index: index,
                                      adsRequest: AdsRequest(
                                        id: AdsCubit.get(context)
                                            .adsList[index]
                                            .id,
                                        active: AdsCubit.get(context)
                                                .adsList[index]
                                                .active
                                                .isOdd
                                            ? 1
                                            : 0,
                                      ),
                                      //indexs: index,
                                    );
                                  }),
                              SizedBox(
                                width: 1.w,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      GlobalCubit.get(context).isEdit = true;
                                      nameControllerEn.text =
                                          AdsCubit.get(context)
                                              .adsList[index]
                                              .nameEn;
                                      nameControllerAr.text =
                                          AdsCubit.get(context)
                                              .adsList[index]
                                              .nameAr;
                                      link.text = AdsCubit.get(context)
                                          .adsList[index]
                                          .link;
                                      imageApp = AdsCubit.get(context)
                                          .adsList[index]
                                          .image;
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
                                                    text: "Update Ads",
                                                    align: TextAlign.center),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.h,
                                                      left: 3.w,
                                                      right: 3.w),
                                                  child: DefaultTextField(
                                                    validator:
                                                        nameControllerAr.text,
                                                    password: false,
                                                    controller:
                                                        nameControllerAr,
                                                    height: 5.h,
                                                    fontSize: 3.sp,
                                                    haveShadow: true,
                                                    spreadRadius: 2,
                                                    blurRadius: 2,
                                                    color: AppColors.white,
                                                    shadowColor: AppColors
                                                        .black
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
                                                    validator:
                                                        nameControllerEn.text,
                                                    password: false,
                                                    controller:
                                                        nameControllerEn,
                                                    height: 5.h,
                                                    fontSize: 3.sp,
                                                    haveShadow: true,
                                                    spreadRadius: 2,
                                                    blurRadius: 2,
                                                    color: AppColors.white,
                                                    shadowColor: AppColors
                                                        .black
                                                        .withOpacity(0.05),
                                                    hintText: 'English Name',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.h,
                                                      left: 3.w,
                                                      right: 3.w),
                                                  child: DefaultTextField(
                                                    validator: link.text,
                                                    password: false,
                                                    height: 5.h,
                                                    fontSize: 3.sp,
                                                    controller: link,
                                                    haveShadow: true,
                                                    spreadRadius: 2,
                                                    blurRadius: 2,
                                                    color: AppColors.white,
                                                    shadowColor: AppColors
                                                        .black
                                                        .withOpacity(0.05),
                                                    hintText: 'Link',
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.h,
                                                        left: 3.w,
                                                        right: 3.w),
                                                    child: BlocBuilder<
                                                        AdsCubit, AdsState>(
                                                      builder:
                                                          (context, state) {
                                                        return Container(
                                                          height: 20.h,
                                                          width: 20.w,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .grey),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: GlobalCubit.get(
                                                                      context)
                                                                  .isEdit
                                                              ? Stack(
                                                                  children: [
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        child: imageApp == null
                                                                            ? AdsCubit.get(context).fileResult == null
                                                                                ? Container()
                                                                                : Image.memory(
                                                                                    AdsCubit.get(context).fileResult!.files.first.bytes!,
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
                                                                          borderRadius:
                                                                              BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                                                          color: AppColors.green),
                                                                      child: IconButton(
                                                                          onPressed: () {
                                                                            AdsCubit.get(context).pickImage();
                                                                            imageApp = null;
                                                                            printSuccess(AdsCubit.get(context).fileResult.toString());
                                                                          },
                                                                          icon: const Icon(
                                                                            Icons.edit,
                                                                            color: AppColors.white,
                                                                          )),
                                                                    )
                                                                  ],
                                                                )
                                                              : AdsCubit.get(context)
                                                                          .fileResult ==
                                                                      null
                                                                  ? Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment.center,
                                                                      children: [
                                                                        const Icon(
                                                                            Icons.image),
                                                                        TextButton(
                                                                            onPressed: () {
                                                                              AdsCubit.get(context).pickImage();
                                                                            },
                                                                            child: const Text('Select Image'))
                                                                      ],
                                                                    )
                                                                  : Stack(
                                                                      children: [
                                                                        ClipRRect(
                                                                            borderRadius: BorderRadius.circular(20),
                                                                            child: Image.memory(
                                                                              AdsCubit.get(context).fileResult!.files.first.bytes!,
                                                                              fit: BoxFit.fitWidth,
                                                                              width: 100.w,
                                                                            )),
                                                                        Container(
                                                                          height:
                                                                              4.h,
                                                                          width:
                                                                              3.w,
                                                                          decoration:
                                                                              const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)), color: AppColors.green),
                                                                          child: IconButton(
                                                                              onPressed: () {
                                                                                AdsCubit.get(context).pickImage();
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
                                                AdsCubit.get(context)
                                                    .updateAds(
                                                  index: index,
                                                  adsRequest: AdsRequest(
                                                    id: AdsCubit.get(context)
                                                        .adsList[index]
                                                        .id,
                                                    nameEn:
                                                        nameControllerEn.text,
                                                    nameAr:
                                                        nameControllerAr.text,
                                                    link: link.text,
                                                  ),
                                                );
                                                nameControllerEn.clear();
                                                nameControllerAr.clear();
                                                link.clear();
                                                AdsCubit.get(context)
                                                    .fileResult = null;
                                                Navigator.pop(context);
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
                                                Navigator.pop(context);
                                              },
                                              width: 10.w,
                                              height: 4.h,
                                              fontSize: 3.sp,
                                              textColor: AppColors.mainColor,
                                              buttonColor:
                                                  AppColors.lightGrey,
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
                                width: 1.w,
                              ),
                              IconButton(
                                  onPressed: () {
                                    AdsCubit.get(context).deleteAds(
                                        adsModel: AdsCubit.get(context)
                                            .adsList[index]);
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
