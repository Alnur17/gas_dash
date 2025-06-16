class AllFriendModel {
  AllFriendModel({
     this.success,
     this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<Friends> data;

  factory AllFriendModel.fromJson(Map<String, dynamic> json){
    return AllFriendModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Friends>.from(json["data"]!.map((x) => Friends.fromJson(x))),
    );
  }

}

class Friends {
  Friends({
    required this.chat,
    required this.message,
    required this.unreadMessageCount,
  });

  final Chat? chat;
  final Message? message;
  final int? unreadMessageCount;

  factory Friends.fromJson(Map<String, dynamic> json){
    return Friends(
      chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
      message: json["message"] == null ? null : Message.fromJson(json["message"]),
      unreadMessageCount: json["unreadMessageCount"],
    );
  }

}

class Chat {
  Chat({
    required this.id,
    required this.participants,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final List<Participant> participants;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Chat.fromJson(Map<String, dynamic> json){
    return Chat(
      id: json["_id"],
      participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class Participant {
  Participant({
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

  factory Participant.fromJson(Map<String, dynamic> json){
    return Participant(
      id: json["_id"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      image: json["image"],
      role: json["role"],
    );
  }

}

class Message {
  Message({
    required this.id,
    required this.text,
    required this.seen,
    required this.sender,
    required this.receiver,
    required this.chat,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? text;
  final bool? seen;
  final String? sender;
  final String? receiver;
  final String? chat;
  final List<dynamic> imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Message.fromJson(Map<String, dynamic> json){
    return Message(
      id: json["_id"],
      text: json["text"],
      seen: json["seen"],
      sender: json["sender"],
      receiver: json["receiver"],
      chat: json["chat"],
      imageUrl: json["imageUrl"] == null ? [] : List<dynamic>.from(json["imageUrl"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
