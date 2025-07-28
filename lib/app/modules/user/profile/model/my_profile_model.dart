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
    required this.geoLocation,
    required this.verification,
    required this.familyMember,
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
    required this.averageRating,
    required this.freeDeliverylimit,
    required this.coverVehiclelimit,
    required this.durationDay,
    required this.isDeleted,
    required this.reviews,
    required this.avgRating,
    required this.popularity,
    required this.fiftyPercentOffDeliveryFeeAfterWaivedTrips,
    required this.scheduledDelivery,
    required this.fuelPriceTrackingAlerts,
    required this.noExtraChargeForEmergencyFuelServiceLimit,
    required this.freeSubscriptionAdditionalFamilyMember,
    required this.exclusivePromotionsEarlyAccess,
    required this.remeningDurationDay,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.title,
    required this.currentStatus,
  });

  final GeoLocation? geoLocation;
  final Verification? verification;
  final FamilyMember? familyMember;
  final String? id;
  final String? status;
  final String? fullname;
  final String? location;
  final String? country;
  final String? zipCode;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final dynamic gender;
  final dynamic dateOfBirth;
  final bool? isGoogleLogin;
  final dynamic image;
  final String? role;
  final int? totalEarning;
  final int? experience;
  final dynamic address;
  final int? averageRating;
  final int? freeDeliverylimit;
  final int? coverVehiclelimit;
  final DateTime? durationDay;
  final bool? isDeleted;
  final List<dynamic> reviews;
  final int? avgRating;
  final int? popularity;
  final bool? fiftyPercentOffDeliveryFeeAfterWaivedTrips;
  final bool? scheduledDelivery;
  final bool? fuelPriceTrackingAlerts;
  final bool? noExtraChargeForEmergencyFuelServiceLimit;
  final bool? freeSubscriptionAdditionalFamilyMember;
  final bool? exclusivePromotionsEarlyAccess;
  final int? remeningDurationDay;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? title;
  final String? currentStatus;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      geoLocation: json["geoLocation"] == null ? null : GeoLocation.fromJson(json["geoLocation"]),
      verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
      familyMember: json["familyMember"] == null ? null : FamilyMember.fromJson(json["familyMember"]),
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
      averageRating: json["AverageRating"],
      freeDeliverylimit: json["freeDeliverylimit"],
      coverVehiclelimit: json["coverVehiclelimit"],
      durationDay: DateTime.tryParse(json["durationDay"] ?? ""),
      isDeleted: json["isDeleted"],
      reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
      avgRating: json["avgRating"],
      popularity: json["popularity"],
      fiftyPercentOffDeliveryFeeAfterWaivedTrips: json["fiftyPercentOffDeliveryFeeAfterWaivedTrips"],
      scheduledDelivery: json["scheduledDelivery"],
      fuelPriceTrackingAlerts: json["fuelPriceTrackingAlerts"],
      noExtraChargeForEmergencyFuelServiceLimit: json["noExtraChargeForEmergencyFuelServiceLimit"],
      freeSubscriptionAdditionalFamilyMember: json["freeSubscriptionAdditionalFamilyMember"],
      exclusivePromotionsEarlyAccess: json["exclusivePromotionsEarlyAccess"],
      remeningDurationDay: json["remeningDurationDay"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      title: json["title"],
      currentStatus: json["currentStatus"],
    );
  }

}

class FamilyMember {
  FamilyMember({
    required this.name,
    required this.email,
  });

  final String? name;
  final String? email;

  factory FamilyMember.fromJson(Map<String, dynamic> json){
    return FamilyMember(
      name: json["name"],
      email: json["email"],
    );
  }

}

class GeoLocation {
  GeoLocation({
    required this.type,
    required this.coordinates,
  });

  final String? type;
  final List<double> coordinates;

  factory GeoLocation.fromJson(Map<String, dynamic> json){
    return GeoLocation(
      type: json["type"],
      coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x.toDouble())),
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
