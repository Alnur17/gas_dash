class SingleOrderByIdModel {
  SingleOrderByIdModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final SingleOrderData? data;

  factory SingleOrderByIdModel.fromJson(Map<String, dynamic> json) {
    return SingleOrderByIdModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : SingleOrderData.fromJson(json["data"]),
    );
  }
}

class SingleOrderData {
  SingleOrderData({
    required this.location,
    required this.id,
    required this.vehicleId,
    required this.userId,
    required this.amount,
    required this.deliveryFee,
    required this.price,
    required this.presetAmount,
    required this.customAmount,
    required this.tip,
    required this.orderType,
    required this.orderStatus,
    required this.fuelType,
    required this.isPaid,
    required this.finalAmountOfPayment,
    required this.zipCode,
    required this.servicesFee,
    required this.proofImage,
    required this.emergency,
    required this.schedulDate,
    required this.schedulTime,
    required this.emergencyTime,
    required this.cuponCode,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final Location? location;
  final String? id;
  final dynamic vehicleId;
  final UserId? userId;
  final double? amount;
  final double? deliveryFee;
  final double? price;
  final bool? presetAmount;
  final bool? customAmount;
  final double? tip;
  final String? orderType;
  final String? orderStatus;
  final String? fuelType;
  final bool? isPaid;
  final double? finalAmountOfPayment;
  final String? zipCode;
  final double? servicesFee;
  final String? proofImage;
  final bool? emergency;
  final String? schedulDate;
  final String? schedulTime;
  final String? emergencyTime;
  final String? cuponCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? v;

  factory SingleOrderData.fromJson(Map<String, dynamic> json) {
    return SingleOrderData(
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      id: json["_id"],
      vehicleId: json["vehicleId"] == null ? null : VehicleId.fromJson(json["vehicleId"]),
      userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
      amount: json["amount"] is int ? (json["amount"] as int).toDouble() : json["amount"],
      deliveryFee: json["deliveryFee"] is int ? (json["deliveryFee"] as int).toDouble() : json["deliveryFee"],
      price: json["price"] is int ? (json["price"] as int).toDouble() : json["price"],
      presetAmount: json["presetAmount"],
      customAmount: json["customAmount"],
      tip: json["tip"] is int ? (json["tip"] as int).toDouble() : json["tip"],
      orderType: json["orderType"],
      orderStatus: json["orderStatus"],
      fuelType: json["fuelType"],
      isPaid: json["isPaid"],
      finalAmountOfPayment: json["finalAmountOfPayment"] is int ? (json["finalAmountOfPayment"] as int).toDouble() : json["finalAmountOfPayment"],
      zipCode: json["zipCode"],
      servicesFee: json["servicesFee"] is int ? (json["servicesFee"] as int).toDouble() : json["servicesFee"],
      proofImage: json["proofImage"],
      emergency: json["emergency"],
      schedulDate: json["schedulDate"],
      schedulTime: json["schedulTime"],
      emergencyTime: json["emergencyTime"],
      cuponCode: json["cuponCode"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] is int ? (json["__v"] as int).toDouble() : json["__v"],
    );
  }
}

class Location {
  Location({
    required this.type,
    required this.coordinates,
  });

  final String? type;
  final List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json["type"],
      coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
    );
  }
}

class UserId {
  UserId({
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
  });

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
  final String? image;
  final String? role;
  final double? totalEarning;
  final double? experience;
  final dynamic address;
  final double? averageRating;
  final double? freeDeliverylimit;
  final double? coverVehiclelimit;
  final DateTime? durationDay;
  final bool? isDeleted;
  final List<dynamic> reviews;
  final double? avgRating;
  final double? popularity;
  final bool? fiftyPercentOffDeliveryFeeAfterWaivedTrips;
  final bool? scheduledDelivery;
  final bool? fuelPriceTrackingAlerts;
  final bool? noExtraChargeForEmergencyFuelServiceLimit;
  final bool? freeSubscriptionAdditionalFamilyMember;
  final bool? exclusivePromotionsEarlyAccess;
  final double? remeningDurationDay;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? v;
  final String? title;

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
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
      totalEarning: json["totalEarning"] is int ? (json["totalEarning"] as int).toDouble() : json["totalEarning"],
      experience: json["experience"] is int ? (json["experience"] as int).toDouble() : json["experience"],
      address: json["address"],
      averageRating: json["AverageRating"] is int ? (json["AverageRating"] as int).toDouble() : json["AverageRating"],
      freeDeliverylimit: json["freeDeliverylimit"] is int ? (json["freeDeliverylimit"] as int).toDouble() : json["freeDeliverylimit"],
      coverVehiclelimit: json["coverVehiclelimit"] is int ? (json["coverVehiclelimit"] as int).toDouble() : json["coverVehiclelimit"],
      durationDay: DateTime.tryParse(json["durationDay"] ?? ""),
      isDeleted: json["isDeleted"],
      reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
      avgRating: json["avgRating"] is int ? (json["avgRating"] as int).toDouble() : json["avgRating"],
      popularity: json["popularity"] is int ? (json["popularity"] as int).toDouble() : json["popularity"],
      fiftyPercentOffDeliveryFeeAfterWaivedTrips: json["fiftyPercentOffDeliveryFeeAfterWaivedTrips"],
      scheduledDelivery: json["scheduledDelivery"],
      fuelPriceTrackingAlerts: json["fuelPriceTrackingAlerts"],
      noExtraChargeForEmergencyFuelServiceLimit: json["noExtraChargeForEmergencyFuelServiceLimit"],
      freeSubscriptionAdditionalFamilyMember: json["freeSubscriptionAdditionalFamilyMember"],
      exclusivePromotionsEarlyAccess: json["exclusivePromotionsEarlyAccess"],
      remeningDurationDay: json["remeningDurationDay"] is int ? (json["remeningDurationDay"] as int).toDouble() : json["remeningDurationDay"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] is int ? (json["__v"] as int).toDouble() : json["__v"],
      title: json["title"],
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

  factory FamilyMember.fromJson(Map<String, dynamic> json) {
    return FamilyMember(
      name: json["name"],
      email: json["email"],
    );
  }
}

class Verification {
  Verification({
    required this.otp,
    required this.expiresAt,
    required this.status,
  });

  final double? otp;
  final DateTime? expiresAt;
  final bool? status;

  factory Verification.fromJson(Map<String, dynamic> json) {
    return Verification(
      otp: json["otp"] is int ? (json["otp"] as int).toDouble() : json["otp"],
      expiresAt: DateTime.tryParse(json["expiresAt"] ?? ""),
      status: json["status"],
    );
  }
}

class VehicleId {
  VehicleId({
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
  final double? year;
  final double? fuelLevel;
  final String? userId;
  final bool? isCoveredBySubscription;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? v;

  factory VehicleId.fromJson(Map<String, dynamic> json) {
    return VehicleId(
      id: json["_id"],
      make: json["make"],
      model: json["model"],
      year: json["year"] is int ? (json["year"] as int).toDouble() : json["year"],
      fuelLevel: json["fuelLevel"] is int ? (json["fuelLevel"] as int).toDouble() : json["fuelLevel"],
      userId: json["userId"],
      isCoveredBySubscription: json["isCoveredBySubscription"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] is int ? (json["__v"] as int).toDouble() : json["__v"],
    );
  }
}