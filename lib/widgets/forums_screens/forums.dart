import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/components.dart';
import 'package:flutter_hackathon/widgets/forums_screens/add_forum.dart';
import 'package:like_button/like_button.dart';

import '../../constants.dart';

class Forums extends StatelessWidget {
  Forums({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();
  String forumUserName = "Mayar Mohamed";
  String forumDate = "a month ago";
  String forumTitle = "How To treat plants";
  String forumBody =
      "It is a long established fact that a reader will be distracted";
  int noOfReplies=2;
  String forumImage="assets/images/A1.png";
  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.only(top: 10,left: 10 ),
                    child: TabBar(
                        padding: const EdgeInsets.only(top: 8),
                        indicatorWeight: 3,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        indicator: ContainerTabIndicator(
                            radius: const BorderRadius.all(Radius.circular(5.0)),
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
                      forums(context: context,
                       forumUserName: "Khalid Mohamed",
                       forumDate: forumDate,
                       forumTitle: forumTitle,
                       forumBody: forumBody,
                       forumImage:forumImage),
                      forums(context: context,
                       forumUserName: forumUserName,
                        forumDate: forumDate,
                         forumTitle: forumTitle,
                          forumBody: forumBody,forumImage:"assets/images/A2.png"),
                    ]),
                  ),
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(onPressed: (){
        Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) => const AddForum(),
    ),);
      },
      child: const Icon(Icons.add),
      backgroundColor: defaultColor,),
    );
  }
  Widget forums({
    required context,
    required forumUserName,
    required forumDate,
    required forumTitle,
    required forumBody,
    required forumImage}){
    return GridView.count(
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        children: List.generate(5, (index) {
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
                                forumImage,
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
                          forumTitle,
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
                          forumBody,
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
                          child: Image.asset(
                        "assets/images/plantForum.png",
                        fit: BoxFit.fitHeight,
                      )),
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
                        var color =Colors.grey;
                        String text = count==0?"Likes":"Like";
                        return Text("$count $text",
                         style: TextStyle(color: color,fontWeight: FontWeight.bold),
                        );
                      }),
                      SizedBox(width: screenWidth(context: context)*0.05,),
                      Text("$noOfReplies Replies", style: const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),)
                ],
              ),
            ],
          );
        }));

  }
}
