import 'forum.dart';

class ForumModel {
  String? type;
  String? message;
  dynamic data;

  ForumModel({this.type, this.message, this.data});

  // factory ForumModel.fromJson(Map<String, dynamic> json) => ForumModel(
  //       type: json['type'] as String?,
  //       message: json['message'] as String?,
  //       data: (json['data'] as List<dynamic>?)
  //           ?.map((e) => Forum.fromJson(e as Map<String, dynamic>))
  //           .toList(),
  //     );
  factory ForumModel.fromJson(Map<String, dynamic> json) => ForumModel(
        type: json['type'] as String?,
        message: json['message'] as String?,
        data: _parseData(json['data']),
      );
      static dynamic _parseData(dynamic data) {
  if (data is List) {
    // If the data is a List, map each item to a Forum object
    return data.map((e) => Forum.fromJson(e as Map<String, dynamic>)).toList();
  } else if (data is Map<String, dynamic>) {
    // If the data is a Map, convert it to a single Forum object
    return Forum.fromJson(data);
  } else {
    // Handle other cases as needed
    return null; // Or handle error case
  }
}

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
