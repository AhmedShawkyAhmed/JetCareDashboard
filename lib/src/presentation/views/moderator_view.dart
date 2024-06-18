import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/moderator_cubit/moderator_cubit.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/presentation/widgets/moderator_widget.dart';
import 'package:sizer/sizer.dart';

class ModeratorView extends StatefulWidget {
  final int crewId;
  final bool isMine;

  const ModeratorView({
    required this.crewId,
    required this.isMine,
    super.key,
  });

  @override
  State<ModeratorView> createState() => _ModeratorViewState();
}

class _ModeratorViewState extends State<ModeratorView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Center(
        child: Container(
          width: 50.w,
          height: 70.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 1.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 4.sp,
                      color: AppColors.grey,
                    ),
                  ),
                  const Spacer(),
                  DefaultText(
                    text: "Moderator Access",
                    fontSize: 3.sp,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 2.w,
                  ),
                ],
              ),
              SizedBox(
                child: BlocBuilder<ModeratorCubit, ModeratorState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Orders",
                              columnKey: "Orders",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .orders,
                              isMine: widget.isMine,
                            ),
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Corporates",
                              columnKey: "Corporates",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .corporates,
                              isMine: widget.isMine,
                            ),
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Clients",
                              columnKey: "Clients",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .clients,
                              isMine: widget.isMine,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Moderators",
                              columnKey: "Moderators",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .moderators,
                              isMine: widget.isMine,
                            ),
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Crews",
                              columnKey: "Crews",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .crews,
                              isMine: widget.isMine,
                            ),
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Category",
                              columnKey: "Category",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .category,
                              isMine: widget.isMine,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Offers",
                              columnKey: "Offers",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .offers,
                              isMine: widget.isMine,
                            ),
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Items",
                              columnKey: "Items",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .items,
                              isMine: widget.isMine,
                            ),
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Corporate Items",
                              columnKey: "Corporate_Items",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .corporateItems,
                              isMine: widget.isMine,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Extras Items",
                              columnKey: "Extras_Items",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .extrasItems,
                              isMine: widget.isMine,
                            ),
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Equipment",
                              columnKey: "Equipment",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .equipment,
                              isMine: widget.isMine,
                            ),
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Equipment Schedule",
                              columnKey: "Equipment_Schedule",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .equipmentSchedule,
                              isMine: widget.isMine,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Ads",
                              columnKey: "Ads",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .ads,
                              isMine: widget.isMine,
                            ),
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Governorate",
                              columnKey: "Governorate",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .governorate,
                              isMine: widget.isMine,
                            ),
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Area",
                              columnKey: "Area",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .area,
                              isMine: widget.isMine,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Periods",
                              columnKey: "Periods",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .periods,
                              isMine: widget.isMine,
                            ),
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Support",
                              columnKey: "Support",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .support,
                              isMine: widget.isMine,
                            ),
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Notifications",
                              columnKey: "Notifications",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .notifications,
                              isMine: widget.isMine,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ModeratorWidget(
                              id: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!.id,
                              name: "Info",
                              columnKey: "Info",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .info,
                              isMine: widget.isMine,
                            ),
                             ModeratorWidget(
                               id: 0,
                              name: "",
                              columnKey: "",
                              value: 0,
                               isMine: widget.isMine,
                            ),
                            ModeratorWidget(
                              id: 0,
                              name: "",
                              columnKey: "",
                              value: 0,
                              isMine: widget.isMine,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
