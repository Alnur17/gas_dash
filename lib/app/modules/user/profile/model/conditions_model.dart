class ConditionsModel {
  ConditionsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory ConditionsModel.fromJson(Map<String, dynamic> json){
    return ConditionsModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.v,
    required this.createdAt,
    required this.discountBanner,
    required this.emergencyFuelBanner,
    required this.updatedAt,
    required this.orderHistoryBanner,
    required this.fuelTypeBanner,
    required this.privacyPolicy,
    required this.termsConditions,
  });

  final String? id;
  final int? v;
  final DateTime? createdAt;
  final String? discountBanner;
  final String? emergencyFuelBanner;
  final DateTime? updatedAt;
  final String? orderHistoryBanner;
  final String? fuelTypeBanner;
  final String? privacyPolicy;
  final String? termsConditions;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      v: json["__v"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      discountBanner: json["discountBanner"],
      emergencyFuelBanner: json["emergencyFuelBanner"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      orderHistoryBanner: json["orderHistoryBanner"],
      fuelTypeBanner: json["fuelTypeBanner"],
      privacyPolicy: json["privacy_policy"],
      termsConditions: json["terms_conditions"],
    );
  }

}
