import 'forum_comment.dart';
class ForumCommentResponse {
  String? type;
  String? message;
  ForumComment? data;

  ForumCommentResponse({this.type, this.message, this.data});

  factory ForumCommentResponse.fromJson(Map<String, dynamic> json) => ForumCommentResponse(
        type: json['type']?.toString(),
        message: json['message']?.toString(),
        data: json['data'] == null
            ? null
            : ForumComment.fromJson(Map<String, dynamic>.from(json['data'])),
      );

  Map<String, dynamic> toJson() => {
        if (type != null) 'type': type,
        if (message != null) 'message': message,
        if (data != null) 'data': data?.toJson(),
      };
}
