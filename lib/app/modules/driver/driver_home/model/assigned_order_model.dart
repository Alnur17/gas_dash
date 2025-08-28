// class AssignedOrderModel {
//   AssignedOrderModel({
//     required this.success,
//     required this.message,
//     required this.data,
//   });
//
//   final bool? success;
//   final String? message;
//   final Data? data;
//
//   factory AssignedOrderModel.fromJson(Map<String, dynamic> json){
//     return AssignedOrderModel(
//       success: json["success"],
//       message: json["message"],
//       data: json["data"] == null ? null : Data.fromJson(json["data"]),
//     );
//   }
//
// }
//
// class Data {
//   Data({
//     required this.data,
//     required this.meta,
//   });
//
//   final List<Datum> data;
//   final Meta? meta;
//
//   factory Data.fromJson(Map<String, dynamic> json){
//     return Data(
//       data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//       meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
//     );
//   }
//
// }
//
// class Datum {
//   Datum({
//     required this.location,
//     required this.schedulDate,
//     required this.schedulTime,
//     required this.emergencyTime,
//     required this.cuponCode,
//     required this.id,
//     required this.vehicleId,
//     required this.userId,
//     required this.amount,
//     required this.deliveryFee,
//     required this.price,
//     required this.presetAmount,
//     required this.customAmount,
//     required this.tip,
//     required this.orderType,
//     required this.orderStatus,
//     required this.fuelType,
//     required this.isPaid,
//     required this.finalAmountOfPayment,
//     required this.zipCode,
//     required this.servicesFee,
//     required this.proofImage,
//     required this.emergency,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.driverId,
//     required this.deleveryId,
//     required this.cancelReason,
//     required this.paymentId,
//   });
//
//   final Location? location;
//   final String? schedulDate;
//   final String? schedulTime;
//   final String? emergencyTime;
//   final String? cuponCode;
//   final String? id;
//   final String? vehicleId;
//   final UserId? userId;
//   final dynamic amount;
//   final dynamic deliveryFee;
//   final dynamic price;
//   final bool? presetAmount;
//   final bool? customAmount;
//   final dynamic tip;
//   final String? orderType;
//   final String? orderStatus;
//   final String? fuelType;
//   final bool? isPaid;
//   final dynamic finalAmountOfPayment;
//   final String? zipCode;
//   final dynamic servicesFee;
//   final String? proofImage;
//   final bool? emergency;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final String? driverId;
//   final String? deleveryId;
//   final String? cancelReason;
//   final String? paymentId;
//
//   factory Datum.fromJson(Map<String, dynamic> json){
//     return Datum(
//       location: json["location"] == null ? null : Location.fromJson(json["location"]),
//       schedulDate: json["schedulDate"],
//       schedulTime: json["schedulTime"],
//       emergencyTime: json["emergencyTime"],
//       cuponCode: json["cuponCode"],
//       id: json["_id"],
//       vehicleId: json["vehicleId"],
//       userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
//       amount: json["amount"],
//       deliveryFee: json["deliveryFee"],
//       price: json["price"],
//       presetAmount: json["presetAmount"],
//       customAmount: json["customAmount"],
//       tip: json["tip"],
//       orderType: json["orderType"],
//       orderStatus: json["orderStatus"],
//       fuelType: json["fuelType"],
//       isPaid: json["isPaid"],
//       finalAmountOfPayment: json["finalAmountOfPayment"],
//       zipCode: json["zipCode"],
//       servicesFee: json["servicesFee"],
//       proofImage: json["proofImage"],
//       emergency: json["emergency"],
//       createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
//       driverId: json["driverId"],
//       deleveryId: json["deleveryId"],
//       cancelReason: json["cancelReason"],
//       paymentId: json["paymentId"],
//     );
//   }
//
// }
//
// class Location {
//   Location({
//     required this.type,
//     required this.coordinates,
//   });
//
//   final String? type;
//   final List<double> coordinates;
//
//   factory Location.fromJson(Map<String, dynamic> json){
//     return Location(
//       type: json["type"],
//       coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
//     );
//   }
//
// }
//
// class UserId {
//   UserId({
//     required this.verification,
//     required this.familyMember,
//     required this.totalEarning,
//     required this.experience,
//     required this.averageRating,
//     required this.reviews,
//     required this.avgRatings,
//     required this.popularity,
//     required this.fiftyPercentOffDeliveryFeeAfterWaivedTrips,
//     required this.scheduledDelivery,
//     required this.fuelPriceTrackingAlerts,
//     required this.noExtraChargeForEmergencyFuelServiceLimit,
//     required this.freeSubscriptionAdditionalFamilyMember,
//     required this.exclusivePromotionsEarlyAccess,
//     required this.id,
//     required this.status,
//     required this.fullname,
//     required this.location,
//     required this.country,
//     required this.zipCode,
//     required this.email,
//     required this.phoneNumber,
//     required this.password,
//     required this.gender,
//     required this.dateOfBirth,
//     required this.isGoogleLogin,
//     required this.image,
//     required this.role,
//     required this.address,
//     required this.freeDeliverylimit,
//     required this.coverVehiclelimit,
//     required this.durationDay,
//     required this.isDeleted,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.remeningDurationDay,
//   });
//
//   final Verification? verification;
//   final FamilyMember? familyMember;
//   final dynamic totalEarning;
//   final dynamic experience;
//   final dynamic averageRating;
//   final List<dynamic> reviews;
//   final dynamic avgRatings;
//   final dynamic popularity;
//   final bool? fiftyPercentOffDeliveryFeeAfterWaivedTrips;
//   final bool? scheduledDelivery;
//   final bool? fuelPriceTrackingAlerts;
//   final bool? noExtraChargeForEmergencyFuelServiceLimit;
//   final bool? freeSubscriptionAdditionalFamilyMember;
//   final bool? exclusivePromotionsEarlyAccess;
//   final String? id;
//   final String? status;
//   final String? fullname;
//   final String? location;
//   final String? country;
//   final String? zipCode;
//   final String? email;
//   final String? phoneNumber;
//   final String? password;
//   final dynamic gender;
//   final dynamic dateOfBirth;
//   final bool? isGoogleLogin;
//   final String? image;
//   final String? role;
//   final dynamic address;
//   final dynamic freeDeliverylimit;
//   final dynamic coverVehiclelimit;
//   final DateTime? durationDay;
//   final bool? isDeleted;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final dynamic v;
//   final dynamic remeningDurationDay;
//
//   factory UserId.fromJson(Map<String, dynamic> json){
//     return UserId(
//       verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
//       familyMember: json["familyMember"] == null ? null : FamilyMember.fromJson(json["familyMember"]),
//       totalEarning: json["totalEarning"],
//       experience: json["experience"],
//       averageRating: json["AverageRating"],
//       reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
//       avgRatings: json["avgRatings"],
//       popularity: json["popularity"],
//       fiftyPercentOffDeliveryFeeAfterWaivedTrips: json["fiftyPercentOffDeliveryFeeAfterWaivedTrips"],
//       scheduledDelivery: json["scheduledDelivery"],
//       fuelPriceTrackingAlerts: json["fuelPriceTrackingAlerts"],
//       noExtraChargeForEmergencyFuelServiceLimit: json["noExtraChargeForEmergencyFuelServiceLimit"],
//       freeSubscriptionAdditionalFamilyMember: json["freeSubscriptionAdditionalFamilyMember"],
//       exclusivePromotionsEarlyAccess: json["exclusivePromotionsEarlyAccess"],
//       id: json["_id"],
//       status: json["status"],
//       fullname: json["fullname"],
//       location: json["location"],
//       country: json["country"],
//       zipCode: json["zipCode"],
//       email: json["email"],
//       phoneNumber: json["phoneNumber"],
//       password: json["password"],
//       gender: json["gender"],
//       dateOfBirth: json["dateOfBirth"],
//       isGoogleLogin: json["isGoogleLogin"],
//       image: json["image"],
//       role: json["role"],
//       address: json["address"],
//       freeDeliverylimit: json["freeDeliverylimit"],
//       coverVehiclelimit: json["coverVehiclelimit"],
//       durationDay: DateTime.tryParse(json["durationDay"] ?? ""),
//       isDeleted: json["isDeleted"],
//       createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
//       v: json["__v"],
//       remeningDurationDay: json["remeningDurationDay"],
//     );
//   }
//
// }
//
// class FamilyMember {
//   FamilyMember({
//     required this.name,
//     required this.email,
//   });
//
//   final String? name;
//   final String? email;
//
//   factory FamilyMember.fromJson(Map<String, dynamic> json){
//     return FamilyMember(
//       name: json["name"],
//       email: json["email"],
//     );
//   }
//
// }
//
// class Verification {
//   Verification({
//     required this.otp,
//     required this.expiresAt,
//     required this.status,
//   });
//
//   final dynamic otp;
//   final DateTime? expiresAt;
//   final bool? status;
//
//   factory Verification.fromJson(Map<String, dynamic> json){
//     return Verification(
//       otp: json["otp"],
//       expiresAt: DateTime.tryParse(json["expiresAt"] ?? ""),
//       status: json["status"],
//     );
//   }
//
// }
//
// class Meta {
//   Meta({
//     required this.page,
//     required this.limit,
//     required this.total,
//     required this.totalPage,
//   });
//
//   final dynamic page;
//   final dynamic limit;
//   final dynamic total;
//   final dynamic totalPage;
//
//   factory Meta.fromJson(Map<String, dynamic> json){
//     return Meta(
//       page: json["page"],
//       limit: json["limit"],
//       total: json["total"],
//       totalPage: json["totalPage"],
//     );
//   }
//
// }


class AssignedOrderModel {
  AssignedOrderModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory AssignedOrderModel.fromJson(Map<String, dynamic> json){
    return AssignedOrderModel(
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
    required this.location,
    required this.id,
    required this.vehicleId,
    required this.userId,
    required this.amount,
    required this.deliveryFee,
    required this.price,
    required this.presetAmount,
    required this.customAmount,
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
    required this.rejectedBy,
    required this.radiusIncrement,
    required this.searchRadius,
    required this.maxRadius,
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
  final int? amount;
  final int? deliveryFee;
  final double? price;
  final bool? presetAmount;
  final bool? customAmount;
  final String? orderType;
  final String? orderStatus;
  final String? cancelReason;
  final String? fuelType;
  final bool? isPaid;
  final double? finalAmountOfPayment;
  final String? zipCode;
  final int? servicesFee;
  final String? proofImage;
  final bool? emergency;
  final String? schedulDate;
  final dynamic schedulTime;
  final String? emergencyTime;
  final String? cuponCode;
  final List<dynamic> rejectedBy;
  final int? radiusIncrement;
  final int? searchRadius;
  final int? maxRadius;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? paymentId;
  final String? driverId;
  final String? deleveryId;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      id: json["_id"],
      vehicleId: json["vehicleId"],
      userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
      amount: json["amount"],
      deliveryFee: json["deliveryFee"],
      price: (json["price"] is int) ? (json["price"] as int).toDouble() : json["price"] as double?,
      presetAmount: json["presetAmount"],
      customAmount: json["customAmount"],
      orderType: json["orderType"],
      orderStatus: json["orderStatus"],
      cancelReason: json["cancelReason"],
      fuelType: json["fuelType"],
      isPaid: json["isPaid"],
      finalAmountOfPayment: (json["finalAmountOfPayment"] is int)
          ? (json["finalAmountOfPayment"] as int).toDouble()
          : json["finalAmountOfPayment"] as double?,
      zipCode: json["zipCode"],
      servicesFee: json["servicesFee"],
      proofImage: json["proofImage"],
      emergency: json["emergency"],
      schedulDate: json["schedulDate"],
      schedulTime: json["schedulTime"],
      emergencyTime: json["emergencyTime"],
      cuponCode: json["cuponCode"],
      rejectedBy: json["rejectedBy"] == null ? [] : List<dynamic>.from(json["rejectedBy"]!.map((x) => x)),
      radiusIncrement: json["radiusIncrement"],
      searchRadius: json["searchRadius"],
      maxRadius: json["maxRadius"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      paymentId: json["paymentId"],
      driverId: json["driverId"],
      deleveryId: json["deleveryId"],
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
    required this.geoLocation,
    required this.verification,
    required this.familyMember,
    required this.id,
    required this.status,
    required this.fullname,
    required this.location,
    required this.currentStatus,
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

  final Location? geoLocation;
  final Verification? verification;
  final FamilyMember? familyMember;
  final String? id;
  final String? status;
  final String? fullname;
  final String? location;
  final String? currentStatus;
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

  factory UserId.fromJson(Map<String, dynamic> json){
    return UserId(
      geoLocation: json["geoLocation"] == null ? null : Location.fromJson(json["geoLocation"]),
      verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
      familyMember: json["familyMember"] == null ? null : FamilyMember.fromJson(json["familyMember"]),
      id: json["_id"],
      status: json["status"],
      fullname: json["fullname"],
      location: json["location"],
      currentStatus: json["currentStatus"],
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

class Verification {
  Verification({
    required this.otp,
    required this.expiresAt,
    required this.status,
  });

  final dynamic? otp;
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

class Meta {
  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPage: json["totalPage"],
    );
  }

}
