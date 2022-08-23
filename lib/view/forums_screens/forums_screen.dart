import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/view/components.dart';
import 'package:flutter_hackathon/models/forum_model/forum.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../controller/provider/my_provider.dart';
import 'add_forum.dart';

class Forums extends StatelessWidget {
  Forums({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();
  String forumUserName = "Mayar Mohamed";
  String forumDate = "a month ago";
  String forumTitle = "How To treat plants";
  String forumBody =
      "It is a long established fact that a reader will be distracted";
  int noOfReplies = 2;
  String forumUserImage = "assets/images/A1.png";
  String baseURL = "https://lavie.orangedigitalcenteregypt.com";

  @override
  Widget build(BuildContext context) {
    List<Forum> allPosts =
        Provider.of<MyProvider>(context, listen: false).allPosts;
    List<Forum> myPosts =
        Provider.of<MyProvider>(context, listen: false).myPosts;
    print("allposts len: ${allPosts.length}");
    print("myPosts len: ${myPosts.length}");
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
                            borderWidth: 2.0,
                            borderColor: defaultColor,
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
                          forumUserName: "Khalid Mohamed",
                          posts: allPosts,
                          forumDate: forumDate,
                          forumUserImage: forumUserImage),
                      forums(
                          context: context,
                          forumUserName: forumUserName,
                          posts: myPosts,
                          forumDate: forumDate,
                          forumUserImage: "assets/images/A5.png"),
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
    required List<Forum> posts,
    required String forumUserImage,
    forumUserName,
    forumDate,
  }) {
    return GridView.count(
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        children: List.generate(posts.length, (index) {
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
                              child: Image.asset(
                                forumUserImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth(context: context) * 0.02,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  forumUserName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  forumDate,
                                  style: const TextStyle(color: Colors.grey),
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
                        child: (posts[index].imageUrl == null ||
                                posts[index].imageUrl == "")
                            ? Image.asset(
                                "assets/images/plantForum.png",
                                fit: BoxFit.fitHeight,
                              )
                            : Image.network(
                                posts[index].imageUrl!.startsWith('/')
                                    ? "$baseURL${posts[index].imageUrl}"
                                    : "${posts[index].imageUrl}",
                                width: double.infinity,
                                fit: BoxFit.fitWidth,
                                errorBuilder: (context, error, stackTrace) {
                                  return textForImageError();
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
              Row(
                children: [
                  LikeButton(
                      likeBuilder: ((isLiked) {
                        return Icon(Icons.thumb_up_outlined,
                            color: isLiked ? defaultColor : Colors.grey);
                      }),
                      likeCount: 0,
                      countBuilder: (count, isLiked, text) {
                        var color = Colors.grey;
                        String text = count == 0 ? "Likes" : "Like";
                        return Text(
                          "$count $text",
                          style: TextStyle(
                              color: color, fontWeight: FontWeight.bold),
                        );
                      }),
                  SizedBox(
                    width: screenWidth(context: context) * 0.05,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "$noOfReplies Replies",
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          );
        }));
  }
}
