class MessageModel {
  String type;
  int messageId;
  String message;
  DateTime createdAt;
  String userId;
  String nickname;
  bool isActive;

  MessageModel({
    required this.type,
    required this.messageId,
    required this.message,
    required this.createdAt,
    required this.userId,
    required this.nickname,
    required this.isActive,
  });
}