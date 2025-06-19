class MyProfileModel {
  MyProfileModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory MyProfileModel.fromJson(Map<String, dynamic> json) {
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
    required this.familyMember,
    required this.averageRating, // Added AverageRating
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
    required this.remeningDurationDay,
  });

  final Verification? verification;
  final FamilyMember? familyMember;
  final double? averageRating; // Added AverageRating
  final String? id;
  final String? status;
  final String? fullname;
  final String? location;
  final dynamic country;
  final String? zipCode;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final dynamic gender;
  final dynamic dateOfBirth;
  final bool? isGoogleLogin;
  final String? image;
  final String? role;
  final double? totalEarning;
  final int? experience;
  final dynamic address;
  final double? freeDeliverylimit;
  final double? coverVehiclelimit;
  final double? durationDay;
  final bool? isDeleted;
  final double? popularity;
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
  final int? remeningDurationDay;
  final double? remeningDurationDay;
  final DateTime? passwordChangedAt;
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      verification: json["verification"] == null
          ? null
          : Verification.fromJson(json["verification"]),
      familyMember: json["familyMember"] == null
          ? null
          : FamilyMember.fromJson(json["familyMember"]),
      averageRating: _parseDouble(json["AverageRating"]), // Added AverageRating
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
      totalEarning: _parseDouble(json["totalEarning"]),
      experience: json["experience"],
      address: json["address"],
      freeDeliverylimit: _parseDouble(json["freeDeliverylimit"]),
      coverVehiclelimit: _parseDouble(json["coverVehiclelimit"]),
      durationDay: _parseDurationDay(json["durationDay"]),
      isDeleted: json["isDeleted"],
      popularity: _parseDouble(json["popularity"]),
      fiftyPercentOffDeliveryFeeAfterWaivedTrips:
      json["fiftyPercentOffDeliveryFeeAfterWaivedTrips"],
      scheduledDelivery: json["scheduledDelivery"],
      fuelPriceTrackingAlerts: json["fuelPriceTrackingAlerts"],
      noExtraChargeForEmergencyFuelServiceLimit:
      json["noExtraChargeForEmergencyFuelServiceLimit"],
      freeSubscriptionAdditionalFamilyMember:
      json["freeSubscriptionAdditionalFamilyMember"],
      exclusivePromotionsEarlyAccess: json["exclusivePromotionsEarlyAccess"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      title: json["title"],
      remeningDurationDay: _parseDouble(json["remeningDurationDay"]),
      passwordChangedAt: DateTime.tryParse(json["passwordChangedAt"] ?? ""),
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value);
    return null;
  }

  static double? _parseDurationDay(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      try {
        final dateTime = DateTime.tryParse(value);
        if (dateTime == null) return null;
        // Calculate days since epoch (1970-01-01) or another reference date
        final referenceDate = DateTime(1970, 1, 1); // Epoch as reference
        return dateTime.difference(referenceDate).inDays.toDouble();
      } catch (e) {
        print("Error parsing durationDay: $e");
        return null;
      }
    }
    return _parseDouble(value);
  }
}

class FamilyMember {
  FamilyMember({
    required this.name,
    required this.email,
  });

  final String? name;
  final String? email;

  factory FamilyMember.fromJson(Map<String, dynamic> json) {
    return FamilyMember(
      name: json["name"],
      email: json["email"],
    );
  }

}

class Verification {
  Verification({
    required this.status,
    required this.otp,
  });

  final bool? status;
  final int? otp;

  factory Verification.fromJson(Map<String, dynamic> json) {
    return Verification(
      status: json["status"],
      otp: json["otp"],
    );
  }

}
