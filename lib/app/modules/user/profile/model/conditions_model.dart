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
    required this.emergencyFuelBanner,
    required this.discountBanner,
    required this.id,
    required this.v,
    required this.createdAt,
    required this.privacyPolicy,
    required this.updatedAt,
    required this.termsConditions,
  });

  final String? emergencyFuelBanner;
  final String? discountBanner;
  final String? id;
  final int? v;
  final DateTime? createdAt;
  final String? privacyPolicy;
  final DateTime? updatedAt;
  final String? termsConditions;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      emergencyFuelBanner: json["emergencyFuelBanner"],
      discountBanner: json["discountBanner"],
      id: json["_id"],
      v: json["__v"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      privacyPolicy: json["privacy_policy"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      termsConditions: json["terms_conditions"],
    );
  }

}
