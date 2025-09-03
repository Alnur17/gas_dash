class SubscriptionPackageModel {
  SubscriptionPackageModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory SubscriptionPackageModel.fromJson(Map<String, dynamic> json){
    return SubscriptionPackageModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.data,
    required this.meta,
  });

  final List<Datum> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.shortDescription,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.popularity,
    required this.durationType,
    required this.isDeleted,
    required this.freeDeliverylimit,
    required this.coverVehiclelimit,
    required this.fiftyPercentOffDeliveryFeeAfterWaivedTrips,
    required this.scheduledDelivery,
    required this.fuelPriceTrackingAlerts,
    required this.noExtraChargeForEmergencyFuelServiceLimit,
    required this.freeSubscriptionAdditionalFamilyMember,
    required this.exclusivePromotionsEarlyAccess,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? title;
  final String? shortTitle;
  final String? shortDescription;
  final double? monthlyPrice;
  final double? yearlyPrice;
  final double? popularity;
  final String? durationType;
  final bool? isDeleted;
  final double? freeDeliverylimit;
  final double? coverVehiclelimit;
  final bool? fiftyPercentOffDeliveryFeeAfterWaivedTrips;
  final bool? scheduledDelivery;
  final bool? fuelPriceTrackingAlerts;
  final bool? noExtraChargeForEmergencyFuelServiceLimit;
  final bool? freeSubscriptionAdditionalFamilyMember;
  final bool? exclusivePromotionsEarlyAccess;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      title: json["title"],
      shortTitle: json["shortTitle"],
      shortDescription: json["shortDescription"],
      monthlyPrice: (json["monthlyPrice"] is int)
          ? (json["monthlyPrice"] as int).toDouble()
          : json["monthlyPrice"]?.toDouble(),
      yearlyPrice: (json["yearlyPrice"] is int)
          ? (json["yearlyPrice"] as int).toDouble()
          : json["yearlyPrice"]?.toDouble(),
      popularity: (json["popularity"] is int)
          ? (json["popularity"] as int).toDouble()
          : json["popularity"]?.toDouble(),
      durationType: json["durationType"],
      isDeleted: json["isDeleted"],
      freeDeliverylimit: (json["freeDeliverylimit"] is int)
          ? (json["freeDeliverylimit"] as int).toDouble()
          : json["freeDeliverylimit"]?.toDouble(),
      coverVehiclelimit: (json["coverVehiclelimit"] is int)
          ? (json["coverVehiclelimit"] as int).toDouble()
          : json["coverVehiclelimit"]?.toDouble(),
      fiftyPercentOffDeliveryFeeAfterWaivedTrips: json["fiftyPercentOffDeliveryFeeAfterWaivedTrips"],
      scheduledDelivery: json["scheduledDelivery"],
      fuelPriceTrackingAlerts: json["fuelPriceTrackingAlerts"],
      noExtraChargeForEmergencyFuelServiceLimit: json["noExtraChargeForEmergencyFuelServiceLimit"],
      freeSubscriptionAdditionalFamilyMember: json["freeSubscriptionAdditionalFamilyMember"],
      exclusivePromotionsEarlyAccess: json["exclusivePromotionsEarlyAccess"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }
}

class Meta {
  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  final double? page;
  final double? limit;
  final double? total;
  final double? totalPage;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      page: (json["page"] is int)
          ? (json["page"] as int).toDouble()
          : json["page"]?.toDouble(),
      limit: (json["limit"] is int)
          ? (json["limit"] as int).toDouble()
          : json["limit"]?.toDouble(),
      total: (json["total"] is int)
          ? (json["total"] as int).toDouble()
          : json["total"]?.toDouble(),
      totalPage: (json["totalPage"] is int)
          ? (json["totalPage"] as int).toDouble()
          : json["totalPage"]?.toDouble(),
    );
  }
}