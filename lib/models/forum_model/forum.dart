import 'forum_like.dart';

class Forum {
  String? forumId;
  String? title;
  String? description;
  String? imageUrl;
  String? userId;
  List<ForumLike>? forumLikes;
  List<dynamic>? forumComments;

  Forum({
    this.forumId,
    this.title,
    this.description,
    this.imageUrl,
    this.userId,
    this.forumLikes,
    this.forumComments,
  });

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
        forumId: json['forumId'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        imageUrl: json['imageUrl'] as String?,
        userId: json['userId'] as String?,
        forumLikes: (json['ForumLikes'] as List<dynamic>?)
            ?.map((e) => ForumLike.fromJson(e as Map<String, dynamic>))
            .toList(),
        forumComments: json['ForumComments'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'forumId': forumId,
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'userId': userId,
        'ForumLikes': forumLikes?.map((e) => e.toJson()).toList(),
        'ForumComments': forumComments,
      };
}
