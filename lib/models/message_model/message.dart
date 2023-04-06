class Message {
  String message;
  String userId;
  dynamic time;
  Message({
    required this.message,
    required this.time,
    required this.userId
  });
  // factory Message.fromJson(Map<String,dynamic>json)=>Message(
  //   message: json['message'],
  //   time: json['time'],
  //   userId: json['userId']);
 factory Message.fromJson(json)=>Message(
    message: json['message'],
    time: json['time'],
    userId: json['userId']);
  Map<String,dynamic> toJson(){
    return {
      'message':message,
      'time':time,
      'userId':userId
    };
  }
}
