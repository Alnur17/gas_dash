class MySubscriptionVehicleModel {
  MySubscriptionVehicleModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<SubscriptionVehicleDatum> data;

  factory MySubscriptionVehicleModel.fromJson(Map<String, dynamic> json){
    return MySubscriptionVehicleModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<SubscriptionVehicleDatum>.from(json["data"]!.map((x) => SubscriptionVehicleDatum.fromJson(x))),
    );
  }

}

class SubscriptionVehicleDatum {
  SubscriptionVehicleDatum({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.fuelLevel,
    required this.userId,
    required this.isCoveredBySubscription,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? make;
  final String? model;
  final int? year;
  final int? fuelLevel;
  final UserId? userId;
  final bool? isCoveredBySubscription;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory SubscriptionVehicleDatum.fromJson(Map<String, dynamic> json){
    return SubscriptionVehicleDatum(
      id: json["_id"],
      make: json["make"],
      model: json["model"],
      year: json["year"],
      fuelLevel: json["fuelLevel"],
      userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
      isCoveredBySubscription: json["isCoveredBySubscription"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class UserId {
  UserId({
    required this.verification,
    required this.id,
    required this.status,
    required this.fullname,
    required this.location,
    required this.country,
    required this.zipCode,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.gender,
    required this.dateOfBirth,
    required this.isGoogleLogin,
    required this.image,
    required this.role,
    required this.totalEarning,
    required this.experience,
    required this.address,
    required this.freeDeliverylimit,
    required this.coverVehiclelimit,
    required this.durationDay,
    required this.isDeleted,
    required this.popularity,
    required this.fiftyPercentOffDeliveryFeeAfterWaivedTrips,
    required this.scheduledDelivery,
    required this.fuelPriceTrackingAlerts,
    required this.noExtraChargeForEmergencyFuelServiceLimit,
    required this.freeSubscriptionAdditionalFamilyMember,
    required this.exclusivePromotionsEarlyAccess,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.title,
  });

  final Verification? verification;
  final String? id;
  final String? status;
  final String? fullname;
  final String? location;
  final String? country;
  final String? zipCode;
  final String? email;
  final dynamic phoneNumber;
  final String? password;
  final dynamic gender;
  final dynamic dateOfBirth;
  final bool? isGoogleLogin;
  final dynamic image;
  final String? role;
  final int? totalEarning;
  final int? experience;
  final dynamic address;
  final int? freeDeliverylimit;
  final int? coverVehiclelimit;
  final int? durationDay;
  final bool? isDeleted;
  final int? popularity;
  final bool? fiftyPercentOffDeliveryFeeAfterWaivedTrips;
  final bool? scheduledDelivery;
  final bool? fuelPriceTrackingAlerts;
  final bool? noExtraChargeForEmergencyFuelServiceLimit;
  final bool? freeSubscriptionAdditionalFamilyMember;
  final bool? exclusivePromotionsEarlyAccess;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? title;

  factory UserId.fromJson(Map<String, dynamic> json){
    return UserId(
      verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
      id: json["_id"],
      status: json["status"],
      fullname: json["fullname"],
      location: json["location"],
      country: json["country"],
      zipCode: json["zipCode"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      password: json["password"],
      gender: json["gender"],
      dateOfBirth: json["dateOfBirth"],
      isGoogleLogin: json["isGoogleLogin"],
      image: json["image"],
      role: json["role"],
      totalEarning: json["totalEarning"],
      experience: json["experience"],
      address: json["address"],
      freeDeliverylimit: json["freeDeliverylimit"],
      coverVehiclelimit: json["coverVehiclelimit"],
      durationDay: json["durationDay"],
      isDeleted: json["isDeleted"],
      popularity: json["popularity"],
      fiftyPercentOffDeliveryFeeAfterWaivedTrips: json["fiftyPercentOffDeliveryFeeAfterWaivedTrips"],
      scheduledDelivery: json["scheduledDelivery"],
      fuelPriceTrackingAlerts: json["fuelPriceTrackingAlerts"],
      noExtraChargeForEmergencyFuelServiceLimit: json["noExtraChargeForEmergencyFuelServiceLimit"],
      freeSubscriptionAdditionalFamilyMember: json["freeSubscriptionAdditionalFamilyMember"],
      exclusivePromotionsEarlyAccess: json["exclusivePromotionsEarlyAccess"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      title: json["title"],
    );
  }

}

class Verification {
  Verification({
    required this.otp,
    required this.expiresAt,
    required this.status,
  });

  final int? otp;
  final DateTime? expiresAt;
  final bool? status;

  factory Verification.fromJson(Map<String, dynamic> json){
    return Verification(
      otp: json["otp"],
      expiresAt: DateTime.tryParse(json["expiresAt"] ?? ""),
      status: json["status"],
    );
  }

}
