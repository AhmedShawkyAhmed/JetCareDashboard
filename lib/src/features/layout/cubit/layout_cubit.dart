import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/utils/enums.dart';
import 'package:jetboard/src/features/ads/ui/screens/ads.dart';
import 'package:jetboard/src/features/areas/ui/screens/areas.dart';
import 'package:jetboard/src/features/auth/ui/screens/login.dart';
import 'package:jetboard/src/features/calendar/ui/screens/calender.dart';
import 'package:jetboard/src/features/categories/ui/screens/category.dart';
import 'package:jetboard/src/features/clients/ui/screens/clients.dart';
import 'package:jetboard/src/features/corporate/ui/screens/corporates.dart';
import 'package:jetboard/src/features/crew/ui/screens/crew.dart';
import 'package:jetboard/src/features/equipment_schedule/ui/screens/equipment_schedule.dart';
import 'package:jetboard/src/features/equipments/ui/screens/equipment.dart';
import 'package:jetboard/src/features/home/ui/screens/home.dart';
import 'package:jetboard/src/features/info/ui/screens/info.dart';
import 'package:jetboard/src/features/items/ui/screens/items.dart';
import 'package:jetboard/src/features/layout/data/models/home_item_model.dart';
import 'package:jetboard/src/features/moderators/ui/screens/moderators.dart';
import 'package:jetboard/src/features/notifications/ui/screens/notifications.dart';
import 'package:jetboard/src/features/orders/ui/screens/orders.dart';
import 'package:jetboard/src/features/packages/ui/screens/packages.dart';
import 'package:jetboard/src/features/periods/ui/screens/periods.dart';
import 'package:jetboard/src/features/states/ui/screens/states.dart';
import 'package:jetboard/src/features/support/ui/screens/support.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  int selectedIndex = 0;

  List<HomeItemModel> items = [
    HomeItemModel(
      title: "Home",
      page: const Home(),
      icon: const Icon(
        Icons.home,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Orders",
      page: const Orders(),
      icon: const Icon(
        Icons.badge_sharp,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Corporates",
      page: const Corporates(),
      icon: const Icon(
        Icons.corporate_fare,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Clients",
      page: const Users(),
      icon: const Icon(
        Icons.person,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Moderators",
      page: const Moderators(),
      icon: const Icon(
        Icons.manage_accounts,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Crews",
      page: const Crew(),
      icon: const Icon(
        Icons.perm_contact_cal_sharp,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Calender",
      page: const Calender(),
      icon: const Icon(
        Icons.calculate_outlined,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Category",
      page: const Category(),
      icon: const Icon(
        Icons.category_outlined,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Packages",
      page: const Packages(),
      icon: const Icon(
        Icons.local_offer_outlined,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Items",
      page: const Items(type: ItemTypes.item),
      icon: const Icon(
        Icons.list,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Corporate Items",
      page: const Items(type: ItemTypes.corporate),
      icon: const Icon(
        Icons.list_alt,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Extras Items",
      page: const Items(type: ItemTypes.extra),
      icon: const Icon(
        Icons.add_chart_rounded,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Equipment",
      page: const Equipment(),
      icon: const Icon(
        Icons.trolley,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Equipment Schedule",
      page: const EquipmentSchedule(),
      icon: const Icon(
        Icons.schedule_outlined,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Ads",
      page: const Ads(),
      icon: const Icon(
        Icons.ads_click_outlined,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Governorate",
      page: const States(),
      icon: const Icon(
        Icons.map_outlined,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Area",
      page: const Area(),
      icon: const Icon(
        Icons.area_chart_outlined,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Periods",
      page: const Periods(),
      icon: const Icon(
        Icons.timer_outlined,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Support",
      page: const Support(),
      icon: const Icon(
        Icons.support_agent,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Notifications",
      page: const Notifications(),
      icon: const Icon(
        Icons.notification_important_outlined,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Info",
      page: const Info(),
      icon: const Icon(
        Icons.info_outline,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Logout",
      page: const Login(),
      icon: const Icon(
        Icons.logout_outlined,
        color: AppColors.white,
      ),
    ),
  ];

  void changeIndex(int index) {
    selectedIndex = index;
    emit(AppChangeSideNavBarState());
  }
}
