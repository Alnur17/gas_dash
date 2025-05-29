class FinalConfirmationModel {
  FinalConfirmationModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory FinalConfirmationModel.fromJson(Map<String, dynamic> json){
    return FinalConfirmationModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
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
    required this.v,
  });

  final Location? location;
  final String? id;
  final String? vehicleId;
  final UserId? userId;
  final int? amount;
  final double? deliveryFee;
  final double? price;
  final bool? presetAmount;
  final bool? customAmount;
  final int? tip;
  final String? orderType;
  final String? orderStatus;
  final String? cancelReason;
  final String? fuelType;
  final bool? isPaid;
  final double? finalAmountOfPayment;
  final String? zipCode;
  final int? servicesFee;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      location: json["location"] == null ? null : Location.fromJson(json["location"]),
      id: json["_id"],
      vehicleId: json["vehicleId"],
      userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
      amount: json["amount"],
      deliveryFee: json["deliveryFee"] is String
          ? double.tryParse(json["deliveryFee"])
          : (json["deliveryFee"] as num?)?.toDouble(),
      price: json["price"] is String
          ? double.tryParse(json["price"])
          : (json["price"] as num?)?.toDouble(),
      presetAmount: json["presetAmount"],
      customAmount: json["customAmount"],
      tip: json["tip"],
      orderType: json["orderType"],
      orderStatus: json["orderStatus"],
      cancelReason: json["cancelReason"],
      fuelType: json["fuelType"],
      isPaid: json["isPaid"],
      finalAmountOfPayment: json["finalAmountOfPayment"] is String
          ? double.tryParse(json["finalAmountOfPayment"])
          : (json["finalAmountOfPayment"] as num?)?.toDouble(),
      zipCode: json["zipCode"],
      servicesFee: json["servicesFee"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
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

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      type: json["type"],
      coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
    );
  }

}

class UserId {
  UserId({
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
    required this.address,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.passwordChangedAt,
  });

  final Verification? verification;
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
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final DateTime? passwordChangedAt;

  factory UserId.fromJson(Map<String, dynamic> json){
    return UserId(
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
      address: json["address"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      passwordChangedAt: DateTime.tryParse(json["passwordChangedAt"] ?? ""),
    );
  }

}

class Verification {
  Verification({
    required this.otp,
    required this.status,
  });

  final int? otp;
  final bool? status;

  factory Verification.fromJson(Map<String, dynamic> json){
    return Verification(
      otp: json["otp"],
      status: json["status"],
    );
  }

}
