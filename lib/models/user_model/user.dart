import 'user_notification.dart';

class User {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
  dynamic address;
  String? role;
  dynamic userPoints;
  List<UserNotification>? userNotification;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.imageUrl,
    this.address,
    this.role,
    this.userPoints,
    this.userNotification,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['userId'] as String?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        email: json['email'] as String?,
        imageUrl: json['imageUrl'] as String?,
        address: json['address'] as dynamic,
        role: json['role'] as String?,
        userPoints: json['UserPoints'] as dynamic,
        userNotification: (json['UserNotification'] as List<dynamic>?)
            ?.map((e) => UserNotification.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'imageUrl': imageUrl,
        'address': address,
        'role': role,
        'UserPoints': userPoints,
        'UserNotification': userNotification?.map((e) => e.toJson()).toList(),
      };
}
