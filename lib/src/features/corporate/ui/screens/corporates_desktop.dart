import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/views/loading_view.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/corporate/cubit/corporate_cubit.dart';
import 'package:jetboard/src/features/corporate/ui/views/add_corporate_view.dart';
import 'package:jetboard/src/features/corporate/ui/views/corporate_view.dart';
import 'package:jetboard/src/features/items/cubit/items_cubit.dart';
import 'package:sizer/sizer.dart';

class CorporatesDesktop extends StatefulWidget {
  const CorporatesDesktop({super.key});

  @override
  State<CorporatesDesktop> createState() => _CorporatesDesktopState();
}

class _CorporatesDesktopState extends State<CorporatesDesktop> {
  CorporateCubit cubit = CorporateCubit(instance());
  ItemsCubit itemsCubit = ItemsCubit(instance());
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => cubit..getCorporateOrders(),
        ),
        BlocProvider(
          create: (context) => itemsCubit,
        ),
      ],
      child: Scaffold(
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
                            cubit.getCorporateOrders();
                          }
                        },
                        suffix: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            cubit.getCorporateOrders(keyword: search.text);
                            printResponse(search.text);
                          },
                          color: AppColors.black,
                        ),
                      ),
                      const Spacer(),
                      AddCorporateView(
                        cubit: cubit,
                        itemsCubit: itemsCubit,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                BlocBuilder<CorporateCubit, CorporateState>(
                  builder: (context, state) {
                    if (cubit.corporateOrders == null) {
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
                    } else if (cubit.corporateOrders!.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: DefaultText(
                          text: "No Corporates Orders Found !",
                          fontSize: 5.sp,
                        ),
                      );
                    }
                    return CorporateView(cubit: cubit);
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
