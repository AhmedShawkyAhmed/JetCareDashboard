import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/features/moderators/cubit/moderators_cubit.dart';
import 'package:jetboard/src/features/moderators/data/requests/access_request.dart';
import 'package:sizer/sizer.dart';

class ModeratorWidget extends StatefulWidget {
  final int id;
  final String name;
  final String columnKey;
  final bool value;
  final ModeratorsCubit cubit;

  const ModeratorWidget({
    required this.cubit,
    required this.id,
    required this.name,
    required this.columnKey,
    this.value = false,
    super.key,
  });

  @override
  State<ModeratorWidget> createState() => _ModeratorWidgetState();
}

class _ModeratorWidgetState extends State<ModeratorWidget> {
  bool value = false;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 15.w,
          height: 6.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.white,
            border: Border.all(
              color: widget.name == ""
                  ? AppColors.white
                  : value == true
                      ? AppColors.primary
                      : AppColors.red,
            ),
          ),
          child: widget.name == ""
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 8.w,
                      child: DefaultText(
                        text: widget.name,
                        fontSize: 2.5.sp,
                        align: TextAlign.start,
                      ),
                    ),
                    BlocBuilder<ModeratorsCubit, ModeratorsState>(
                      builder: (context, state) {
                        return Switch(
                          value: value == true ? true : false,
                          activeColor: AppColors.green,
                          activeTrackColor: AppColors.lightGreen,
                          inactiveThumbColor: AppColors.red,
                          inactiveTrackColor: AppColors.lightGrey,
                          splashRadius: 3.0,
                          onChanged: (val) {
                            if (val) {
                              widget.cubit.updateAccess(
                                request: AccessRequest(
                                  id: widget.id,
                                  key: widget.columnKey,
                                  value: 1,
                                ),
                                afterSuccess: () {
                                  setState(() {
                                    value = true;
                                  });
                                },
                              );
                            } else {
                              widget.cubit.updateAccess(
                                request: AccessRequest(
                                  id: widget.id,
                                  key: widget.columnKey,
                                  value: 0,
                                ),
                                afterSuccess: () {
                                  setState(() {
                                    value = false;
                                  });
                                },
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
