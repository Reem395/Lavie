class ForumLike {
  String? forumId;
  String? userId;
  ForumLike({this.forumId, this.userId});

  factory ForumLike.fromJson(Map<String, dynamic> json) => ForumLike(
        forumId: json['forumId'] as String?,
        userId: json['userId'] as String?,
      );

  Map<String, dynamic> toJson() => {'forumId': forumId, 'userId': userId};
}
