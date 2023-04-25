import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/ads_cubit/ads_cubit.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/data/network/requests/ads_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/endDrawer_ads.dart';
import 'package:jetboard/src/presentation/views/loading_view.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';


class AdsDesktop extends StatelessWidget {
  TextEditingController search = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  int currentIndex = 0;

  AdsDesktop({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    var cubita = AdsCubit.get(context);

    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      backgroundColor: AppColors.green,
      key: scaffoldkey,
      endDrawer: BlocBuilder<AdsCubit, AdsState>(
        builder: (context, state) {
          return EndDrawerWidgetAds(
            index: currentIndex,
            isEdit: cubit.isedit,
            adsModel:
                cubita.adsList.isEmpty ? null : cubita.adsList[currentIndex],
          );
        },
      ),
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
                          cubita.getAds(keyword: search.text);
                          printResponse(search.text);
                        },
                        color: AppColors.black,
                      ),
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
                              )),
                    );
                  }
                  else if(AdsCubit.get(context).getAdsResponse!.adsModel!.isEmpty){
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Ads Yet !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: SizedBox(
                      height: 90.h,
                      child: ListView.builder(
                        itemCount: AdsCubit.get(context).listCount,
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
                                        cubita.adsList[index].nameEn,
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
                                        cubita.adsList[index].nameAr,
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
                                        'Link',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        cubita.adsList[index].link,
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Image.network(
                                    imageDomain + cubita.adsList[index].image,
                                    height: 6.h,
                                  )),
                              SizedBox(
                                width: 5.w,
                              ),
                              SizedBox(
                                height: 3.h,
                                child: CircleAvatar(
                                  backgroundColor:
                                      cubita.adsList[index].active == 1
                                          ? AppColors.green
                                          : AppColors.red,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Switch(
                                  value: cubita.adsList[index].active == 1
                                      ? true
                                      : false,
                                  activeColor: AppColors.green,
                                  activeTrackColor: AppColors.lightgreen,
                                  inactiveThumbColor: AppColors.red,
                                  inactiveTrackColor: AppColors.lightGrey,
                                  splashRadius: 3.0,
                                  onChanged: (value) {
                                    cubita.switched(index);
                                    cubita.updateAdsStatus(
                                      index: index,
                                      adsRequest: AdsRequest(
                                        id: cubita.adsList[index].id,
                                        active:
                                            cubita.adsList[index].active.isOdd
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
                                    currentIndex = index;
                                    cubit.isedit = true;
                                    scaffoldkey.currentState!.openEndDrawer();
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
                                    cubita.deleteAds(
                                        adsModel: cubita.adsList[index]);
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
