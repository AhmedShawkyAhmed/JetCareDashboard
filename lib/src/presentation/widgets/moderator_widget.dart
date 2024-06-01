import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/moderator_cubit/moderator_cubit.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

class ModeratorWidget extends StatefulWidget {
  final int id;
  final String name;
  final String columnKey;
  final bool isMine;
  int value = 0;

  ModeratorWidget({
    required this.id,
    required this.name,
    required this.columnKey,
    required this.value,
    required this.isMine,
    Key? key,
  }) : super(key: key);

  @override
  State<ModeratorWidget> createState() => _ModeratorWidgetState();
}

class _ModeratorWidgetState extends State<ModeratorWidget> {
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
              color: widget.name == "" ? AppColors.white : widget.value == 1?AppColors.primary:AppColors.red,
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
                        align: widget.isMine == false?TextAlign.start:TextAlign.center,
                      ),
                    ),
                    if(widget.isMine == false)
                    BlocBuilder<ModeratorCubit, ModeratorState>(
                      builder: (context, state) {
                        return Switch(
                          value: widget.value == 1 ? true : false,
                          activeColor: AppColors.green,
                          activeTrackColor: AppColors.lightGreen,
                          inactiveThumbColor: AppColors.red,
                          inactiveTrackColor: AppColors.lightGrey,
                          splashRadius: 3.0,
                          onChanged: (value) {
                            if (value) {
                              ModeratorCubit.get(context).updateAccess(
                                key: widget.columnKey,
                                value: 1,
                                id: widget.id,
                                afterSuccess: () {
                                  setState(() {
                                    widget.value = 1;
                                  });
                                },
                              );
                            } else {
                              ModeratorCubit.get(context).updateAccess(
                                key: widget.columnKey,
                                value: 0,
                                id: widget.id,
                                afterSuccess: () {
                                  setState(() {
                                    widget.value = 0;
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
