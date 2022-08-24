import 'package:flutter/material.dart';
import 'package:flutter_hackathon/models/plants_model/plants.dart';
import 'package:flutter_hackathon/view/blog_screens/single_blog_screen.dart';

import '../../models/tools_model/tool.dart';
import '../../utils/constants.dart';
import '../components.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List allBlogs = myProvider(context: context).allBlogs;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Blogs",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(6, 255, 255, 255),
          elevation: 0,
        ),
        body: SafeArea(
          child: ListView.builder(
              itemCount: allBlogs.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: roundedContainerWithShadowBox(),
                    child: InkWell(
                      onTap: (() {
                        String blogId;
                        String productType;
                        if (allBlogs[index] is Plants) {
                          blogId = allBlogs[index].plantId;
                          productType = "Plants";
                        } else if (allBlogs[index] is Tool) {
                          blogId = allBlogs[index].toolId;
                          productType = "Tool";
                        } else {
                          blogId = allBlogs[index].seedId;
                          productType = "Seeds";
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => SingleBlogScreen(
                              blogId: blogId,
                              productType: productType,
                            ),
                          ),
                        );
                      }),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    screenHeigth(context: context) / (926 / 14),
                                horizontal:
                                    screenWidth(context: context) / (428 / 11)),
                            child: allBlogs[index].imageUrl == ""
                                ? Image.asset("assets/images/plant_blog.png")
                                : roundedImage(
                                    image: Image.network(
                                      "$baseURL${allBlogs[index].imageUrl}",
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return textForImageError();
                                      },
                                      width: 146,
                                      height: 133,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "2 days ago",
                                  style: TextStyle(
                                      color: defaultColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: screenHeigth(context: context) /
                                      (926 / 14),
                                ),
                                Text(
                                  "${allBlogs[index].name}",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: screenHeigth(context: context) /
                                      (926 / 14),
                                ),
                                const Text(
                                  "leaf, in batany, any usually, leaf, in batany, any usually",
                                  style: TextStyle(
                                    height: 1.5,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })),
        ));
  }
}
