import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/views/loading_view.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/moderators/cubit/moderators_cubit.dart';
import 'package:jetboard/src/features/moderators/ui/views/add_moderator_view.dart';
import 'package:jetboard/src/features/moderators/ui/views/moderator_view.dart';
import 'package:sizer/sizer.dart';

class ModeratorsDesktop extends StatefulWidget {
  const ModeratorsDesktop({super.key});

  @override
  State<ModeratorsDesktop> createState() => _ModeratorsDesktopState();
}

class _ModeratorsDesktopState extends State<ModeratorsDesktop> {
  ModeratorsCubit cubit = ModeratorsCubit(instance());
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getModerators(),
      child: Scaffold(
        drawerScrimColor: AppColors.transparent,
        backgroundColor: AppColors.green,
        body: SafeArea(
          child: Container(
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
                      top: 3.h,
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
                          hintText: 'Name or Phone Number',
                          spreadRadius: 2,
                          blurRadius: 2,
                          shadowColor: AppColors.black.withOpacity(0.05),
                          haveShadow: true,
                          controller: search,
                          onChange: (value) {
                            if (value == "") {
                              cubit.getModerators();
                            }
                          },
                          suffix: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              cubit.getModerators(keyword: search.text);
                              printResponse(search.text);
                            },
                            color: AppColors.black,
                          ),
                        ),
                        const Spacer(),
                        AddModeratorView(title: "Add", cubit: cubit),
                      ],
                    ),
                  ),
                  BlocBuilder<ModeratorsCubit, ModeratorsState>(
                    builder: (context, state) {
                      if (cubit.moderators == null) {
                        return SizedBox(
                          height: 79.h,
                          child: ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(
                                top: 0.5.h,
                                left: 2.8.w,
                                right: 37,
                              ),
                              child: LoadingView(
                                width: 90.w,
                                height: 5.h,
                              ),
                            ),
                          ),
                        );
                      } else if (cubit.moderators!.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: DefaultText(
                            text: "No Moderators Found !",
                            fontSize: 5.sp,
                          ),
                        );
                      }
                      return ModeratorView(cubit: cubit);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
