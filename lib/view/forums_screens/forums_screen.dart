import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/controller/services/app_shared_pref.dart';
import 'package:flutter_hackathon/models/forum_model/forum_comment.dart';
import 'package:like_button/like_button.dart';
import 'package:intl/intl.dart';

import '../../models/forum_model/Forum.dart';
import '../../models/forum_model/forum_like.dart';
import '../../utils/constants.dart';

import '../chat_screen/chat_screen.dart';
import '../components.dart';
import '../shop_layout/shop_layout.dart';
import 'add_forum.dart';

class Forums extends StatefulWidget {
  Forums({Key? key}) : super(key: key);

  @override
  State<Forums> createState() => _ForumsState();
}

class _ForumsState extends State<Forums> {
  TextEditingController searchController = TextEditingController();
  TextEditingController commentContoller = TextEditingController();
  // String comment="";
  String forumDate = "a month ago";
  String forumBody =
      "It is a long established fact that a reader will be distracted";

  String forumUserImage = "assets/images/A1.png";
  // late List<Forum> allPosts;
  // late List<Forum> myPosts;
  // late Future getAllPosts;
  // late Future getMyPosts;
  // bool _showSendButton=false;

  // Widget? _getSendButton() {
  //    commentContoller.addListener(() {
  //     setState(() {
  //       _showSendButton = commentContoller.text.isNotEmpty;
  //     });
  //   });
  //   if (!_showSendButton) {
  //     return null;
  //   }

  //   return IconButton(
  //     onPressed: () => commentContoller.clear(),
  //     icon: Icon(Icons.send,color: defaultColor,),
  //   );
  // }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkToken(context);
    });
  }

  List<Widget> imgs = [];
  @override
  Widget build(BuildContext context) {
    print("user id: ${AppSharedPref.getUserId()}");

    return Scaffold(
      extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Discussion Forums",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(6, 255, 255, 255),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchBar(searchController: searchController),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: TabBar(
                        padding: const EdgeInsets.only(top: 8),
                        indicatorWeight: 3,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        indicator: ContainerTabIndicator(
                            radius:
                                const BorderRadius.all(Radius.circular(5.0)),
                            color: defaultColor,
                            width: screenWidth(context: context) * 0.3,
                            height: screenHeigth(context: context) * 0.04,
                            padding: const EdgeInsets.symmetric(horizontal: 8)),
                        tabs: const [
                          Tab(
                            child: Text(
                              "All Forums",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "My Forums",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: (screenHeigth(context: context) -
                            MediaQuery.of(context).padding.top) *
                        0.04,
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      forums(
                        context: context,
                        postType: "all",
                        forumDate: forumDate,
                      ),
                      myProvider(context: context).myPosts.isNotEmpty
                          ? forums(
                              context: context,
                              postType: "my",
                              forumDate: forumDate,
                            )
                          : const Center(
                              child: Text(
                                "No Posts yets",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            )
                    ]),
                  ),
                ],
              )),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: "btn1",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ChatScreen(),
                ),
              );
            },
            child: const Icon(Icons.chat),
            backgroundColor: defaultColor,
          ),
          FloatingActionButton.small(
            heroTag: "btn2",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const AddForum(),
                ),
              );
            },
            child: const Icon(Icons.add),
            backgroundColor: defaultColor,
          ),
        ],
      ),
    );
  }

  bool isLiked(Forum currentForum) {
    return currentForum.forumLikes!
            .firstWhere(
                (element) => element.userId == AppSharedPref.getUserId(),
                orElse: (() => ForumLike()))
            .userId ==
        AppSharedPref.getUserId();
  }

  Widget forums({
    required context,
    required String postType,
    forumDate,
  }) {
    return FutureBuilder(
      future: postType == "all"
          ? myProvider(context: context).getAllForums()
          : myProvider(context: context).getMyForums(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error} occurred"),
            );
          } else if (!snapshot.hasError) {
            List posts = postType == "all"
                ? myProvider(context: context).allPosts
                : myProvider(context: context).myPosts;
            // List posts = myProvider(context: context).allPosts;

            return GridView.count(
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                children: List.generate(posts.length, (index) {
                  List<ForumLike>? postLikes = posts[index].forumLikes;
                  return Column(
                    children: [
                      Expanded(
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromARGB(255, 211, 201, 201))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child:
                                          //  posts[index].user!.imageUrl != null?
                                          // roundedImage(
                                          //     raduis: 50,
                                          //     image: Image.network(
                                          //       "${posts[index].user!.imageUrl}",
                                          //       errorBuilder: (context, error,
                                          //           stackTrace) {
                                          //             print("image eror: ${error.toString()}");
                                          //         return Image.asset(
                                          //           forumUserImage,
                                          //           fit: BoxFit.cover,
                                          //         );
                                          //       },
                                          //     ))
                                          // :
                                          Image.asset(
                                        postType == "my"
                                            ? 'assets/images/A5.png'
                                            : index % 2 == 0
                                                ? forumUserImage
                                                : 'assets/images/A2.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          screenWidth(context: context) * 0.02,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${posts[index].user!.firstName} ${posts[index].user!.lastName}",
                                          maxLines: 1,
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          forumDate,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenHeigth(context: context) * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  posts[index].title!,
                                  style: TextStyle(
                                      color: defaultColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              SizedBox(
                                height: screenHeigth(context: context) * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  posts[index].description ?? forumBody,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                ),
                              ),
                              SizedBox(
                                height: screenHeigth(context: context) * 0.02,
                              ),
                              Expanded(
                                child: textForImageError(),
                                // child:
                                //  (posts[index].imageUrl == null ||
                                //         posts[index].imageUrl == "")
                                //     ? Image.asset(
                                //         "assets/images/plantForum.png",
                                //         fit: BoxFit.fitHeight,
                                //       )
                                //     : Image.network(
                                //         posts[index].imageUrl!.startsWith('/')
                                //             ? "$baseURL${posts[index].imageUrl}"
                                //             : "${posts[index].imageUrl}",
                                //         errorBuilder:
                                //             (context, error, stackTrace) {
                                //           print(
                                //               "image error: ${error.toString()}");
                                //           return textForImageError();
                                //         },

                                //         width: double.infinity,
                                //         fit: BoxFit.fitWidth,
                                //       ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeigth(context: context) * 0.02,
                      ),
                      Row(
                        children: [
                          LikeButton(
                              onTap: (liked) async {
                                print("post Id :${posts[index].forumId}");
                                setState(() {
                                  print("after liked");
                                });
                                // }
                                await myProvider(context: context)
                                    .likePost("${posts[index].forumId!}");
                                print(" liked : $liked");
                                return !liked;
                              },
                              likeBuilder: ((liked) {
                                liked = isLiked(posts[index]);
                                // print("lik $liked");
                                return Icon(Icons.thumb_up_outlined,
                                    color: liked ? defaultColor : Colors.grey);
                              }),
                              likeCount: postLikes!.length,
                              countBuilder: (count, liked, text) {
                                var color = Colors.grey;
                                String text = count == 1 ? "Like" : "Likes";
                                return Text(
                                  "$count $text",
                                  style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.bold),
                                );
                              }),
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
                                    side: BorderSide(
                                        color: defaultColor, width: 3)),
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height:
                                        screenHeigth(context: context) * 0.85,
                                    color: lightGrey,
                                    child: Center(
                                        child:
                                            posts[index]
                                                        .forumComments!
                                                        .length !=
                                                    0
                                                ? Column(
                                                    children: [
                                                      Expanded(
                                                        child: ListView.builder(
                                                            itemCount: posts[
                                                                    index]
                                                                .forumComments!
                                                                .length,
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10),
                                                            itemBuilder:
                                                                ((context,
                                                                    idx) {
                                                              DateTime
                                                                  createdDate =
                                                                  DateTime.parse(posts[
                                                                          index]
                                                                      .forumComments![
                                                                          idx]
                                                                      .createdAt!);
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: ListTile(
                                                                  leading: isCurrentUser(
                                                                          commentUser: posts[index]
                                                                              .forumComments![
                                                                                  idx]
                                                                              .userId)
                                                                      ?
                                                                      //reem
                                                                      Image
                                                                          .asset(
                                                                          "assets/images/A5.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          width:
                                                                              51,
                                                                          height:
                                                                              51,
                                                                        )
                                                                      // Image
                                                                      //     .network(
                                                                      //     myProvider(context: context)
                                                                      //         .currentUser!
                                                                      //         .imageUrl!,
                                                                      //     width:
                                                                      //         61,
                                                                      //     height:
                                                                      //         61,
                                                                      //   )
                                                                      : Image.asset(idx % 2 ==
                                                                              0
                                                                          ? "assets/images/A3.png"
                                                                          : "assets/images/A4.png"),
                                                                  title: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .stretch,
                                                                    children: [
                                                                      Container(
                                                                        decoration:
                                                                            roundedContainer(color: lightGrey),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(10.0),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                isCurrentUser(commentUser: posts[index].forumComments![idx].userId)
                                                                                    ? "${myProvider(context: context).currentUser!.firstName} ${myProvider(context: context).currentUser!.lastName}"
                                                                                    : idx % 2 == 0
                                                                                        ? "Lina Walid"
                                                                                        : "Edward Sam ",
                                                                                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                                                                              ),
                                                                              SizedBox(
                                                                                height: screenHeigth(context: context) * 0.015,
                                                                              ),
                                                                              Text(
                                                                                "${posts[index].forumComments![idx].comment}",
                                                                                style: const TextStyle(fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: screenHeigth(context: context) *
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
                                                              bottom: MediaQuery
                                                                      .of(
                                                                          context)
                                                                  .viewInsets
                                                                  .bottom,
                                                              left: screenWidth(
                                                                      context:
                                                                          context) *
                                                                  0.07),
                                                          child: TextFormField(
                                                            controller:
                                                                commentContoller,
                                                            decoration:
                                                                InputDecoration(
                                                                    suffixIcon: commentContoller
                                                                            .text
                                                                            .isEmpty
                                                                        ? null
                                                                        : IconButton(
                                                                            onPressed:
                                                                                () async {
                                                                              if (commentContoller.text.isNotEmpty) {
                                                                                myProvider(context: context).commentOnPost(posts[index].forumId!, commentContoller.text);
                                                                                await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<void>(builder: (context) => ShopLayout()), (r) => false);
                                                                                myProvider(context: context).selectedIndex = 0;
                                                                              }
                                                                            },
                                                                            icon:
                                                                                Icon(
                                                                              Icons.send,
                                                                              color: defaultColor,
                                                                            )),
                                                                    hintText:
                                                                        "Write a comment..."),
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
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )),
                                                      ),
                                                      Container(
                                                        color: lightGrey,
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              bottom: MediaQuery
                                                                      .of(
                                                                          context)
                                                                  .viewInsets
                                                                  .bottom,
                                                              left: screenWidth(
                                                                      context:
                                                                          context) *
                                                                  0.07),
                                                          child: TextFormField(
                                                            controller:
                                                                commentContoller,
                                                            decoration:
                                                                InputDecoration(
                                                                    suffixIcon: commentContoller
                                                                            .text
                                                                            .isEmpty
                                                                        ? null
                                                                        : IconButton(
                                                                            onPressed:
                                                                                () async {
                                                                              if (commentContoller.text.isNotEmpty) {
                                                                                myProvider(context: context).commentOnPost(posts[index].forumId!, commentContoller.text);
                                                                                await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute<void>(builder: (context) => ShopLayout()), (r) => false);
                                                                                myProvider(context: context).selectedIndex = 0;
                                                                              }
                                                                            },
                                                                            icon:
                                                                                Icon(
                                                                              Icons.send,
                                                                              color: defaultColor,
                                                                            )),
                                                                    hintText:
                                                                        "Write a comment..."),
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
                              "${posts[index].forumComments!.length} Replies",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }));
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }

  bool isCurrentUser({commentUser}) {
    return AppSharedPref.getUserId() == commentUser;
  }
}
