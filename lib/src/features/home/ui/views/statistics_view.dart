import 'package:flutter/material.dart';
import 'package:jetboard/src/features/home/data/models/orders_statistics_model.dart';
import 'package:jetboard/src/features/home/ui/views/home_card.dart';
import 'package:jetboard/src/features/home/ui/widgets/circular_item.dart';
import 'package:sizer/sizer.dart';

class StatisticsView extends StatelessWidget {
  final OrdersStatisticsModel orders;

  const StatisticsView({
    required this.orders,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      cWidth: 78.w,
      title: "Orders",
      total: 1,
      percent: 1,
      percent2: 1,
      widget: Padding(
        padding: EdgeInsets.only(
          left: 1.w,
          right: 1.w,
          top: 1.h,
          bottom: 1.h,
        ),
        child: Center(
          child: Wrap(
            spacing: 1.w,
            runSpacing: 2.h,
            children: [
              CircularItem(
                percent: orders.completed ?? 0,
                count: orders.count ?? 1,
                title: "Completed",
                color: Colors.green,
              ),
              CircularItem(
                percent: orders.accepted ?? 0,
                count: orders.count ?? 1,
                title: "Accepted",
                color: Colors.blueAccent,
              ),
              CircularItem(
                percent: orders.confirmed ?? 0,
                count: orders.count ?? 1,
                title: "Confirmed",
                color: Colors.teal,
              ),
              CircularItem(
                percent: orders.assigned ?? 0,
                count: orders.count ?? 1,
                title: "Assigned",
                color: Colors.cyan,
              ),
              CircularItem(
                percent: orders.unassigned ?? 0,
                count: orders.count ?? 1,
                title: "Not Assigned",
                color: Colors.black38,
              ),
              CircularItem(
                percent: orders.rejected ?? 0,
                count: orders.count ?? 1,
                title: "Rejected",
                color: Colors.orange,
              ),
              CircularItem(
                percent: orders.canceled ?? 0,
                count: orders.count ?? 1,
                title: "Canceled",
                color: Colors.red,
              ),
              CircularItem(
                percent: orders.corporate ?? 0,
                count: orders.count ?? 1,
                title: "Corporate",
                color: Colors.purple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
