import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/views/loading_view.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/utils/enums.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/features/items/cubit/items_cubit.dart';
import 'package:jetboard/src/features/items/ui/views/add_item_view.dart';
import 'package:jetboard/src/features/items/ui/views/items_view.dart';
import 'package:sizer/sizer.dart';

class ItemsDesktop extends StatefulWidget {
  final ItemTypes type;

  const ItemsDesktop({
    required this.type,
    super.key,
  });

  @override
  State<ItemsDesktop> createState() => _ItemsDesktopState();
}

class _ItemsDesktopState extends State<ItemsDesktop> {
  ItemsCubit cubit = ItemsCubit(instance());
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getData(type: widget.type),
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
                  padding: EdgeInsets.only(
                    top: 5.h,
                    left: 3.w,
                    right: 50,
                    bottom: 1.h,
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
                        controller: search,
                        onChange: (value) {
                          if (value == "") {
                            cubit.getData(type: widget.type);
                          }
                        },
                        suffix: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            cubit.getData(
                              type: widget.type,
                              keyword: search.text,
                            );
                            printResponse(search.text);
                          },
                          color: AppColors.black,
                        ),
                      ),
                      const Spacer(),
                      AddItemView(
                        cubit: cubit,
                        type: widget.type,
                        title: "Add",
                      ),
                    ],
                  ),
                ),
                BlocBuilder<ItemsCubit, ItemsState>(
                  builder: (context, state) {
                    if (widget.type == ItemTypes.item && cubit.items == null ||
                        widget.type == ItemTypes.corporate &&
                            cubit.corporates == null ||
                        widget.type == ItemTypes.extra &&
                            cubit.extras == null) {
                      return SizedBox(
                        height: 79.h,
                        child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                              top: 1.h,
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
                    } else if (widget.type == ItemTypes.item &&
                            cubit.items!.isEmpty ||
                        widget.type == ItemTypes.corporate &&
                            cubit.corporates!.isEmpty ||
                        widget.type == ItemTypes.extra &&
                            cubit.extras!.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: DefaultText(
                          text: "No Items Found !",
                          fontSize: 5.sp,
                        ),
                      );
                    }
                    return ItemsView(
                      cubit: cubit,
                      type: widget.type,
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
