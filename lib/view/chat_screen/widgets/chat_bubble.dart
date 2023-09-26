import 'package:flutter/material.dart';
import 'package:flutter_hackathon/utils/constants.dart';

import '../../../utils/screen_utils.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
     required this.message,
     required this.sentBy,
     this.userName,
  }) : super(key: key);
  final String message;
  final String sentBy;
  final String? userName;
  @override
  Widget build(BuildContext context) {
             return Align(
           alignment:sentBy==reciever? Alignment.centerLeft:Alignment.centerRight,
           child: Container(
            constraints: BoxConstraints(maxWidth: screenWidth(context: context)*0.5,minHeight: screenHeigth(context: context)*0.045),
             margin:const EdgeInsets.all(10),
             decoration: BoxDecoration(
               color: sentBy==sender?Colors.green:Colors.green[200],
               borderRadius: BorderRadius.only(
                 topLeft: const Radius.circular(10),
                 topRight:const  Radius.circular(10),
                 bottomLeft: Radius.circular(sentBy==sender?10:0),
                 bottomRight: Radius.circular(sentBy==reciever?10:0),
                 )),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                  sentBy==reciever?Text(userName!,style:const TextStyle(fontSize: 16.5,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 70, 43, 33)),):const SizedBox(),   
                   SizedBox(height: screenHeigth(context: context)*0.005,),
                   Text(message,style: TextStyle(fontSize: 15.5, color: sentBy==sender?Colors.white:Colors.black),),
                 ],
               ),
             ),
           ),
         );
        
  }
}