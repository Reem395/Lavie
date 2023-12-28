import 'package:flutter_hackathon/models/forum_model/forum_like.dart';

class ForumLikeResponse {
  String? type;
  String? message;
  ForumLike? data;

  ForumLikeResponse({this.type, this.message, this.data});

  factory ForumLikeResponse.fromJson(Map<String, dynamic> json) =>
      ForumLikeResponse(
        type: json['type']?.toString(),
        message: json['message']?.toString(),
        data: json['data'] == null
            ? null
            : ForumLike.fromJson(Map<String, dynamic>.from(json['data'])),
      );

  Map<String, dynamic> toJson() => {
        if (type != null) 'type': type,
        if (message != null) 'message': message,
        if (data != null) 'data': data?.toJson(),
      };
}
