import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/controller/services/app_shared_pref.dart';
import 'package:flutter_hackathon/utils/product_utils.dart';

import '../../utils/constants.dart';

import '../../utils/screen_size_utils.dart';
import '../../utils/token_utils.dart';
import '../components.dart';
import 'add_forum.dart';
import 'widget/like_button_widget.dart';

class Forums extends StatefulWidget {
  const Forums({Key? key}) : super(key: key);

  @override
  State<Forums> createState() => _ForumsState();
}

class _ForumsState extends State<Forums> {
  TextEditingController searchController = TextEditingController();
  TextEditingController commentContoller = TextEditingController();

  String forumDate = "a month ago";
  String forumBody =
      "It is a long established fact that a reader will be distracted";

  String forumUserImage = "assets/images/A1.png";
  bool isInitialLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkToken(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("user id: ${AppSharedPref.getUserId()}");

    return Scaffold(
      extendBodyBehindAppBar: true,
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
              initialIndex: forumProvider(context: context).forumInitialIndex,
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
                      forumProvider(context: context).myPosts.isNotEmpty
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
      floatingActionButton: FloatingActionButton.small(
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
    );
  }

  Widget forums({
    required context,
    required String postType,
    forumDate,
  }) {
    return FutureBuilder(
      future: postType == "all"
          ? forumProvider(context: context).getAllForums()
          : forumProvider(context: context).getMyForums(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("${snapshot.error} occurred"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting &&
            isInitialLoading) {
          return Center(
              child: CircularProgressIndicator(
            color: defaultColor,
          ));
        } else {
          if (isInitialLoading) {
            isInitialLoading = false; // Set it to false after initial loading.
          }
          List posts = postType == "all"
              ? forumProvider(context: context).allPosts
              : forumProvider(context: context).myPosts;
          return GridView.count(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              children: List.generate(posts.length, (index) {
                // List<ForumLike>? postLikes = posts[index].forumLikes;
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
                                    width: screenWidth(context: context) * 0.02,
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
                                        style:
                                            const TextStyle(color: Colors.grey),
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
                              // child: textForImageError(),
                              child: (posts[index].imageUrl == null ||
                                      posts[index].imageUrl == "")
                                  ? Image.asset(
                                      "assets/images/plantForum.png",
                                      fit: BoxFit.fitHeight,
                                    )
                                  : FutureBuilder<bool>(
                                      future: checkImage(
                                        image: posts[index]
                                                .imageUrl!
                                                .startsWith('/')
                                            ? "$baseURL${posts[index].imageUrl}"
                                            : "${posts[index].imageUrl}",
                                      ),
                                      builder: (context, imageSnapshot) {
                                        if (imageSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircularProgressIndicator(),
                                            ],
                                          );
                                        } else if (imageSnapshot.hasError) {
                                          return textForImageError();
                                        } else if (imageSnapshot.data == true) {
                                          return Image.network(
                                            posts[index]
                                                    .imageUrl!
                                                    .startsWith('/')
                                                ? "$baseURL${posts[index].imageUrl}"
                                                : "${posts[index].imageUrl}",
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              print(
                                                  "image error: ${error.toString()}");
                                              return textForImageError();
                                            },
                                            width: double.infinity,
                                            fit: BoxFit.fitWidth,
                                          );
                                        } else {
                                          return textForImageError();
                                        }
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeigth(context: context) * 0.02,
                    ),
                    LikeButtonWidget(
                      // likeCount: postLikes!.length,
                      post: posts[index],
                    ),
                  ],
                );
              }));
        }
      }),
    );
  }

  bool isCurrentUser({commentUser}) {
    return AppSharedPref.getUserId() == commentUser;
  }
  @override
  void dispose() {
    searchController.dispose();
    commentContoller.dispose();
    super.dispose();
  }
}
