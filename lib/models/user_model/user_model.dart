import 'data.dart';

class UserModel {
  String? type;
  String? message;
  Data? data;

  UserModel({this.type, this.message, this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        type: json['type'] as String?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'data': data?.toJson(),
      };
}
