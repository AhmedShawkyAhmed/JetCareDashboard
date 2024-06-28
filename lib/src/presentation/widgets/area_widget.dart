// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:jetboard/src/business_logic/crew_cubit/crew_cubit.dart';
// import 'package:jetboard/src/core/resources/app_colors.dart';
// import 'package:jetboard/src/features/areas/data/models/area_model.dart';
// import 'package:jetboard/src/core/shared/widgets/default_text.dart';
// import 'package:sizer/sizer.dart';
//
// class AreaWidget extends StatefulWidget {
//   final AreaModel area;
//   final int crewId;
//
//   const AreaWidget({
//     required this.area,
//     required this.crewId,
//     super.key,
//   });
//
//   @override
//   State<AreaWidget> createState() => _AreaWidgetState();
// }
//
// class _AreaWidgetState extends State<AreaWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           width: 20.w,
//           height: 6.h,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: AppColors.white,
//             border: Border.all(
//               color: AppColors.primary,
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               DefaultText(text: widget.area.nameAr!, fontSize: 3.sp),
//               BlocBuilder<CrewCubit, CrewState>(
//                 builder: (context, state) {
//                   return Switch(
//                     value:
//                         CrewCubit.get(context).areaIds.contains(widget.area.id)
//                             ? true
//                             : false,
//                     activeColor: AppColors.green,
//                     activeTrackColor: AppColors.lightGreen,
//                     inactiveThumbColor: AppColors.red,
//                     inactiveTrackColor: AppColors.lightGrey,
//                     splashRadius: 3.0,
//                     onChanged: (value) {
//                       if (CrewCubit.get(context)
//                           .areaIds
//                           .contains(widget.area.id)) {
//                         CrewCubit.get(context).deleteArea(
//                           id: CrewCubit.get(context).crewAreasIds[
//                               CrewCubit.get(context)
//                                   .areaIds
//                                   .indexOf(widget.area.id!)],
//                           afterSuccess: () {
//                             setState(() {
//                               CrewCubit.get(context).crewAreasIds.remove(
//                                   CrewCubit.get(context).crewAreasIds[
//                                       CrewCubit.get(context)
//                                           .areaIds
//                                           .indexOf(widget.area.id!)]);
//                               CrewCubit.get(context)
//                                   .areaIds
//                                   .remove(widget.area.id);
//                             });
//                           },
//                         );
//                       } else {
//                         CrewCubit.get(context).addArea(
//                           crewId: widget.crewId,
//                           areaId: widget.area.id!,
//                           afterSuccess: () {
//                             setState(() {
//                               CrewCubit.get(context)
//                                   .areaIds
//                                   .insert(0, widget.area.id!);
//                             });
//                           },
//                         );
//                       }
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
