class CouponModel {
  CouponModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory CouponModel.fromJson(Map<String, dynamic> json){
    return CouponModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.isActive,
    required this.id,
    required this.applicableOn,
    required this.couponName,
    required this.expiryDate,
    required this.couponCode,
    required this.discount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final bool? isActive;
  final String? id;
  final String? applicableOn;
  final String? couponName;
  final DateTime? expiryDate;
  final String? couponCode;
  final int? discount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      isActive: json["isActive"],
      id: json["_id"],
      applicableOn: json["applicableOn"],
      couponName: json["couponName"],
      expiryDate: DateTime.tryParse(json["expiryDate"] ?? ""),
      couponCode: json["couponCode"],
      discount: json["discount"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
