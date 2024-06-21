import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/views/loading_view.dart';
import 'package:jetboard/src/core/shared/widgets/default_dropdown.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/areas/cubit/areas_cubit.dart';
import 'package:jetboard/src/features/areas/data/models/area_model.dart';
import 'package:jetboard/src/features/areas/ui/views/add_area_view.dart';
import 'package:jetboard/src/features/areas/ui/views/area_view.dart';
import 'package:sizer/sizer.dart';

class AreaDesktop extends StatefulWidget {
  const AreaDesktop({super.key});

  @override
  State<AreaDesktop> createState() => _AreaDesktopState();
}

class _AreaDesktopState extends State<AreaDesktop> {
  AreasCubit cubit = AreasCubit(instance());
  TextEditingController searchController = TextEditingController();
  AreaModel? filteredState;

  @override
  void dispose() {
    searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getAllAreas(),
      child: Scaffold(
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
                        controller: searchController,
                        onChange: (value) {
                          if (value == "") {
                            cubit.getAllAreas();
                          }
                        },
                        suffix: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            cubit.getAllAreas(keyword: searchController.text);
                            printResponse(searchController.text);
                          },
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      BlocBuilder<AreasCubit, AreasState>(
                        builder: (context, state) {
                          return cubit.areasOfStates == null
                              ? const SizedBox()
                              : SizedBox(
                                  width: 8.w,
                                  height: 5.h,
                                  child: DefaultDropdown<AreaModel>(
                                    hint: "Governorate",
                                    showSearchBox: true,
                                    itemAsString: (AreaModel? u) =>
                                        u?.nameAr ?? "",
                                    items: cubit.areasOfStates!,
                                    onChanged: (val) {
                                      setState(() {
                                        cubit.getAreasOfState(
                                            stateId:
                                                val!.id == 0 ? 0 : val.id!);
                                        filteredState = val;
                                      });
                                    },
                                  ),
                                );
                        },
                      ),
                      const Spacer(),
                      AddAreaView(title: "Add",cubit: cubit),
                    ],
                  ),
                ),
                BlocBuilder<AreasCubit, AreasState>(
                  builder: (context, state) {
                    if (cubit.areas == null) {
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
                          ),
                        ),
                      );
                    } else if (cubit.areas!.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: DefaultText(
                          text: "No Areas Found !",
                          fontSize: 5.sp,
                        ),
                      );
                    }
                    return AreaView(cubit: cubit);
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
