import 'plants.dart';

class PlantsModel {
  String? type;
  String? message;
  List<Plants>? data;

  PlantsModel({this.type, this.message, this.data});

  factory PlantsModel.fromJson(Map<String, dynamic> json) => PlantsModel(
        type: json['type'] as String?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Plants.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
