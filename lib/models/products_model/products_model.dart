import 'products.dart';

class ProductsModel {
  String? type;
  String? message;
  List<Products>? data;

  ProductsModel({this.type, this.message, this.data});

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        type: json['type'] as String?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
