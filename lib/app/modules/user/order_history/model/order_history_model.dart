class OrderHistoryModel {
  OrderHistoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
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

  factory Data.fromJson(Map<String, dynamic> json) {
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
  final UserId? userId;
  final double? amount;
  final double? deliveryFee;
  final double? price;
  final bool? presetAmount;
  final bool? customAmount;
  final double? tip;
  final String? orderType;
  final String? orderStatus;
  final String? cancelReason;
  final String? fuelType;
  final bool? isPaid;
  final double? finalAmountOfPayment;
  final String? zipCode;
  final double? servicesFee;
  final String? proofImage;
  final bool? emergency;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? paymentId;
  final DriverId? driverId;
  final String? deleveryId;

  factory OrderHistoryDatum.fromJson(Map<String, dynamic> json) {
    return OrderHistoryDatum(
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      id: json["_id"],
      vehicleId: json["vehicleId"],
      userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
      amount: (json["amount"] is int)
          ? (json["amount"] as int).toDouble()
          : json["amount"]?.toDouble(),
      deliveryFee: (json["deliveryFee"] is int)
          ? (json["deliveryFee"] as int).toDouble()
          : json["deliveryFee"]?.toDouble(),
      price: (json["price"] is int)
          ? (json["price"] as int).toDouble()
          : json["price"]?.toDouble(),
      presetAmount: json["presetAmount"],
      customAmount: json["customAmount"],
      tip: (json["tip"] is int)
          ? (json["tip"] as int).toDouble()
          : json["tip"]?.toDouble(),
      orderType: json["orderType"],
      orderStatus: json["orderStatus"],
      cancelReason: json["cancelReason"],
      fuelType: json["fuelType"],
      isPaid: json["isPaid"],
      finalAmountOfPayment: (json["finalAmountOfPayment"] is int)
          ? (json["finalAmountOfPayment"] as int).toDouble()
          : json["finalAmountOfPayment"]?.toDouble(),
      zipCode: json["zipCode"],
      servicesFee: (json["servicesFee"] is int)
          ? (json["servicesFee"] as int).toDouble()
          : json["servicesFee"]?.toDouble(),
      proofImage: json["proofImage"],
      emergency: json["emergency"],
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
    required this.totalEarning,
    required this.experience,
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
    required this.passwordChangedAt,
  });

  final DriverIdVerification? verification;
  final double? totalEarning;
  final double? experience;
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
  final dynamic address;
  final double? freeDeliverylimit;
  final double? coverVehiclelimit;
  final double? durationDay;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? v;
  final DateTime? passwordChangedAt;

  factory DriverId.fromJson(Map<String, dynamic> json) {
    return DriverId(
      verification: json["verification"] == null ? null : DriverIdVerification.fromJson(json["verification"]),
      totalEarning: (json["totalEarning"] is int)
          ? (json["totalEarning"] as int).toDouble()
          : json["totalEarning"]?.toDouble(),
      experience: (json["experience"] is int)
          ? (json["experience"] as int).toDouble()
          : json["experience"]?.toDouble(),
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
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: (json["__v"] is int)
          ? (json["__v"] as int).toDouble()
          : json["__v"]?.toDouble(),
      passwordChangedAt: DateTime.tryParse(json["passwordChangedAt"] ?? ""),
    );
  }
}

class DriverIdVerification {
  DriverIdVerification({
    required this.otp,
    required this.status,
  });

  final double? otp;
  final bool? status;

  factory DriverIdVerification.fromJson(Map<String, dynamic> json) {
    return DriverIdVerification(
      otp: (json["otp"] is int)
          ? (json["otp"] as int).toDouble()
          : json["otp"]?.toDouble(),
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

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
      type: json["type"],
    );
  }
}

class UserId {
  UserId({
    required this.verification,
    required this.totalEarning,
    required this.experience,
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
  });

  final UserIdVerification? verification;
  final double? totalEarning;
  final double? experience;
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
  final dynamic address;
  final double? freeDeliverylimit;
  final double? coverVehiclelimit;
  final double? durationDay;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? v;

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      verification: json["verification"] == null ? null : UserIdVerification.fromJson(json["verification"]),
      totalEarning: (json["totalEarning"] is int)
          ? (json["totalEarning"] as int).toDouble()
          : json["totalEarning"]?.toDouble(),
      experience: (json["experience"] is int)
          ? (json["experience"] as int).toDouble()
          : json["experience"]?.toDouble(),
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
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: (json["__v"] is int)
          ? (json["__v"] as int).toDouble()
          : json["__v"]?.toDouble(),
    );
  }
}

class UserIdVerification {
  UserIdVerification({
    required this.otp,
    required this.expiresAt,
    required this.status,
  });

  final double? otp;
  final DateTime? expiresAt;
  final bool? status;

  factory UserIdVerification.fromJson(Map<String, dynamic> json) {
    return UserIdVerification(
      otp: (json["otp"] is int)
          ? (json["otp"] as int).toDouble()
          : json["otp"]?.toDouble(),
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

  final double? page;
  final double? limit;
  final double? total;
  final double? totalPage;

  factory Meta.fromJson(Map<String, dynamic> json) {
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