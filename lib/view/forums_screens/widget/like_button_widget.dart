import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';

import '../../../controller/services/app_shared_pref.dart';
import '../../../models/forum_model/forum.dart';
import '../../../models/forum_model/forum_comment.dart';
import '../../../models/forum_model/forum_like.dart';
import '../../../utils/constants.dart';
import '../../../utils/screen_size_utils.dart';
import '../../components.dart';

class LikeButtonWidget extends StatefulWidget {
  Forum post;

  LikeButtonWidget({
    required this.post,
  });

  @override
  _LikeButtonWidgetState createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  TextEditingController commentContoller = TextEditingController();
  List<ForumComment>? comments;
  @override
  void initState() {
    super.initState();
    comments = widget.post.forumComments;
    print("comments from init :${comments?.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LikeButton(
          likeCount: widget.post.forumLikes?.length,
          isLiked: isPostLiked(widget.post),
          likeBuilder: (isLiked) {
            return Icon(
              Icons.thumb_up_outlined,
              color: isLiked ? defaultColor : Colors.grey,
            );
          },
          countBuilder: (count, isLiked, text) {
            print("countBuilder: $count");
            print("widet.post title: ${widget.post.title}");
            print("widet.post: ${widget.post.forumLikes?.length}");
            var color = Colors.grey;
            return Text(
          text,style: TextStyle(color: color),
            );
          },
          onTap: onLikeButtonTapped,
        ),
        SizedBox(
          width: screenWidth(context: context) * 0.05,
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet<void>(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  side: BorderSide(color: defaultColor, width: 3)),
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: screenHeigth(context: context) * 0.85,
                  color: lightGrey,
                  child: Center(
                      child: comments != 0
                          ? Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: comments?.length,
                                      padding: const EdgeInsets.only(top: 10),
                                      itemBuilder: ((context, idx) {
                                        DateTime createdDate = DateTime.parse(
                                            comments![idx].createdAt!);
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            leading: isCurrentUser(
                                                    commentUser:
                                                        comments![idx].userId)
                                                ?
                                                Image.asset(
                                                    "assets/images/A5.png",
                                                    fit: BoxFit.cover,
                                                    width: 51,
                                                    height: 51,
                                                  )
                                                : Image.asset(idx % 2 == 0
                                                    ? "assets/images/A3.png"
                                                    : "assets/images/A4.png"),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Container(
                                                  decoration: roundedContainer(
                                                      color: lightGrey),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          isCurrentUser(
                                                                  commentUser:
                                                                      comments![
                                                                              idx]
                                                                          .userId)
                                                              ? "${userProvider(context: context).currentUser!.firstName} ${userProvider(context: context).currentUser!.lastName}"
                                                              : idx % 2 == 0
                                                                  ? "Lina Walid"
                                                                  : "Edward Sam ",
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 17),
                                                        ),
                                                        SizedBox(
                                                          height: screenHeigth(
                                                                  context:
                                                                      context) *
                                                              0.015,
                                                        ),
                                                        Text(
                                                          "${comments![idx].comment}",
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: screenHeigth(
                                                          context: context) *
                                                      0.015,
                                                ),
                                                Text(
                                                  DateFormat('yyyy-MM-dd ')
                                                      .format(createdDate),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      })),
                                ),
                                Container(
                                  color: lightGrey,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                        left: screenWidth(context: context) *
                                            0.07),
                                    child: TextFormField(
                                      controller: commentContoller,
                                      decoration: InputDecoration(
                                          suffixIcon: commentContoller
                                                  .text.isEmpty
                                              ? null
                                              : IconButton(
                                                  onPressed: () async {
                                                    if (commentContoller
                                                        .text.isNotEmpty) {
                                                      comments?.add(
                                                          await forumProvider(
                                                                  context:
                                                                      context)
                                                              .commentOnPost(
                                                                  widget.post
                                                                      .forumId!,
                                                                  commentContoller
                                                                      .text));
                                                      setState(() {
                                                        print(
                                                            "comments List: ${comments?.length}");
                                                      });
                                                      Navigator.pop(context);
                                                      // await Navigator.of(
                                                      //         context)
                                                      //     .pushAndRemoveUntil(
                                                      //         MaterialPageRoute<
                                                      //                 void>(
                                                      //             builder:
                                                      //                 (context) =>
                                                      //                     const ShopLayout()),
                                                      //         (r) => false);
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.send,
                                                    color: defaultColor,
                                                  )),
                                          hintText: "Write a comment..."),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                const Expanded(
                                  child: Center(
                                      child: Text(
                                    "No replies to show yet",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                                Container(
                                  color: lightGrey,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                        left: screenWidth(context: context) *
                                            0.07),
                                    child: TextFormField(
                                      controller: commentContoller,
                                      decoration: InputDecoration(
                                          suffixIcon: commentContoller
                                                  .text.isEmpty
                                              ? null
                                              : IconButton(
                                                  onPressed: () async {
                                                    if (commentContoller
                                                        .text.isNotEmpty) {
                                                      comments?.add(
                                                          await forumProvider(
                                                                  context:
                                                                      context)
                                                              .commentOnPost(
                                                                  widget.post
                                                                      .forumId!,
                                                                  commentContoller
                                                                      .text));
                                                      setState(() {
                                                        print(
                                                            "comments List: ${comments?.length}");
                                                      });

                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.send,
                                                    color: defaultColor,
                                                  )),
                                          hintText: "Write a comment..."),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                );
              },
            ).whenComplete(() => commentContoller.clear());
          },
          child: Text(
            "${comments!.length} Replies",
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    widget.post = await forumProvider(context: context)
        .likePost("${widget.post.forumId!}");
    return !isLiked;
  }

  bool isPostLiked(Forum currentForum) {
    bool ispostLiked;
    ispostLiked = currentForum.forumLikes!
            .firstWhere(
                (element) => element.userId == AppSharedPref.getUserId(),
                orElse: (() => ForumLike()))
            .userId ==
        AppSharedPref.getUserId();
    setState(() {});
    return ispostLiked;
  }

  bool isCurrentUser({commentUser}) {
    return AppSharedPref.getUserId() == commentUser;
  }

}
