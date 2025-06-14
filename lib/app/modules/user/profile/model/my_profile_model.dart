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

  final Verification? verification;
  final double? totalEarning;
  final int? experience;
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
  final int? freeDeliverylimit;
  final int? coverVehiclelimit;
  final int? durationDay;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final DateTime? passwordChangedAt;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
      totalEarning: (json["totalEarnings"] is int)
          ? (json["totalEarnings"] as int).toDouble()
          : json["totalEarnings"]?.toDouble(),
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
