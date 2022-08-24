import 'Forum.dart';

class ForumModel {
  String? type;
  String? message;
  List<Forum>? data;

  ForumModel({this.type, this.message, this.data});

  factory ForumModel.fromJson(Map<String, dynamic> json) => ForumModel(
        type: json['type'] as String?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Forum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
