import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/drawer_desktop.dart';
import 'package:sizer/sizer.dart';

class LayoutDesktop extends StatefulWidget {
  const LayoutDesktop({super.key});

  @override
  State<LayoutDesktop> createState() => _LayoutDesktopState();
}

class _LayoutDesktopState extends State<LayoutDesktop> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.green,
          body: SafeArea(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: const [
                      DrawerListDesktop(),
                    ],
                  ),
                ),
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
                    child: GlobalCubit.get(context)
                        .pages[GlobalCubit.get(context).selectedIndex],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
