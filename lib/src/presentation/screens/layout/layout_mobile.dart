import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:sizer/sizer.dart';

class LayoutMobile extends StatefulWidget {
  const LayoutMobile({super.key});

  @override
  State<LayoutMobile> createState() => _LayoutMobileState();
}

class _LayoutMobileState extends State<LayoutMobile> {
  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          //backgroundColor: AppColors.green,
          body: SafeArea(
            child: Row(
              children: [
                //Expanded(flex: 1, child: DrawerListMobile()),
                Expanded(
                    flex: 7,
                    child: Container(
                      height: 100.h,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                      child: cubit.pages[cubit.selectedIndex],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
