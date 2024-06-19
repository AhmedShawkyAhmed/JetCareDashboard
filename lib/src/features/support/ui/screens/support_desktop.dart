import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/views/loading_view.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/support/cubit/support_cubit.dart';
import 'package:jetboard/src/features/support/ui/views/support_item_view.dart';
import 'package:sizer/sizer.dart';

class SupportDesktop extends StatefulWidget {
  const SupportDesktop({super.key});

  @override
  State<SupportDesktop> createState() => _SupportDesktopState();
}

class _SupportDesktopState extends State<SupportDesktop> {
  SupportCubit cubit = SupportCubit(instance());
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getSupport(),
      child: Scaffold(
        drawerScrimColor: AppColors.transparent,
        backgroundColor: AppColors.green,
        body: Container(
          height: 100.h,
          width: 100.w,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5.h, left: 3.w, right: 50),
                  child: DefaultTextField(
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
                        cubit.getSupport();
                      }
                    },
                    suffix: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        cubit.getSupport(keyword: search.text);
                        printResponse(search.text);
                      },
                      color: AppColors.black,
                    ),
                  ),
                ),
                BlocBuilder<SupportCubit, SupportState>(
                  builder: (context, state) {
                    if (cubit.supports == null) {
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
                    } else if (cubit.supports!.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: 40.h,
                        ),
                        child: Center(
                          child: DefaultText(
                            text: "No Support Messages Found !",
                            fontSize: 5.sp,
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      height: 90.h,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: cubit.supports!.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                            top: 2.h,
                            left: 3.2.w,
                            right: 2.5.w,
                            bottom: 1.h,
                          ),
                          child: SupportItemView(
                            cubit: cubit,
                            support: cubit.supports![index],
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
      ),
    );
  }
}
