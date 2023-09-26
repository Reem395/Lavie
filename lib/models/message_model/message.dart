
class Message {
  String message;
  String userId;
  String userName;
  String deviceToken;
  dynamic  time;
  Message({
    required this.message,
    required this.time,
    required this.userId,
    required this.userName,
    required this.deviceToken,
  });
  // factory Message.fromJson(Map<String,dynamic>json)=>Message(
  //   message: json['message'],
  //   time: json['time'],
  //   userId: json['userId']);
 factory Message.fromJson(json)=>Message(
    message: json['message'],
    time: json['time'],
    userId: json['userId'],
    deviceToken: json['deviceToken'],
    userName: json['userName']);
  Map<String,dynamic> toJson(){
    return {
      'message':message,
      'time':time,
      'userId':userId,
      'userName':userName,
      'deviceToken':deviceToken
    };
  }
}
