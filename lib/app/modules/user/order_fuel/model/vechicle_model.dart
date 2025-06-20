class VehicleModel {
  VehicleModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory VehicleModel.fromJson(Map<String, dynamic> json){
    return VehicleModel(
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

  final List<VehicleListData> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<VehicleListData>.from(json["data"]!.map((x) => VehicleListData.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

}

class VehicleListData {
  VehicleListData({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.fuelLevel,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? make;
  final String? model;
  final int? year;
  final int? fuelLevel;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory VehicleListData.fromJson(Map<String, dynamic> json){
    return VehicleListData(
      id: json["_id"],
      make: json["make"],
      model: json["model"],
      year: json["year"],
      fuelLevel: json["fuelLevel"],
      userId: json["userId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
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
