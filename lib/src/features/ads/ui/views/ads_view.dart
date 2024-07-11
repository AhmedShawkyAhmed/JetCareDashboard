import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/features/ads/cubit/ads_cubit.dart';
import 'package:jetboard/src/features/ads/ui/views/add_ads_view.dart';
import 'package:sizer/sizer.dart';

class AdsView extends StatefulWidget {
  final AdsCubit cubit;

  const AdsView({
    required this.cubit,
    super.key,
  });

  @override
  State<AdsView> createState() => _AdsViewState();
}

class _AdsViewState extends State<AdsView> {
  TextEditingController nameEnController = TextEditingController();
  TextEditingController nameArController = TextEditingController();
  TextEditingController link = TextEditingController();

  @override
  void dispose() {
    nameEnController.clear();
    nameArController.clear();
    link.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        height: 90.h,
        child: ListView.builder(
          itemCount: widget.cubit.ads!.length,
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
                        widget.cubit.ads![index].nameEn ?? "",
                        style: TextStyle(fontSize: 3.sp),
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
                        'Arabic Name',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        widget.cubit.ads![index].nameAr ?? "",
                        style: TextStyle(fontSize: 3.sp),
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
                        'Link',
                        style: TextStyle(fontSize: 3.sp),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      DefaultText(
                        text: widget.cubit.ads![index].link ?? "",
                        maxLines: 1,
                        fontSize: 3.sp,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image.network(
                    EndPoints.imageDomain +
                        (widget.cubit.ads![index].image ?? ""),
                    height: 6.h,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                SizedBox(
                  height: 3.h,
                  child: CircleAvatar(
                    backgroundColor: widget.cubit.ads![index].isActive == true
                        ? AppColors.green
                        : AppColors.red,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Switch(
                  value:
                      widget.cubit.ads![index].isActive == true ? true : false,
                  activeColor: AppColors.green,
                  activeTrackColor: AppColors.lightGreen,
                  inactiveThumbColor: AppColors.red,
                  inactiveTrackColor: AppColors.lightGrey,
                  splashRadius: 3.0,
                  onChanged: (value) {
                    widget.cubit.switched(widget.cubit.ads![index]);
                  },
                ),
                SizedBox(
                  width: 1.w,
                ),
                AddAdsView(
                  title: "Update",
                  cubit: widget.cubit,
                  adsModel: widget.cubit.ads![index],
                ),
                SizedBox(
                  width: 1.w,
                ),
                IconButton(
                  onPressed: () {
                    widget.cubit.deleteAds(
                      id: widget.cubit.ads![index].id!,
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.red,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
