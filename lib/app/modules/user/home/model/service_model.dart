class ServiceModel {
  ServiceModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory ServiceModel.fromJson(Map<String, dynamic> json){
    return ServiceModel(
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

  final List<ServiceData> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<ServiceData>.from(json["data"]!.map((x) => ServiceData.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

}

class ServiceData {
  ServiceData({
    required this.id,
    required this.serviceName,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? serviceName;
  final double? price;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ServiceData.fromJson(Map<String, dynamic> json){
    return ServiceData(
      id: json["_id"],
      serviceName: json["serviceName"],
      price: (json["price"] is int)
          ? (json["price"] as int).toDouble()
          : json["price"]?.toDouble(),
      status: json["status"],
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
