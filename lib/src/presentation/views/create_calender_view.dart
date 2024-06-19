import 'package:flutter/material.dart';
import 'package:jetboard/src/business_logic/calender_cubit/calender_cubit.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/data/models/calender_model.dart';
import 'package:jetboard/src/data/network/requests/calender_request.dart';
import 'package:jetboard/src/features/periods/data/models/period_model.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/shared/views/indicator_view.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';
import 'package:sizer/sizer.dart';

import '../../data/models/area_model.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import '../../core/shared/widgets/default_dropdown.dart';
import '../../core/shared/widgets/default_text.dart';

class CreateCalenderView extends StatefulWidget {
  final CalenderModel calenderModel;
  final List<PeriodModel> periods;
  final List<AreaModel> areas;

  const CreateCalenderView({
    required this.calenderModel,
    required this.periods,
    required this.areas,
    super.key,
  });

  @override
  State<CreateCalenderView> createState() => _CreateCalenderViewState();
}

class _CreateCalenderViewState extends State<CreateCalenderView> {
  PeriodModel periodModel = PeriodModel();
  AreaModel areaModel = AreaModel();
  List<int> periodsIds = [];
  TextEditingController areaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Center(
        child: Container(
          width: 400.w,
          height: 700.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              const DefaultText(
                text: "Create New Calender",
                align: TextAlign.center,
              ),
              SizedBox(
                height: 30.h,
              ),
              DefaultText(
                text: widget.calenderModel.date.toString(),
                align: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: SizedBox(
                  width: 350.w,
                  child: DefaultDropdown<PeriodModel>(
                    hint: "Period",
                    showSearchBox: true,
                    itemAsString: (PeriodModel? u) => "${u?.from} - ${u?.to}",
                    items: widget.periods,
                    onChanged: (val) {
                      setState(() {
                        periodModel = val!;
                        printLog(widget.calenderModel.periods!.indexWhere((element) => element.id == periodModel.id).toString());
                        if (widget.calenderModel.periods!.indexWhere((element) => element.id == periodModel.id) != -1) {
                          DefaultToast.showMyToast("You Can't Add The Same Period Twice");
                        } else {
                          widget.calenderModel.periods!.add(periodModel);
                          periodsIds.add(val.id!);
                          printLog(val.toJson().toString());
                        }
                      });
                    },
                  ),
                ),
              ),
              if (widget.calenderModel.periods!.isNotEmpty &&
                  widget.calenderModel.areas!.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: DefaultTextField(
                    width: 350.w,
                    height: 60.h,
                    controller: areaController,
                    password: false,
                    haveShadow: false,
                    enabled: false,
                    textAlign: TextAlign.center,
                    hintColor: AppColors.primary,
                    hintText: widget.calenderModel.areas![0].nameAr,
                  ),
                )
              ] else ...[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: SizedBox(
                    width: 350.w,
                    child: DefaultDropdown<AreaModel>(
                      hint: "Area",
                      showSearchBox: true,
                      itemAsString: (AreaModel? u) => u?.nameAr ?? "",
                      items: widget.areas,
                      onChanged: (val) {
                        setState(() {
                          areaModel = val!;
                          printLog(val.toJson().toString());
                        });
                      },
                    ),
                  ),
                ),
              ],
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: RowData(
                  rowHeight: 300.h,
                  data: [
                    SizedBox(
                      height: 300.h,
                      width: 300.w,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        itemCount: widget.calenderModel.periods?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: RowData(
                              rowHeight: 50.h,
                              rowWidth: 300.w,
                              data: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "${widget.calenderModel.periods?[index].from} -  ${widget.calenderModel.periods?[index].to}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      Iterable<int> myListFiltered =
                                          periodsIds.where((e) =>
                                              e ==
                                              widget.calenderModel
                                                  .periods?[index].id);
                                      printLog(myListFiltered
                                          .toList()
                                          .isNotEmpty
                                          .toString());
                                      if (myListFiltered.toList().isNotEmpty) {
                                        setState(() {
                                          periodsIds.remove(
                                              myListFiltered.toList().first);
                                          widget.calenderModel.periods!
                                              .removeAt(index);
                                        });
                                      } else {
                                        CalenderCubit.get(context)
                                            .deleteCalenderPeriod(
                                          id: widget.calenderModel
                                              .periods![index].relationId!,
                                          afterSuccess: () {
                                            setState(() {
                                              widget.calenderModel.periods!
                                                  .removeAt(index);
                                            });
                                          },
                                        );
                                      }
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: AppColors.darkRed,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DefaultAppButton(
                    width: 150.w,
                    height: 40.h,
                    radius: 10,
                    fontSize: 20.sp,
                    title: "Save",
                    onTap: () {
                      IndicatorView.showIndicator();
                      CalenderCubit.get(context).createCalenderPeriod(
                        calenderRequest: CalenderRequest(
                          areaId: widget.calenderModel.areas!.isNotEmpty
                              ? widget.calenderModel.areas![0].id!
                              : areaModel.id!,
                          periodId: periodsIds,
                          calenderId: widget.calenderModel.id!,
                        ),
                        afterSuccess: () {
                          widget.calenderModel.areas!.add(areaModel);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      );
                    },
                    buttonColor: AppColors.primary,
                    isGradient: false,
                  ),
                  DefaultAppButton(
                    width: 150.w,
                    height: 40.h,
                    radius: 10,
                    fontSize: 20.sp,
                    title: "Cancel",
                    onTap: () {
                      periodsIds.clear();
                      Navigator.pop(context);
                    },
                    isGradient: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
