class OrderHistoryModel {
  OrderHistoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json){
    return OrderHistoryModel(
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

  final List<OrderHistoryDatum> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<OrderHistoryDatum>.from(json["data"]!.map((x) => OrderHistoryDatum.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }
}

class OrderHistoryDatum {
  OrderHistoryDatum({
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
    required this.cancelReason,
    required this.fuelType,
    required this.isPaid,
    required this.finalAmountOfPayment,
    required this.zipCode,
    required this.servicesFee,
    required this.proofImage,
    required this.emergency,
    required this.createdAt,
    required this.updatedAt,
    required this.paymentId,
    required this.driverId,
    required this.deleveryId,
  });

  final Location? location;
  final String? id;
  final String? vehicleId;
  final ErId? userId;
  final double? amount; // Changed from int to double
  final double? deliveryFee;
  final double? price;
  final bool? presetAmount;
  final bool? customAmount;
  final double? tip; // Changed from int to double
  final String? orderType;
  final String? orderStatus;
  final String? cancelReason;
  final String? fuelType;
  final bool? isPaid;
  final double? finalAmountOfPayment;
  final String? zipCode;
  final double? servicesFee; // Changed from int to double
  final String? proofImage;
  final bool? emergency;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? paymentId;
  final ErId? driverId;
  final String? deleveryId;

  factory OrderHistoryDatum.fromJson(Map<String, dynamic> json){
    return OrderHistoryDatum(
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      id: json["_id"],
      vehicleId: json["vehicleId"],
      userId: json["userId"] == null ? null : ErId.fromJson(json["userId"]),
      amount: (json["amount"] is int) ? (json["amount"] as int).toDouble() : json["amount"]?.toDouble(),
      deliveryFee: (json["deliveryFee"] is int) ? (json["deliveryFee"] as int).toDouble() : json["deliveryFee"]?.toDouble(),
      price: (json["price"] is int) ? (json["price"] as int).toDouble() : json["price"]?.toDouble(),
      presetAmount: json["presetAmount"],
      customAmount: json["customAmount"],
      tip: (json["tip"] is int) ? (json["tip"] as int).toDouble() : json["tip"]?.toDouble(),
      orderType: json["orderType"],
      orderStatus: json["orderStatus"],
      cancelReason: json["cancelReason"],
      fuelType: json["fuelType"],
      isPaid: json["isPaid"],
      finalAmountOfPayment: (json["finalAmountOfPayment"] is int) ? (json["finalAmountOfPayment"] as int).toDouble() : json["finalAmountOfPayment"]?.toDouble(),
      zipCode: json["zipCode"],
      servicesFee: (json["servicesFee"] is int) ? (json["servicesFee"] as int).toDouble() : json["servicesFee"]?.toDouble(),
      proofImage: json["proofImage"],
      emergency: json["emergency"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      paymentId: json["paymentId"],
      driverId: json["driverId"] == null ? null : ErId.fromJson(json["driverId"]),
      deleveryId: json["deleveryId"],
    );
  }
}

class ErId {
  ErId({
    required this.verification,
    required this.popularity,
    required this.fiftyPercentOffDeliveryFeeAfterWaivedTrips,
    required this.scheduledDelivery,
    required this.fuelPriceTrackingAlerts,
    required this.noExtraChargeForEmergencyFuelServiceLimit,
    required this.freeSubscriptionAdditionalFamilyMember,
    required this.exclusivePromotionsEarlyAccess,
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
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final Verification? verification;
  final double? popularity; // Changed from int to double
  final bool? fiftyPercentOffDeliveryFeeAfterWaivedTrips;
  final bool? scheduledDelivery;
  final bool? fuelPriceTrackingAlerts;
  final bool? noExtraChargeForEmergencyFuelServiceLimit;
  final bool? freeSubscriptionAdditionalFamilyMember;
  final bool? exclusivePromotionsEarlyAccess;
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
  final double? totalEarning;
  final double? experience; // Changed from int to double
  final dynamic address;
  final double? freeDeliverylimit; // Changed from int to double
  final double? coverVehiclelimit; // Changed from int to double
  final double? durationDay; // Changed from int to double
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? v; // Changed from int to double

  factory ErId.fromJson(Map<String, dynamic> json){
    return ErId(
      verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
      popularity: (json["popularity"] is int) ? (json["popularity"] as int).toDouble() : json["popularity"]?.toDouble(),
      fiftyPercentOffDeliveryFeeAfterWaivedTrips: json["fiftyPercentOffDeliveryFeeAfterWaivedTrips"],
      scheduledDelivery: json["scheduledDelivery"],
      fuelPriceTrackingAlerts: json["fuelPriceTrackingAlerts"],
      noExtraChargeForEmergencyFuelServiceLimit: json["noExtraChargeForEmergencyFuelServiceLimit"],
      freeSubscriptionAdditionalFamilyMember: json["freeSubscriptionAdditionalFamilyMember"],
      exclusivePromotionsEarlyAccess: json["exclusivePromotionsEarlyAccess"],
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
      totalEarning: (json["totalEarning"] is int) ? (json["totalEarning"] as int).toDouble() : json["totalEarning"]?.toDouble(),
      experience: (json["experience"] is int) ? (json["experience"] as int).toDouble() : json["experience"]?.toDouble(),
      address: json["address"],
      freeDeliverylimit: (json["freeDeliverylimit"] is int) ? (json["freeDeliverylimit"] as int).toDouble() : json["freeDeliverylimit"]?.toDouble(),
      coverVehiclelimit: (json["coverVehiclelimit"] is int) ? (json["coverVehiclelimit"] as int).toDouble() : json["coverVehiclelimit"]?.toDouble(),
      durationDay: (json["durationDay"] is int) ? (json["durationDay"] as int).toDouble() : json["durationDay"]?.toDouble(),
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: (json["__v"] is int) ? (json["__v"] as int).toDouble() : json["__v"]?.toDouble(),
    );
  }
}

class Verification {
  Verification({
    required this.otp,
    required this.expiresAt,
    required this.status,
  });

  final double? otp; // Changed from int to double
  final DateTime? expiresAt;
  final bool? status;

  factory Verification.fromJson(Map<String, dynamic> json){
    return Verification(
      otp: (json["otp"] is int) ? (json["otp"] as int).toDouble() : json["otp"]?.toDouble(),
      expiresAt: DateTime.tryParse(json["expiresAt"] ?? ""),
      status: json["status"],
    );
  }
}

class Location {
  Location({
    required this.coordinates,
    required this.type,
  });

  final List<double> coordinates;
  final String? type;

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
      type: json["type"],
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

  final double? page; // Changed from int to double
  final double? limit; // Changed from int to double
  final double? total; // Changed from int to double
  final double? totalPage; // Changed from int to double

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      page: (json["page"] is int) ? (json["page"] as int).toDouble() : json["page"]?.toDouble(),
      limit: (json["limit"] is int) ? (json["limit"] as int).toDouble() : json["limit"]?.toDouble(),
      total: (json["total"] is int) ? (json["total"] as int).toDouble() : json["total"]?.toDouble(),
      totalPage: (json["totalPage"] is int) ? (json["totalPage"] as int).toDouble() : json["totalPage"]?.toDouble(),
    );
  }
}