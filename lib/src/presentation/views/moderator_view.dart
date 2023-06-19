import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/moderator_cubit/moderator_cubit.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:jetboard/src/presentation/widgets/moderator_widget.dart';
import 'package:sizer/sizer.dart';

class ModeratorView extends StatefulWidget {
  final int crewId;

  const ModeratorView({
    required this.crewId,
    Key? key,
  }) : super(key: key);

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
                  InkWell(
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
                            ),
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
                              name: "Area",
                              columnKey: "Area",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .area,
                            ),
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
                              name: "Notifications",
                              columnKey: "Notifications",
                              value: ModeratorCubit.get(context)
                                  .accessResponse!
                                  .settings!
                                  .notifications,
                            ),
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
                            ),
                             ModeratorWidget(
                               id: 0,
                              name: "",
                              columnKey: "",
                              value: 0,
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
