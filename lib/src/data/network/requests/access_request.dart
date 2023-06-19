class AccessRequest {
  int? id;
  int? moderatorId;
  int? orders;
  int? corporates;
  int? clients;
  int? moderators;
  int? crews;
  int? category;
  int? offers;
  int? items;
  int? corporateItems;
  int? extrasItems;
  int? ads;
  int? governorate;
  int? area;
  int? periods;
  int? support;
  int? notifications;
  int? info;

  AccessRequest({
    this.id,
    this.crews,
    this.area,
    this.corporateItems,
    this.notifications,
    this.items,
    this.clients,
    this.periods,
    this.orders,
    this.ads,
    this.category,
    this.corporates,
    this.extrasItems,
    this.governorate,
    this.info,
    this.moderatorId,
    this.moderators,
    this.offers,
    this.support,
  });
}
