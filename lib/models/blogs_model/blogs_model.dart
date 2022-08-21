import 'blogs.dart';

class BlogsModel {
  String? type;
  String? message;
  Blogs? data;

  BlogsModel({this.type, this.message, this.data});

  factory BlogsModel.fromJson(Map<String, dynamic> json) => BlogsModel(
        type: json['type'] as String?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : Blogs.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'data': data?.toJson(),
      };
}
