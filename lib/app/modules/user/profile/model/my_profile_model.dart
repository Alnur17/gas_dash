class MyProfileModel {
  MyProfileModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory MyProfileModel.fromJson(Map<String, dynamic> json){
    return MyProfileModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
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
  final double? totalEarning; // Changed from int? to double?
  final double? experience; // Changed from int? to double?
  final dynamic address;
  final double? freeDeliverylimit; // Changed from int? to double?
  final double? coverVehiclelimit; // Changed from int? to double?
  final double? durationDay; // Changed from int? to double?
  final bool? isDeleted;
  final double? popularity; // Changed from int? to double?
  final bool? fiftyPercentOffDeliveryFeeAfterWaivedTrips;
  final bool? scheduledDelivery;
  final bool? fuelPriceTrackingAlerts;
  final bool? noExtraChargeForEmergencyFuelServiceLimit;
  final bool? freeSubscriptionAdditionalFamilyMember;
  final bool? exclusivePromotionsEarlyAccess;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? v; // Changed from int? to double?
  final String? title;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
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
      totalEarning: (json["totalEarning"] is int)
          ? (json["totalEarning"] as int).toDouble()
          : json["totalEarning"]?.toDouble(),
      experience: (json["experience"] is int)
          ? (json["experience"] as int).toDouble()
          : json["experience"]?.toDouble(),
      address: json["address"],
      freeDeliverylimit: (json["freeDeliverylimit"] is int)
          ? (json["freeDeliverylimit"] as int).toDouble()
          : json["freeDeliverylimit"]?.toDouble(),
      coverVehiclelimit: (json["coverVehiclelimit"] is int)
          ? (json["coverVehiclelimit"] as int).toDouble()
          : json["coverVehiclelimit"]?.toDouble(),
      durationDay: (json["durationDay"] is int)
          ? (json["durationDay"] as int).toDouble()
          : json["durationDay"]?.toDouble(),
      isDeleted: json["isDeleted"],
      popularity: (json["popularity"] is int)
          ? (json["popularity"] as int).toDouble()
          : json["popularity"]?.toDouble(),
      fiftyPercentOffDeliveryFeeAfterWaivedTrips: json["fiftyPercentOffDeliveryFeeAfterWaivedTrips"],
      scheduledDelivery: json["scheduledDelivery"],
      fuelPriceTrackingAlerts: json["fuelPriceTrackingAlerts"],
      noExtraChargeForEmergencyFuelServiceLimit: json["noExtraChargeForEmergencyFuelServiceLimit"],
      freeSubscriptionAdditionalFamilyMember: json["freeSubscriptionAdditionalFamilyMember"],
      exclusivePromotionsEarlyAccess: json["exclusivePromotionsEarlyAccess"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: (json["__v"] is int)
          ? (json["__v"] as int).toDouble()
          : json["__v"]?.toDouble(),
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

  final double? otp; // Changed from int? to double?
  final DateTime? expiresAt;
  final bool? status;

  factory Verification.fromJson(Map<String, dynamic> json){
    return Verification(
      otp: (json["otp"] is int)
          ? (json["otp"] as int).toDouble()
          : json["otp"]?.toDouble(),
      expiresAt: DateTime.tryParse(json["expiresAt"] ?? ""),
      status: json["status"],
    );
  }
}