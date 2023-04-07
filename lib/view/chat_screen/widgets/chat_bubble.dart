import 'package:flutter/material.dart';
import 'package:flutter_hackathon/utils/constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
     required this.message,
     required this.sentBy,
  }) : super(key: key);
  final String message;
  final String sentBy;
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
               child: Text(message,style: TextStyle(color: sentBy==sender?Colors.white:Colors.black),),
             ),
           ),
         );
        
  }
}