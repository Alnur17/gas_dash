class ChatMessagesModel {
  ChatMessagesModel({
     this.success,
     this.message,
     this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory ChatMessagesModel.fromJson(Map<String, dynamic> json){
    return ChatMessagesModel(
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

  final List<ChatMessage> data;
  final Meta? meta;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      data: json["data"] == null ? [] : List<ChatMessage>.from(json["data"]!.map((x) => ChatMessage.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

}

class ChatMessage {
  ChatMessage({
    required this.id,
    required this.text,
    required this.seen,
    required this.sender,
    required this.receiver,
    required this.chat,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? text;
  final bool? seen;
  final Receiver? sender;
  final Receiver? receiver;
  final String? chat;
  final List<dynamic> imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ChatMessage.fromJson(Map<String, dynamic> json){
    return ChatMessage(
      id: json["_id"],
      text: json["text"],
      seen: json["seen"],
      sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
      receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
      chat: json["chat"],
      imageUrl: json["imageUrl"] == null ? [] : List<dynamic>.from(json["imageUrl"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}

class Receiver {
  Receiver({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.image,
    required this.role,
  });

  final String? id;
  final String? email;
  final dynamic phoneNumber;
  final dynamic image;
  final String? role;

  factory Receiver.fromJson(Map<String, dynamic> json){
    return Receiver(
      id: json["_id"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      image: json["image"],
      role: json["role"],
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
