class SingleDriverEarningModel {
  SingleDriverEarningModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory SingleDriverEarningModel.fromJson(Map<String, dynamic> json) {
    return SingleDriverEarningModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.todayEarnings,
    required this.totalEarnings,
  });

  final double? todayEarnings;
  final double? totalEarnings;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      todayEarnings: (json["todayEarnings"] is int)
          ? (json["todayEarnings"] as int).toDouble()
          : json["todayEarnings"]?.toDouble(),
      totalEarnings: (json["totalEarnings"] is int)
          ? (json["totalEarnings"] as int).toDouble()
          : json["totalEarnings"]?.toDouble(),
    );
  }
}