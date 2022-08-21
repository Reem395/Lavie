import 'package:flutter_hackathon/models/forum_model/forum.dart';
import 'package:flutter_hackathon/models/user_model/user.dart';

class ForumLike {
    String? forumId ;
    String? userId ;
  ForumLike({
      this.forumId,this.userId
  });

  factory ForumLike.fromJson(Map<String, dynamic> json) =>ForumLike(
        forumId :json['forumId']as String,
        userId :json['userId']as String,
  );

  Map<String, dynamic> toJson()=> {
    // TODO: implement toJson
   'forumId':forumId,
   'userId':userId
  };
}
//  "ForumLikes": [
//                 {
//                     "forumId": "0271f5df-7522-48ee-9157-40fa75bd7c3c",
//                     "userId": "1863ad5c-7a66-48bc-bea6-c81b31905032"
//                 }
//             ],