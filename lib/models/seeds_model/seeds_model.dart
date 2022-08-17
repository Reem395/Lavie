import 'seeds.dart';

class SeedsModel {
  String? type;
  String? message;
  List<Seeds>? data;

  SeedsModel({this.type, this.message, this.data});

  factory SeedsModel.fromJson(Map<String, dynamic> json) => SeedsModel(
        type: json['type'] as String?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Seeds.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
