import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/views/loading_view.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/utils/extensions.dart';
import 'package:jetboard/src/features/moderators/cubit/moderators_cubit.dart';
import 'package:jetboard/src/features/moderators/ui/widgets/moderator_widget.dart';
import 'package:sizer/sizer.dart';

class ModeratorAccessView extends StatefulWidget {
  final int moderatorId;

  const ModeratorAccessView({
    required this.moderatorId,
    super.key,
  });

  @override
  State<ModeratorAccessView> createState() => _ModeratorAccessViewState();
}

class _ModeratorAccessViewState extends State<ModeratorAccessView> {
  ModeratorsCubit cubit = ModeratorsCubit(instance());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getTabAccess(id: widget.moderatorId),
      child: Scaffold(
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
                        NavigationService.pop();
                      },
                      child: Icon(
                        Icons.close,
                        size: 4.sp,
                        color: AppColors.grey,
                      ),
                    ),
                    const Spacer(),
                    DefaultText(
                      text: "Moderator Access",
                      fontSize: 3.sp,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 2.w,
                    ),
                  ],
                ),
                SizedBox(
                  child: BlocBuilder<ModeratorsCubit, ModeratorsState>(
                    builder: (context, state) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                          left: 2.w,
                          right: 2.w,
                          top: 2.h,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 0,
                          childAspectRatio: (10.w / 5.h),
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: cubit.accessModel == null
                            ? 18
                            : cubit.accessModel!.access!.length,
                        itemBuilder: (context, index) {
                          return cubit.accessModel == null
                              ? LoadingView(
                                  width: 90.w,
                                  height: 10.h,
                                )
                              : ModeratorWidget(
                                  cubit: cubit,
                                  id: cubit.accessModel!.id!,
                                  name: cubit.accessModel!.access![index].key!
                                      .toTitleCase(),
                                  columnKey:
                                      cubit.accessModel!.access![index].key!,
                                  value:
                                      cubit.accessModel!.access![index].value!,
                                );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
