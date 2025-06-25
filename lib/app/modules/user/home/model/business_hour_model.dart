class BusinessHourModel {
  BusinessHourModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;

  factory BusinessHourModel.fromJson(Map<String, dynamic> json){
    return BusinessHourModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.id,
    required this.userType,
    required this.v,
    required this.createdAt,
    required this.day,
    required this.time,
    required this.updatedAt,
  });

  final String? id;
  final String? userType;
  final int? v;
  final DateTime? createdAt;
  final String? day;
  final String? time;
  final DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["_id"],
      userType: json["userType"],
      v: json["__v"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      day: json["day"],
      time: json["time"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
