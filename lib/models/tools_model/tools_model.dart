import 'tool.dart';

class ToolsModel {
  String? type;
  String? message;
  List<Tool>? data;

  ToolsModel({this.type, this.message, this.data});

  factory ToolsModel.fromJson(Map<String, dynamic> json) => ToolsModel(
        type: json['type'] as String?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Tool.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
