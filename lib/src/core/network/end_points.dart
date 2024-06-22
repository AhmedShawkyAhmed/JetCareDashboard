
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
  static const tabAccess = "get_access";
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







  static const adminLogin = "adminLogin";
  static const register = "register";
  static const updateAccount = "updateAccount";
  static const deleteAccount = "deleteAccount";
  static const changeAccountStatus = "changeAccountStatus";
  static const getAccounts = "getAccounts";

  static const userAdminComment = "userAdminComment";

  static const addItem = "addItem";
  static const updateItem = "updateItem";
  static const changeItemStatus = "changeItemStatus";
  static const deleteItem = "deleteItem";
  static const getItems = "getItems";
  static const getExtras = "getExtras";

  static const addPackage = "addPackage";
  static const addPackageItem = "addPackageItem";
  static const updatePackage = "updatePackage";
  static const deletePackage = "deletePackage";
  static const deletePackageItem = "deletePackageItem";
  static const deletePackageInfo = "deletePackageInfo";
  static const changePackageStatus = "changePackageStatus";
  static const getAllPackages = "getAllPackages";
  static const getPackagesMobile = "getPackagesMobile";
  static const getPackageDetails = "getPackageDetails";
  static const getItemsMobile = "getItemsMobile";
  static const getCorporates = "getCorporates";
  static const addCorporateOrder = "addCorporateOrder";
  static const addToCart = "addToCart";

  static const getDates = "getDates";
  static const addDate = "addDate";
  static const deleteDate = "deleteDate";
  static const updateDate = "updateDate";

  static const getCorporateOrders = "getCorporateOrders";
  static const readCorporate = "readCorporate";
  static const corporateAdminComment = "corporateAdminComment";

  static const addCategory = "addCategory";
  static const getCategories = "getCategories";
  static const getCategoryDetails = "getCategoryDetails";
  static const updateCategory = "updateCategory";
  static const deleteCategory = "deleteCategory";
  static const changeCategoryStatus = "changeCategoryStatus";
  static const addCategoryPackage = "addCategoryPackage";
  static const deleteCategoryPackage = "deleteCategorySub";
  static const addCategoryItem = "addCategoryItem";
  static const deleteCategorySub = "deleteCategorySub";

  static const createCalenderPeriod = "createCalenderPeriod";
  static const deleteCalenderPeriod = "deleteCalenderPeriod";
  static const getCalender = "getCalender";

  static const getSpaces = "getSpaces";
  static const addSpace = "addSpace";
  static const updateSpace = "updateSpace";
  static const deleteSpace = "deleteSpace";
  static const changeSpaceStatus = "changeSpaceStatus";

  static const getOrders = "getOrders";
  static const assignOrder = "assignOrder";
  static const deleteOrder = "deleteOrder";
  static const updateOrderStatus = "updateOrderStatus";
  static const updateAdminComment = "updateAdminComment";
  static const createOrder = "createOrder";
  static const updateExtra = "updateExtra";

  static const getMyAddresses = "getMyAddresses";
  static const addAddress = "addAddress";

  static const addAreaToCrew = "addAreaToCrew";
  static const deleteCrewArea = "deleteCrewArea";
  static const getCrewAreas = "getCrewAreas";
  static const getCrewOfAreas = "getCrewOfAreas";

  static const addEquipment = "addEquipment";
  static const deleteEquipment = "deleteEquipment";
  static const getEquipment = "getEquipment";
  static const getEquipmentSchedule = "getEquipmentSchedule";
  static const returnDate = "returnDate";
  static const assignEquipment = "assignEquipment";

  static const createAccess = "createAccess";
  static const updateAccess = "updateAccess";
  static const getAccess = "getAccess";
}
