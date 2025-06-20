class SingleOrderByIdModel {
  SingleOrderByIdModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final SingleOrderData? data;

  factory SingleOrderByIdModel.fromJson(Map<String, dynamic> json){
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
    required this.proofImage,
    required this.id,
    required this.vehicleId,
    required this.userId,
    required this.deliveryFee,
    required this.price,
    required this.presetAmount,
    required this.customAmount,
    required this.tip,
    required this.orderType,
    required this.orderStatus,
    required this.cancelReason,
    required this.isPaid,
    required this.finalAmountOfPayment,
    required this.zipCode,
    required this.servicesFee,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.paymentId,
    required this.driverId,
  });

  final Location? location;
  final String? proofImage;
  final String? id;
  final String? vehicleId;
  final UserId? userId;
  final double? deliveryFee;
  final double? price;
  final bool? presetAmount;
  final bool? customAmount;
  final double? tip;
  final String? orderType;
  final String? orderStatus;
  final String? cancelReason;
  final bool? isPaid;
  final double? finalAmountOfPayment;
  final String? zipCode;
  final double? servicesFee;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? v;
  final String? paymentId;
  final DriverId? driverId;

  factory SingleOrderData.fromJson(Map<String, dynamic> json) {
    return SingleOrderData(
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      proofImage: json["proofImage"],
      id: json["_id"],
      vehicleId: json["vehicleId"],
      userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
      deliveryFee: json["deliveryFee"] is int ? (json["deliveryFee"] as int).toDouble() : json["deliveryFee"],
      price: json["price"] is int ? (json["price"] as int).toDouble() : json["price"],
      presetAmount: json["presetAmount"],
      customAmount: json["customAmount"],
      tip: json["tip"] is int ? (json["tip"] as int).toDouble() : json["tip"],
      orderType: json["orderType"],
      orderStatus: json["orderStatus"],
      cancelReason: json["cancelReason"],
      isPaid: json["isPaid"],
      finalAmountOfPayment: json["finalAmountOfPayment"] is int ? (json["finalAmountOfPayment"] as int).toDouble() : json["finalAmountOfPayment"],
      zipCode: json["zipCode"],
      servicesFee: json["servicesFee"] is int ? (json["servicesFee"] as int).toDouble() : json["servicesFee"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] is int ? (json["__v"] as int).toDouble() : json["__v"],
      paymentId: json["paymentId"],
      driverId: json["driverId"] == null ? null : DriverId.fromJson(json["driverId"]),
    );
  }
}

class DriverId {
  DriverId({
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
    required this.passwordChangedAt,
  });

  final DriverIdVerification? verification;
  final dynamic experience;
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
  final dynamic address;
  final dynamic freeDeliverylimit;
  final dynamic coverVehiclelimit;
  final dynamic durationDay;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic v;
  final DateTime? passwordChangedAt;

  factory DriverId.fromJson(Map<String, dynamic> json){
    return DriverId(
      verification: json["verification"] == null ? null : DriverIdVerification.fromJson(json["verification"]),
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
      passwordChangedAt: DateTime.tryParse(json["passwordChangedAt"] ?? ""),
    );
  }

}

class DriverIdVerification {
  DriverIdVerification({
    required this.otp,
    required this.status,
  });

  final dynamic otp;
  final bool? status;

  factory DriverIdVerification.fromJson(Map<String, dynamic> json){
    return DriverIdVerification(
      otp: json["otp"],
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
  final dynamic experience;
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
  final dynamic durationDay;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic v;

  factory UserId.fromJson(Map<String, dynamic> json){
    return UserId(
      verification: json["verification"] == null ? null : UserIdVerification.fromJson(json["verification"]),
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

class UserIdVerification {
  UserIdVerification({
    required this.otp,
    required this.expiresAt,
    required this.status,
  });

  final dynamic otp;
  final DateTime? expiresAt;
  final bool? status;

  factory UserIdVerification.fromJson(Map<String, dynamic> json){
    return UserIdVerification(
      otp: json["otp"],
      expiresAt: DateTime.tryParse(json["expiresAt"] ?? ""),
      status: json["status"],
    );
  }

}
