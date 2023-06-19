class SettingsModel {
  int id;
  int moderatorId;
  int orders;
  int corporates;
  int clients;
  int moderators;
  int crews;
  int category;
  int offers;
  int items;
  int corporateItems;
  int extrasItems;
  int ads;
  int governorate;
  int area;
  int periods;
  int support;
  int notifications;
  int info;

  SettingsModel({
    required this.id,
    required this.crews,
    required this.area,
    required this.corporateItems,
    required this.notifications,
    required this.items,
    required this.clients,
    required this.periods,
    required this.orders,
    required this.ads,
    required this.category,
    required this.corporates,
    required this.extrasItems,
    required this.governorate,
    required this.info,
    required this.moderatorId,
    required this.moderators,
    required this.offers,
    required this.support,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        id: json['id'],
        crews: json['Crews'],
        category: json['Category'],
        ads: json['Ads'],
        area: json['Area'],
        clients: json['Clients'],
        corporateItems: json['Corporate_Items'],
        corporates: json['Corporates'],
        extrasItems: json['Extras_Items'],
        governorate: json['Governorate'],
        info: json['Info'],
        items: json['Items'],
        moderatorId: json['moderatorId'],
        moderators: json['Moderators'],
        notifications: json['Notifications'],
        offers: json['Offers'],
        orders: json['Orders'],
        periods: json['Periods'],
        support: json['Support'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Crews'] = crews;
    data['Category'] = category;
    data['Ads'] = ads;
    data['Area'] = area;
    data['Clients'] = clients;
    data['Corporate_Items'] = corporateItems;
    data['Corporates'] = corporates;
    data['Extras_Items'] = extrasItems;
    data['Governorate'] = governorate;
    data['Info'] = info;
    data['Items'] = items;
    data['moderatorId'] = moderatorId;
    data['Moderators'] = moderators;
    data['Notifications'] = notifications;
    data['Offers'] = offers;
    data['Orders'] = orders;
    data['Periods'] = periods;
    data['Support'] = support;
    return data;
  }
}
