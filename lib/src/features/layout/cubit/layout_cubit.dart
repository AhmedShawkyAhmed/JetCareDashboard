import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/features/auth/ui/screens/login.dart';
import 'package:jetboard/src/features/layout/data/models/home_item_model.dart';
import 'package:jetboard/src/presentation/screens/ads/ads.dart';
import 'package:jetboard/src/presentation/screens/areas/areas.dart';
import 'package:jetboard/src/presentation/screens/calender/calender.dart';
import 'package:jetboard/src/presentation/screens/category/category.dart';
import 'package:jetboard/src/presentation/screens/clients/clients.dart';
import 'package:jetboard/src/presentation/screens/corporate_items/corporate_items.dart';
import 'package:jetboard/src/presentation/screens/corporates/corporates.dart';
import 'package:jetboard/src/presentation/screens/crews/crews.dart';
import 'package:jetboard/src/presentation/screens/equipment/equipment.dart';
import 'package:jetboard/src/presentation/screens/equipment_schedule/equipment_schedule.dart';
import 'package:jetboard/src/presentation/screens/extras/extras.dart';
import 'package:jetboard/src/presentation/screens/governorate/governorate.dart';
import 'package:jetboard/src/features/home/ui/screens/home.dart';
import 'package:jetboard/src/presentation/screens/info/info.dart';
import 'package:jetboard/src/presentation/screens/items/items.dart';
import 'package:jetboard/src/presentation/screens/moderators/moderators.dart';
import 'package:jetboard/src/presentation/screens/notifications/notifications.dart';
import 'package:jetboard/src/presentation/screens/orders/orders.dart';
import 'package:jetboard/src/presentation/screens/packages/packages.dart';
import 'package:jetboard/src/presentation/screens/periods/periods.dart';
import 'package:jetboard/src/presentation/screens/support/support.dart';

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
      page: const Crews(),
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
      page: const Items(),
      icon: const Icon(
        Icons.list,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Corporate Items",
      page: const CorporateItems(),
      icon: const Icon(
        Icons.list_alt,
        color: AppColors.white,
      ),
    ),
    HomeItemModel(
      title: "Extras Items",
      page: const ExtrasItems(),
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
      page: const Governorate(),
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
