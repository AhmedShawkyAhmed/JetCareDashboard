
import 'package:jetboard/src/core/utils/enums.dart';

class EndPoints {
  static const Environment environment = Environment.development;
  static const baseUrl = "https://api.jetcareeg.net/api/";
  static const imageDomain = "https://api.jetcareeg.net/public/images/";

  // -------------------------- New API
  // ------------------- Auth
  static const login = "dashboard/login";
  static const updateFCM = "update_fcm";
  static const profile = "profile";
  static const getMyAccess = "get_my_access";
  static const logout = "logout";

  // ------------------- Home
  static const getStatistics = "get_statistics";

  // ------------------- Support
  static const getSupport = "get_support";
  static const deleteSupport = "delete_support";
  static const supportComment = "support_comment";

  // ------------------- Period
  static const getPeriods = "get_periods";
  static const addPeriod = "add_period";
  static const updatePeriod = "update_period";
  static const deletePeriod = "delete_period";
  static const changePeriodStatus = "change_period_status";

  // ------------------- Ads
  static const getAds = "get_ads";
  static const addAds = "add_ads";
  static const updateAds = "update_ads";
  static const deleteAds = "delete_ads";
  static const changeAdStatus = "change_ad_status";

  // ------------------- Notifications
  static const getNotifications = "get_notifications";
  static const notifyUser = "notify_user";
  static const notifyAll = "notify_all";
  static const saveNotification = "save_notification";

  // ------------------- Notifications
  static const addInfo = "add_info";
  static const updateInfo = "update_info";
  static const deleteInfo = "delete_info";
  static const getInfo = "get_info";
  static const getTypes = "get_types";
  static const getUnit = "get_unit";
  static const getRole = "get_role";
  static const getCategory = "get_category";
  static const getItemsTypes = "get_items_types";

  // ------------------- Areas
  static const getAllAreas = "get_all_areas";
  static const getAreasOfState = "get_areas_of_state";
  static const addArea = "add_area";
  static const updateArea = "update_area";
  static const deleteArea = "delete_area";
  static const changeAreaStatus = "change_area_status";

  // ------------------- States
  static const getAllStates = "get_all_states";
  static const addState = "add_state";
  static const updateState = "update_state";
  static const deleteState = "delete_state";
  static const changeStateStatus = "change_state_status";

  // ------------------- Calendar
  static const getCalendar = "get_calendar";
  static const addCalendarPeriod = "add_calendar_period";
  static const deleteCalendarPeriod = "delete_calendar_period";

  // ------------------- Shared Clients - Crews - Moderators
  static const register = "register";
  static const activateAccount = "activate_account";
  static const stopAccount = "stop_account";
  static const deleteAccount = "delete_account";
  static const updateAccount = "update_account";
  static const userAdminComment = "user_admin_comment";

  // ------------------- Clients
  static const getClients = "get_clients";
  static const getMyAddresses = "get_my_addresses";
  static const addAddress = "add_address";
  static const getStates = "get_states_mobile";

  // ------------------- Crew
  static const getCrew = "get_crew";
  static const addAreaToCrew = "add_area_to_crew";
  static const deleteCrewArea = "delete_crew_area";
  static const getCrewAreas = "get_crew_areas";
  static const getCrewOfAreas = "get_crew_of_areas";

  // ------------------- Moderators
  static const getModerators = "get_moderators";
  static const createAccess = "create_access";
  static const updateAccess = "update_access";
  static const getTabAccess = "get_access";

  // ------------------- Equipments
  static const getEquipment = "get_equipment";
  static const addEquipment = "add_equipment";
  static const deleteEquipment = "delete_equipment";

  // ------------------- Equipments Schedule
  static const getEquipmentSchedule = "get_equipment_schedule";
  static const assignEquipment = "assign_equipment";
  static const returnEquipment = "return_equipment";

  // ------------------- Items
  static const getItems = "get_items";
  static const getCorporates = "get_corporates";
  static const getExtras = "get_extras";
  static const addItem = "add_item";
  static const updateItem = "update_item";
  static const changeItemStatus = "change_item_status";
  static const deleteItem = "delete_item";

  // ------------------- Corporate
  static const getCorporateOrders = "get_corporate_orders";
  static const addCorporateOrder = "add_corporate_order";
  static const corporateAdminComment = "corporate_admin_comment";
  static const contactCorporate = "contact_corporate";

  // ------------------- Packages
  static const getAllPackages = "get_all_packages";
  static const getPackageDetails = "get_package_details";
  static const addPackage = "add_package";
  static const updatePackage = "update_package";
  static const changePackageStatus = "change_package_status";
  static const deletePackage = "delete_package";
  static const addPackageItem = "add_package_item";
  static const deletePackageItem = "delete_package_item";

  // ------------------- Categories
  static const getCategories = "get_categories";
  static const getCategoryDetails = "get_category_details";
  static const addCategory = "add_category";
  static const updateCategory = "update_category";
  static const deleteCategory = "delete_category";
  static const changeCategoryStatus = "change_category_status";
  static const addCategoryPackage = "add_category_package";
  static const addCategoryItem = "add_category_item";
  static const deleteCategorySub = "delete_category_sub";

  // ------------------- Orders
  static const getOrders = "get_orders";
  static const createOrder = "create_order";
  static const updateOrderStatus = "update_order_status";
  static const updateAdminComment = "update_admin_comment";
  static const assignOrder = "assign_order";
  static const addExtraFees = "add_extra_fees";
  static const addToCart = "add_to_cart";
  static const deleteOrder = "delete_order";







  static const getAccounts = "getAccounts";

  static const updateExtra = "updateExtra";

}
