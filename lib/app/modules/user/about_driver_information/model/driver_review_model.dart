class DriverReviewModel {
  DriverReviewModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory DriverReviewModel.fromJson(Map<String, dynamic> json) {
    return DriverReviewModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.driverId,
    required this.userId,
    required this.rating,
    required this.review,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final DriverId? driverId;
  final dynamic userId;
  final double? rating;
  final String? review;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["_id"],
      driverId: json["driverId"] == null ? null : DriverId.fromJson(json["driverId"]),
      userId: json["userId"],
      rating: json["rating"]?.toDouble(), // Ensure rating is double
      review: json["review"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
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

  final Verification? verification;
  final int? experience;
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
  final double? freeDeliverylimit; // Changed to double
  final double? coverVehiclelimit; // Changed to double
  final int? durationDay;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final DateTime? passwordChangedAt;

  factory DriverId.fromJson(Map<String, dynamic> json) {
    return DriverId(
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
      freeDeliverylimit: json["freeDeliverylimit"]?.toDouble(), // Convert to double
      coverVehiclelimit: json["coverVehiclelimit"]?.toDouble(), // Convert to double
      durationDay: json["durationDay"],
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

  factory Verification.fromJson(Map<String, dynamic> json) {
    return Verification(
      otp: json["otp"],
      status: json["status"],
    );
  }
}