import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/forum_model/forum.dart';
import '../../models/forum_model/forum_comment_response.dart';
import '../../models/forum_model/forum_like_res.dart';
import '../../models/forum_model/forum_model.dart';
import '../../utils/constants.dart';
import '../../view/components.dart';
import '../services/app_shared_pref.dart';

class ForumProvider with ChangeNotifier {
  List<Forum> allPosts = [];
  List<Forum> myPosts = [];
  List<Widget> allPostImg = [];
  List<Widget> myPostsImgs = [];
  int forumInitialIndex = 0;
  
  //****************** Forums ********************************* */
  Future getAllForums() async {
    try {
      allPosts.clear();
      var response = await Dio().get('$baseURL/api/v1/forums',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ForumModel res = ForumModel.fromJson(response.data);
      print("All Posts: ${res.data?.length}");
      allPosts = [...?res.data];
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get All forums: $e");
    }
  }

  Future getMyForums() async {
    try {
      myPosts.clear();
      var response = await Dio().get('$baseURL/api/v1/forums/me',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ForumModel res = ForumModel.fromJson(response.data);
      myPosts = [...?res.data];
      print("My Posts: ${res.data?.length}");
      notifyListeners();
    } on DioError catch (e) {
      print("Error from get my forums: $e");
    }
  }

  Future<Forum?> getForumById({required String id}) async {
    try {
      var response = await Dio().get('$baseURL/api/v1/forums/$id',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ForumModel res = ForumModel.fromJson(response.data);
      print("Specific Posts: ${res.data.title}");
      return res.data;
    } catch (e) {
      print("error from getForumById :$e");
    }
    return null;
  }

  Future likePost(String forumId) async {
    try {
      var response = await Dio().post('$baseURL/api/v1/forums/$forumId/like',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      ForumLikeResponse res = ForumLikeResponse.fromJson(response.data);
      print('Liked successfully: ${res.data?.forumId}');
      Forum likedForum;
      likedForum =(await getForumById(id: forumId))!;
      notifyListeners();
      return likedForum;
    } on DioError catch (e) {
      print("Error from get forums like: ${e.response?.data['message']}");
    }
  }

  Future commentOnPost(String forumId, String comment) async {
    try {
      var response = await Dio().post('$baseURL/api/v1/forums/$forumId/comment',
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })),
          data: {"comment": comment});
      ForumCommentResponse res = ForumCommentResponse.fromJson(response.data);
      print('commented successfully: ${res.data?.comment}');
      notifyListeners();
      return res.data;
    } on DioError catch (e) {
      print("Error from commentOnPost: ${e.response!.data['message']}");
    }
  }

  Future addForum(
      {required String title,
      required String description,
      required String image}) async {
    try {
      Response response = await Dio().post("$baseURL/api/v1/forums",
          data: {
            "title": title,
            "description": description,
            "imageBase64": image
          },
          options: Options(
              headers: ({
            'Authorization': 'Bearer ${AppSharedPref.getToken()}'
          })));
      print('Forum Added successfully: ${response.data}');
      var retrievedPost = Forum.fromJson(response.data);
      print("retrievedForum fromJson => $retrievedPost");
      await getAllForums();
      await getMyForums();
      notifyListeners();
    } on DioError catch (e) {
      print('Error Adding forum: ${e.response!.data['message']}');
    }
  }

  Future fetchImage(List<Forum> postLis) async {
    for (var element in postLis) {
      if (element.imageUrl == null) {
        print('imgnull:');

        allPostImg.add(textForImageError());
      } else {
        try {
          String? url = element.imageUrl!.startsWith('/')
              ? "$baseURL${element.imageUrl}"
              : element.imageUrl;
          var response = await Dio().get(url!);

          if (response.statusCode == 200) {
            allPostImg.add(Image.network(url));
          } else {
            print('Error else:');
            allPostImg.add(textForImageError());
          }
        } catch (error) {
          print('Error loading image: $error');
          allPostImg.add(textForImageError());
        }
      }
    }
  }
}
