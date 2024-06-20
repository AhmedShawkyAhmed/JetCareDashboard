import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/features/ads/cubit/ads_cubit.dart';
import 'package:jetboard/src/features/ads/data/models/ads_model.dart';
import 'package:jetboard/src/features/ads/data/requests/ads_request.dart';
import 'package:sizer/sizer.dart';

class AddAdsView extends StatefulWidget {
  final String title;
  final AdsCubit cubit;
  final AdsModel? adsModel;

  const AddAdsView({
    required this.title,
    required this.cubit,
    this.adsModel,
    super.key,
  });

  @override
  State<AddAdsView> createState() => _AddAdsViewState();
}

class _AddAdsViewState extends State<AddAdsView> {
  TextEditingController nameEnController = TextEditingController();
  TextEditingController nameArController = TextEditingController();
  TextEditingController link = TextEditingController();

  @override
  void dispose() {
    nameEnController.clear();
    nameArController.clear();
    link.clear();
    widget.cubit.fileResult = null;
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
                  text: "${widget.title} Ads",
                  align: TextAlign.center,
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
                    height: 5.h,
                    fontSize: 3.sp,
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
                    validator: nameEnController.text,
                    password: false,
                    controller: nameEnController,
                    height: 5.h,
                    fontSize: 3.sp,
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
                    validator: link.text,
                    password: false,
                    height: 5.h,
                    fontSize: 3.sp,
                    controller: link,
                    haveShadow: true,
                    spreadRadius: 2,
                    blurRadius: 2,
                    color: AppColors.white,
                    shadowColor: AppColors.black.withOpacity(0.05),
                    hintText: 'Link',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.w,
                    right: 3.w,
                  ),
                  child: BlocBuilder<AdsCubit, AdsState>(
                    builder: (context, state) {
                      return Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.grey,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: widget.adsModel != null
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: widget.adsModel?.image == null
                                        ? widget.cubit.fileResult == null
                                            ? Container()
                                            : Image.memory(
                                                widget.cubit.fileResult!.files
                                                    .first.bytes!,
                                                fit: BoxFit.fitWidth,
                                                width: 100.w,
                                              )
                                        : Image.network(
                                            EndPoints.imageDomain +
                                                widget.adsModel!.image!,
                                            fit: BoxFit.fitWidth,
                                            width: 100.w,
                                          ),
                                  ),
                                  Container(
                                    height: 4.h,
                                    width: 3.w,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      color: AppColors.green,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        widget.cubit.pickImage();
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : widget.cubit.fileResult == null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.image),
                                      TextButton(
                                        onPressed: () {
                                          widget.cubit.pickImage();
                                        },
                                        child: const Text('Select Image'),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.memory(
                                          widget.cubit.fileResult!.files.first
                                              .bytes!,
                                          fit: BoxFit.fitWidth,
                                          width: 100.w,
                                        ),
                                      ),
                                      Container(
                                        height: 4.h,
                                        width: 3.w,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                          color: AppColors.green,
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            widget.cubit.pickImage();
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            DefaultAppButton(
              title: "Save",
              onTap: () {
                widget.cubit.addAds(
                  request: AdsRequest(
                    nameEn: nameEnController.text,
                    nameAr: nameArController.text,
                    link: link.text,
                  ),
                );
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
      title: widget.title,
      onTap: () {
        _show();
      },
    );
  }
}
