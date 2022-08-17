import 'user.dart';

class Data {
  User? user;
  String? accessToken;
  String? refreshToken;

  Data({this.user, this.accessToken, this.refreshToken});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        accessToken: json['accessToken'] as String?,
        refreshToken: json['refreshToken'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}
