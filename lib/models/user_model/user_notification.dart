class UserNotification {
  String? notificationId;
  String? userId;
  String? imageUrl;
  String? message;
  DateTime? createdAt;

  UserNotification({
    this.notificationId,
    this.userId,
    this.imageUrl,
    this.message,
    this.createdAt,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      notificationId: json['notificationId'] as String?,
      userId: json['userId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      message: json['message'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'notificationId': notificationId,
        'userId': userId,
        'imageUrl': imageUrl,
        'message': message,
        'createdAt': createdAt?.toIso8601String(),
      };
}
