import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/features/areas/cubit/areas_cubit.dart';
import 'package:jetboard/src/features/clients/cubit/clients_cubit.dart';
import 'package:jetboard/src/features/items/cubit/items_cubit.dart';
import 'package:jetboard/src/features/orders/cubit/orders_cubit.dart';
import 'package:jetboard/src/features/orders/ui/views/create_order_view.dart';
import 'package:jetboard/src/features/packages/cubit/packages_cubit.dart';
import 'package:jetboard/src/features/periods/cubit/period_cubit.dart';
import 'package:sizer/sizer.dart';

class CreateOrder extends StatefulWidget {
  final OrdersCubit cubit;

  const CreateOrder({
    required this.cubit,
    super.key,
  });

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  ClientsCubit clientsCubit = ClientsCubit(instance());
  AreasCubit areasCubit = AreasCubit(instance());
  PeriodCubit periodCubit = PeriodCubit(instance());
  ItemsCubit itemsCubit = ItemsCubit(instance());
  PackagesCubit packagesCubit = PackagesCubit(instance());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => clientsCubit..getClients(),
        ),
        BlocProvider(
          create: (context) => areasCubit..getAllStates(),
        ),
        BlocProvider(
          create: (context) => periodCubit..getPeriods(),
        ),
        BlocProvider(
          create: (context) => itemsCubit..getItems(),
        ),
        BlocProvider(
          create: (context) => packagesCubit..getPackages(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Center(
          child: Container(
            width: 70.w,
            height: 75.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                const DefaultText(
                  text: "Create New Order",
                  align: TextAlign.center,
                ),
                SizedBox(
                  height: 2.h,
                ),
                CreateOrderView(
                  ordersCubit: widget.cubit,
                  clientsCubit: clientsCubit,
                  areasCubit: areasCubit,
                  itemsCubit: itemsCubit,
                  packagesCubit: packagesCubit,
                  periodCubit: periodCubit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
