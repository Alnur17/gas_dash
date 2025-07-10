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
    required this.schedulDate,
    required this.schedulTime,
    required this.emergencyTime,
    required this.cuponCode,
    required this.createdAt,
    required this.updatedAt,
    required this.paymentId,
    required this.driverId,
    required this.deleveryId,
  });

  final Location? location;
  final String? id;
  final String? vehicleId;
  final UserId? userId;
  final dynamic amount;
  final dynamic deliveryFee;
  final dynamic price;
  final bool? presetAmount;
  final bool? customAmount;
  final dynamic tip;
  final String? orderType;
  final String? orderStatus;
  final String? cancelReason;
  final String? fuelType;
  final bool? isPaid;
  final dynamic finalAmountOfPayment;
  final String? zipCode;
  final dynamic servicesFee;
  final String? proofImage;
  final bool? emergency;
  final String? schedulDate;
  final String? schedulTime;
  final String? emergencyTime;
  final String? cuponCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? paymentId;
  final DriverId? driverId;
  final String? deleveryId;

  factory OrderHistoryDatum.fromJson(Map<String, dynamic> json){
    return OrderHistoryDatum(
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      id: json["_id"],
      vehicleId: json["vehicleId"],
      userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
      amount: json["amount"],
      deliveryFee: json["deliveryFee"],
      price: json["price"],
      presetAmount: json["presetAmount"],
      customAmount: json["customAmount"],
      tip: json["tip"],
      orderType: json["orderType"],
      orderStatus: json["orderStatus"],
      cancelReason: json["cancelReason"],
      fuelType: json["fuelType"],
      isPaid: json["isPaid"],
      finalAmountOfPayment: json["finalAmountOfPayment"],
      zipCode: json["zipCode"],
      servicesFee: json["servicesFee"],
      proofImage: json["proofImage"],
      emergency: json["emergency"],
      schedulDate: json["schedulDate"],
      schedulTime: json["schedulTime"],
      emergencyTime: json["emergencyTime"],
      cuponCode: json["cuponCode"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      paymentId: json["paymentId"],
      driverId: json["driverId"] == null ? null : DriverId.fromJson(json["driverId"]),
      deleveryId: json["deleveryId"],
    );
  }

}

class DriverId {
  DriverId({
    required this.verification,
    required this.familyMember,
    required this.experience,
    required this.averageRating,
    required this.popularity,
    required this.fiftyPercentOffDeliveryFeeAfterWaivedTrips,
    required this.scheduledDelivery,
    required this.fuelPriceTrackingAlerts,
    required this.noExtraChargeForEmergencyFuelServiceLimit,
    required this.freeSubscriptionAdditionalFamilyMember,
    required this.exclusivePromotionsEarlyAccess,
    required this.remeningDurationDay,
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
    required this.address,
    required this.freeDeliverylimit,
    required this.coverVehiclelimit,
    required this.durationDay,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.totalEarning,
    required this.reviews,
    required this.avgRating,
  });

  final DriverIdVerification? verification;
  final FamilyMember? familyMember;
  final dynamic experience;
  final dynamic averageRating;
  final dynamic popularity;
  final bool? fiftyPercentOffDeliveryFeeAfterWaivedTrips;
  final bool? scheduledDelivery;
  final bool? fuelPriceTrackingAlerts;
  final bool? noExtraChargeForEmergencyFuelServiceLimit;
  final bool? freeSubscriptionAdditionalFamilyMember;
  final bool? exclusivePromotionsEarlyAccess;
  final dynamic remeningDurationDay;
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
  final dynamic address;
  final dynamic freeDeliverylimit;
  final dynamic coverVehiclelimit;
  final DateTime? durationDay;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic v;
  final dynamic totalEarning;
  final List<Review> reviews;
  final dynamic avgRating;

  factory DriverId.fromJson(Map<String, dynamic> json){
    return DriverId(
      verification: json["verification"] == null ? null : DriverIdVerification.fromJson(json["verification"]),
      familyMember: json["familyMember"] == null ? null : FamilyMember.fromJson(json["familyMember"]),
      experience: json["experience"],
      averageRating: json["AverageRating"],
      popularity: json["popularity"],
      fiftyPercentOffDeliveryFeeAfterWaivedTrips: json["fiftyPercentOffDeliveryFeeAfterWaivedTrips"],
      scheduledDelivery: json["scheduledDelivery"],
      fuelPriceTrackingAlerts: json["fuelPriceTrackingAlerts"],
      noExtraChargeForEmergencyFuelServiceLimit: json["noExtraChargeForEmergencyFuelServiceLimit"],
      freeSubscriptionAdditionalFamilyMember: json["freeSubscriptionAdditionalFamilyMember"],
      exclusivePromotionsEarlyAccess: json["exclusivePromotionsEarlyAccess"],
      remeningDurationDay: json["remeningDurationDay"],
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
      address: json["address"],
      freeDeliverylimit: json["freeDeliverylimit"],
      coverVehiclelimit: json["coverVehiclelimit"],
      durationDay: DateTime.tryParse(json["durationDay"] ?? ""),
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      totalEarning: json["totalEarning"],
      reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
      avgRating: json["avgRating"],
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

class Review {
  Review({
    required this.id,
    required this.driverId,
    required this.userId,
    required this.rating,
    required this.review,
    required this.averageRating,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? driverId;
  final String? userId;
  final dynamic rating;
  final String? review;
  final dynamic averageRating;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic v;

  factory Review.fromJson(Map<String, dynamic> json){
    return Review(
      id: json["_id"],
      driverId: json["driverId"],
      userId: json["userId"],
      rating: json["rating"],
      review: json["review"],
      averageRating: json["averageRating"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class DriverIdVerification {
  DriverIdVerification({
    required this.otp,
    required this.expiresAt,
    required this.status,
  });

  final dynamic otp;
  final DateTime? expiresAt;
  final bool? status;

  factory DriverIdVerification.fromJson(Map<String, dynamic> json){
    return DriverIdVerification(
      otp: json["otp"],
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

class UserId {
  UserId({
    required this.verification,
    required this.familyMember,
    required this.averageRating,
    required this.reviews,
    required this.avgRating,
    required this.popularity,
    required this.remeningDurationDay,
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
    required this.exclusivePromotionsEarlyAccess,
    required this.fiftyPercentOffDeliveryFeeAfterWaivedTrips,
    required this.freeSubscriptionAdditionalFamilyMember,
    required this.fuelPriceTrackingAlerts,
    required this.noExtraChargeForEmergencyFuelServiceLimit,
    required this.scheduledDelivery,
    required this.title,
  });

  final UserIdVerification? verification;
  final FamilyMember? familyMember;
  final dynamic averageRating;
  final List<dynamic> reviews;
  final dynamic avgRating;
  final dynamic popularity;
  final dynamic remeningDurationDay;
  final String? id;
  final String? status;
  final String? fullname;
  final dynamic location;
  final dynamic country;
  final dynamic zipCode;
  final String? email;
  final dynamic phoneNumber;
  final String? password;
  final dynamic gender;
  final dynamic dateOfBirth;
  final bool? isGoogleLogin;
  final dynamic image;
  final String? role;
  final dynamic totalEarning;
  final dynamic experience;
  final dynamic address;
  final dynamic freeDeliverylimit;
  final dynamic coverVehiclelimit;
  final DateTime? durationDay;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic v;
  final bool? exclusivePromotionsEarlyAccess;
  final bool? fiftyPercentOffDeliveryFeeAfterWaivedTrips;
  final bool? freeSubscriptionAdditionalFamilyMember;
  final bool? fuelPriceTrackingAlerts;
  final bool? noExtraChargeForEmergencyFuelServiceLimit;
  final bool? scheduledDelivery;
  final String? title;

  factory UserId.fromJson(Map<String, dynamic> json){
    return UserId(
      verification: json["verification"] == null ? null : UserIdVerification.fromJson(json["verification"]),
      familyMember: json["familyMember"] == null ? null : FamilyMember.fromJson(json["familyMember"]),
      averageRating: json["AverageRating"],
      reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
      avgRating: json["avgRating"],
      popularity: json["popularity"],
      remeningDurationDay: json["remeningDurationDay"],
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
      durationDay: DateTime.tryParse(json["durationDay"] ?? ""),
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      exclusivePromotionsEarlyAccess: json["exclusivePromotionsEarlyAccess"],
      fiftyPercentOffDeliveryFeeAfterWaivedTrips: json["fiftyPercentOffDeliveryFeeAfterWaivedTrips"],
      freeSubscriptionAdditionalFamilyMember: json["freeSubscriptionAdditionalFamilyMember"],
      fuelPriceTrackingAlerts: json["fuelPriceTrackingAlerts"],
      noExtraChargeForEmergencyFuelServiceLimit: json["noExtraChargeForEmergencyFuelServiceLimit"],
      scheduledDelivery: json["scheduledDelivery"],
      title: json["title"],
    );
  }

}

class UserIdVerification {
  UserIdVerification({
    required this.status,
    required this.otp,
  });

  final bool? status;
  final dynamic otp;

  factory UserIdVerification.fromJson(Map<String, dynamic> json){
    return UserIdVerification(
      status: json["status"],
      otp: json["otp"],
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

  final dynamic page;
  final dynamic limit;
  final dynamic total;
  final dynamic totalPage;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }

}
