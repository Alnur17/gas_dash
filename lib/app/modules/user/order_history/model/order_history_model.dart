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
    required this.createdAt,
    required this.updatedAt,
    required this.paymentId,
    required this.driverId,
  });

  final Location? location;
  final String? id;
  final String? vehicleId;
  final UserId? userId;
  final double? amount; // Changed from int? to double?
  final double? deliveryFee;
  final double? price;
  final bool? presetAmount;
  final bool? customAmount;
  final double? tip; // Changed from int? to double?
  final String? orderType;
  final String? orderStatus;
  final String? cancelReason;
  final String? fuelType;
  final bool? isPaid;
  final double? finalAmountOfPayment;
  final String? zipCode;
  final double? servicesFee;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? paymentId;
  final String? driverId;

  factory OrderHistoryDatum.fromJson(Map<String, dynamic> json) {
    return OrderHistoryDatum(
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      id: json["_id"],
      vehicleId: json["vehicleId"],
      userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
      amount: (json["amount"] as num?)?.toDouble(), // Convert to double
      deliveryFee: (json["deliveryFee"] as num?)?.toDouble(), // Ensure double
      price: (json["price"] as num?)?.toDouble(), // Ensure double
      presetAmount: json["presetAmount"],
      customAmount: json["customAmount"],
      tip: (json["tip"] as num?)?.toDouble(), // Convert to double
      orderType: json["orderType"],
      orderStatus: json["orderStatus"],
      cancelReason: json["cancelReason"],
      fuelType: json["fuelType"],
      isPaid: json["isPaid"],
      finalAmountOfPayment: (json["finalAmountOfPayment"] as num?)?.toDouble(), // Ensure double
      zipCode: json["zipCode"],
      servicesFee: (json["servicesFee"] as num?)?.toDouble(), // Ensure double
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      paymentId: json["paymentId"],
      driverId: json["driverId"],
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

  final Verification? verification;
  final int? experience;
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
  final int? freeDeliverylimit;
  final int? coverVehiclelimit;
  final int? durationDay;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory UserId.fromJson(Map<String, dynamic> json){
    return UserId(
      verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
      experience: json["experience"],
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
      durationDay: json["durationDay"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
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
