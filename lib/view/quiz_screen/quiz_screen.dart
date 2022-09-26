import 'package:flutter/material.dart';
import 'package:flutter_hackathon/utils/constants.dart';
import 'package:flutter_hackathon/view/shop_layout/shop_layout.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/my_provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

enum Answers { a1, a2, a3 }

Answers? userAnswer = Answers.a1;
String question = "What is the user experience ?";
String choice1 = "The user experience is how the developer feels about a user";
String choice2 =
    "The user experience is how the user feels about interacting with or experiencing a product";
String choice3 = "The user experience is the UX designer has about a product";

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Course Exam",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(6, 255, 255, 255),
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<MyProvider>(
          builder: ((context, myProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                          text: 'Question',
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      TextSpan(
                          text: ' ${myProvider.questionNo}',
                          style: TextStyle(
                              fontSize: 35,
                              color: defaultColor,
                              fontWeight: FontWeight.w500)),
                      const TextSpan(
                          text: '/10',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeigth(context: context) * 0.05,
                ),
                //-----------Ques Widget--------------------------
                SizedBox(
                  height: screenHeigth(context: context) * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        question,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            // gradient: sLinearColorBlue,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(color: defaultColor, width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                choice1,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )),
                              Radio(
                                  value: Answers.a1,
                                  groupValue: userAnswer,
                                  onChanged: (value) {
                                    setState(() {
                                      userAnswer = value as Answers?;
                                      print(userAnswer);
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            // gradient: sLinearColorBlue,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(color: defaultColor, width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                choice2,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )),
                              Radio(
                                  value: Answers.a2,
                                  groupValue: userAnswer,
                                  onChanged: (value) {
                                    setState(() {
                                      userAnswer = value as Answers?;
                                      print(userAnswer);
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(color: defaultColor, width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                choice3,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )),
                              Radio(
                                  value: Answers.a3,
                                  groupValue: userAnswer,
                                  onChanged: (value) {
                                    setState(() {
                                      userAnswer = value as Answers?;
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeigth(context: context) * 0.05,
                ),
                Row(
                  mainAxisAlignment: myProvider.questionNo > 1
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    if (myProvider.questionNo > 1)
                      ElevatedButton(
                        onPressed: () {
                          myProvider.previousQuestion();
                        },
                        child: const Text(
                          "Back",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal:
                                      screenWidth(context: context) * 0.18,
                                  vertical:
                                      screenHeigth(context: context) * 0.02)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(defaultColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: defaultColor, width: 1.5))),
                        ),
                      ),
                    SizedBox(
                      width: screenWidth(context: context) * 0.05,
                    ),
                    if (myProvider.questionNo == 1)
                      SizedBox(width: screenWidth(context: context) * 0.4488),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          myProvider.nextQuestion();
                          if (myProvider.questionNo == 11) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShopLayout()),
                              (Route<dynamic> route) => false,
                            );
                            myProvider.questionNo = 1;
                            myProvider.currentExamAccessDate();
                          }
                        },
                        child: Text(
                            myProvider.questionNo == 10 ? "Finish" : "Next"),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical:
                                        screenHeigth(context: context) * 0.02)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all(defaultColor)),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      )),
    );
  }
  // Widget displayQuiz(){
  //   return
  // }
}
