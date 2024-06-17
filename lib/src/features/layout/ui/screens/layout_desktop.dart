import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/features/layout/cubit/layout_cubit.dart';
import 'package:jetboard/src/features/layout/ui/views/drawer_desktop.dart';
import 'package:sizer/sizer.dart';

class LayoutDesktop extends StatefulWidget {
  const LayoutDesktop({super.key});

  @override
  State<LayoutDesktop> createState() => _LayoutDesktopState();
}

class _LayoutDesktopState extends State<LayoutDesktop> {
  late LayoutCubit cubit = BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.green,
          body: SafeArea(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      DrawerListDesktop(cubit: cubit),
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
                    child: cubit.items[cubit.selectedIndex].page,
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
