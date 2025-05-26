class FuelInfoModel {
  FuelInfoModel({
    required this.status,
    required this.results,
    required this.data,
  });

  final String? status;
  final int? results;
  final List<Datum> data;

  factory FuelInfoModel.fromJson(Map<String, dynamic> json){
    return FuelInfoModel(
      status: json["status"],
      results: json["results"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.fuelName,
    required this.fuelPrice,
    required this.zipCode,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? fuelName;
  final double? fuelPrice;
  final List<String> zipCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      fuelName: json["fuelName"],
      fuelPrice: json["fuelPrice"],
      zipCode: json["zipCode"] == null ? [] : List<String>.from(json["zipCode"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
