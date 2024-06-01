import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/area_cubit/area_cubit.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/presentation/views/loading_view.dart';
import 'package:jetboard/src/presentation/widgets/area_widget.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class CrewArea extends StatefulWidget {
  final int crewId;

  const CrewArea({
    required this.crewId,
    Key? key,
  }) : super(key: key);

  @override
  State<CrewArea> createState() => _CrewAreaState();
}

class _CrewAreaState extends State<CrewArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Center(
        child: Container(
          width: 50.w,
          height: 70.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 1.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 4.sp,
                      color: AppColors.grey,
                    ),
                  ),
                  const Spacer(),
                  DefaultText(
                    text: "Update Crew Areas",
                    fontSize: 3.sp,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 2.w,
                  ),
                ],
              ),
              SizedBox(
                child: BlocBuilder<AreaCubit, AreaState>(
                  builder: (context, state) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        childAspectRatio: (20.w / 10.h),
                      ),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        if (AreaCubit.get(context).getAreaResponse?.areaModel ==
                            null) {
                          return LoadingView(
                            width: 20.w,
                            height: 6.h,
                          );
                        }
                        if (AreaCubit.get(context)
                            .getAreaResponse!
                            .areaModel!
                            .isEmpty) {
                          return Center(
                            child: DefaultText(
                              text: "No Areas Found !",
                              fontSize: 5.sp,
                            ),
                          );
                        }
                        return AreaWidget(
                          area: AreaCubit.get(context)
                              .getAreaResponse!
                              .areaModel![index],
                          crewId: widget.crewId,
                        );
                      },
                      itemCount:
                          AreaCubit.get(context).getAreaResponse?.areaModel ==
                                  null
                              ? 15
                              : AreaCubit.get(context)
                                  .getAreaResponse!
                                  .areaModel!
                                  .length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
