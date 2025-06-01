class AssignedOrderModel {
  AssignedOrderModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory AssignedOrderModel.fromJson(Map<String, dynamic> json) {
    return AssignedOrderModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    required this.location,
    required this.id,
    required this.vehicleId,
    required this.userId,
    required this.deliveryFee,
    required this.price,
    required this.presetAmount,
    required this.customAmount,
    required this.tip,
    required this.orderType,
    required this.orderStatus,
    required this.cancelReason,
    required this.isPaid,
    required this.finalAmountOfPayment,
    required this.zipCode,
    required this.servicesFee,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.paymentId,
    required this.driverId,
  });

  final Location? location;
  final String? id;
  final String? vehicleId;
  final String? userId;
  final double? deliveryFee;
  final double? price;
  final bool? presetAmount;
  final bool? customAmount;
  final double? tip;
  final String? orderType;
  final String? orderStatus;
  final String? cancelReason;
  final bool? isPaid;
  final double? finalAmountOfPayment;
  final String? zipCode;
  final double? servicesFee;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? paymentId;
  final String? driverId;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      id: json["_id"],
      vehicleId: json["vehicleId"],
      userId: json["userId"],
      deliveryFee: (json["deliveryFee"] is int)
          ? (json["deliveryFee"] as int).toDouble()
          : json["deliveryFee"],
      price: (json["price"] is int)
          ? (json["price"] as int).toDouble()
          : json["price"],
      // Handle int to double conversion
      presetAmount: json["presetAmount"],
      customAmount: json["customAmount"],
      tip: (json["tip"] is int) ? (json["tip"] as int).toDouble() : json["tip"],
      // Handle int to double conversion
      orderType: json["orderType"],
      orderStatus: json["orderStatus"],
      cancelReason: json["cancelReason"],
      isPaid: json["isPaid"],
      finalAmountOfPayment: (json["finalAmountOfPayment"] is int)
          ? (json["finalAmountOfPayment"] as int).toDouble()
          : json["finalAmountOfPayment"],
      zipCode: json["zipCode"],
      servicesFee: (json["servicesFee"] is int)
          ? (json["servicesFee"] as int).toDouble()
          : json["servicesFee"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      paymentId: json["paymentId"],
      driverId: json["driverId"],
    );
  }
}

class Location {
  Location({
    required this.coordinates,
    required this.type,
  });

  final List<double> coordinates;
  final String? type;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: json["coordinates"] == null
          ? []
          : List<double>.from(
              json["coordinates"]!.map((x) => (x is int) ? x.toDouble() : x)),
      type: json["type"],
    );
  }
}
