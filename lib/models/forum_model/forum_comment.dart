class ForumComment {
  String? forumCommentId;
  String? forumId;
  String? userId;
  String? comment;
  String? createdAt;

  ForumComment(
      {this.forumCommentId,
      this.forumId,
      this.userId,
      this.comment,
      this.createdAt});

  factory ForumComment.fromJson(Map<String, dynamic> json) => ForumComment(
        forumCommentId: json['forumCommentId'] as String,
        forumId: json['forumId'] as String,
        userId: json['userId'] as String,
        comment: json['comment'] as String,
        createdAt: json['createdAt'] as String,
      );

  Map<String, dynamic> toJson() => {
        'forumCommentId': forumCommentId,
        'forumId': forumId,
        'userId': userId,
        'comment': comment,
        'createdAt': createdAt,
      };
}
